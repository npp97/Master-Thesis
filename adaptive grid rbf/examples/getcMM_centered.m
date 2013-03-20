function cMFSP = getcMM_centered(varargin)

%% CHECK / ASSIGN INPUTS
% Check required inputs
if nargin >= 3
    if ~isempty(varargin{1})
        % Assign inputs
        system = varargin{1};
        xmin = varargin{2};
        xmax = varargin{3};
    else
        % Error message:
        error('The first input must be non-empty!');   
    end
else
    % Error message:
    error('At least three input is required!');
end

% Set default bounds
if isempty(xmin)
    xmin = floor(system.state.xmin);
end
if isempty(xmax)
    xmax = floor(system.state.xmax);
end

% Check for additional constraints g(x) == 1
g = [];
if nargin >= 4
    g = varargin{4};
end
if isempty(g)
    g = @(x) 1;
end

% Options
options.moment_order = 2;
options.moment_closure = 'mean field';
options.filename = 'MCM_res';
if nargin >= 5
    options = setdefault(varargin{5},options);
end

%% INITIALIZATION
n_s = length(system.state.variable);
n_r = length(system.reaction);
n_c = length(system.parameter.variable);

%% INITIALIZE ROUTINE
% Boundaries
xmin = max(max([floor(xmin),floor(system.state.xmin)],[],2),0);
xmax =     min([ ceil(xmax), ceil(system.state.xmax)],[],2);

% Idenification of species
y_ind = find(strcmp(system.state.type,'stochastic')); n_y = length(y_ind);
z_ind = find(strcmp(system.state.type,'moment'));     n_z = length(z_ind);
% Reindexingy
system.state.variable = system.state.variable([y_ind;z_ind]);
system.state.type     = system.state.type([y_ind;z_ind]);
system.state.name     = system.state.name([y_ind;z_ind]);
system.state.xmin     = system.state.xmin([y_ind;z_ind]);
system.state.xmax     = system.state.xmax([y_ind;z_ind]);

% Trunctation
ymin = xmin(y_ind);
ymax = xmax(y_ind);
max_index = prod(ymax-ymin+1);
[~,ind] = sort([y_ind;z_ind]);
g = @(X) g(X(ind)) && system.state.constraint(X(ind));

%% GENERATE STATE INDEX SET:
% Note: The states of the FSP are ordered according to the index set.

% Initialize index matrix:
y_index = zeros(max_index,n_y);
% Initialize state
ind = ymin;
% Construct index matrix
for i = 1:prod(ymax-ymin+1)
    % Assign index
    y_index(i,:) = ind';
    % Uypdate current index:
    j = min(setdiff(1:n_y,find(ind == ymax))); % index which is updated
    ind(j) = ind(j) + 1; 
    ind(1:j-1) = ymin(1:j-1); % reset of all previous indexes
end

% Truncate index such that only the indexes which fulfill g(x) <= 0
% are contained:
ind = [];
% Construct index matrix
for i = 1:max_index
    % Evaluate g
    I = [y_index(i,:)';zeros(n_z,1)];
    if g(I)
        ind = [ind;i];
    end
end
% Assign indexes which fulfill constraint
y_index = y_index(ind,:);

% Number of states of FSP:
n_y_index = size(y_index,1);

%% CONSTRUCTION OF STATE VECTOR AND PARAMETER VECTOR
% Conditional expectation
[M_ind,n_M] = getMomentIndexSet(n_z,options.moment_order+2);
% moments described by model
mu_ind = M_ind(find(sum(M_ind>=1,2) == 1),:);
C_ind  = M_ind(find((2 <= sum(M_ind>=1,2)).*(sum(M_ind>=1,2) <= options.moment_order)),3:end);
n_C = size(C_ind,1);
% higher order moments
hoC_ind = M_ind(find(sum(M_ind>=1,2) >  options.moment_order),:);
n_hoC = size(hoC_ind,1);

% State vector
M = sym(zeros((1+n_z+n_C)*n_y_index,1));
% Loop: discrete states
for iy = 1:n_y_index
    % Name of discrete state
    y_index_str{iy} = ['_y' strrep(num2str(y_index(iy,:),'_%d'),' ','')];

    % Marginal probability
    p(iy) = sym(['p' y_index_str{iy}]);
    % Conditional mean
    mu{iy}  = getMu(mu_ind,y_index_str{iy});
    % Conditional central moments of order >= 2
    C{iy}   = getC(C_ind  ,y_index_str{iy});
    hoC{iy} = getC(hoC_ind,y_index_str{iy});
    
    % Vector of states
    M(iy) = p(iy);
    M((n_z+n_C)*(iy-1)+n_y_index    +[1:n_z]) = mu{iy};
    M((n_z+n_C)*(iy-1)+n_y_index+n_z+[1:n_C]) = C{iy};

    hoM((iy-1)*n_hoC+[1:n_hoC]) = hoC{iy};
end

% Derivative vector
dMdt = sym(zeros((1+n_z+n_C)*n_y_index,1));
for i = 1:length(M)
    dMdt(i) = sym(['d' char(M(i)) 'dt']);
end

% Parameters
c = sym(zeros(n_c,1));
for i = 1:n_c
    c(i) = sym(['c' num2str(i,'%d')]);
end

%% REACTION STOICHIOMETRY
S_e = zeros(n_s,n_r);
S_p = zeros(n_s,n_r);
% Loop: reatcions
for j = 1:n_r
    % Loop: educts
    for i = 1:length(system.reaction(j).educt)
        ind = find(system.state.variable == system.reaction(j).educt(i));
        S_e(ind,j) = S_e(ind,j) + 1;
    end
    % Loop: products
    for i = 1:length(system.reaction(j).product)
        ind = find(system.state.variable == system.reaction(j).product(i));
        S_p(ind,j) = S_p(ind,j) + 1;
    end
end
% Overall reaction stoichiometry
S = S_p - S_e;

% Check reaction order
if max(sum(S_e,1)) >= 3
    error('At most bimolecular reactions are allowed.');
end

% Individual reaction stoichiometry
S_y  = S(1:n_y,:);
S_ey = S_e(1:n_y,:);
S_z  = S(n_y+1:end,:);
S_ez = S_e(n_y+1:end,:);

%% ASSIGN PROPENSITIES AND COMPUTE DERIVATIVES
% Moment states
z = sym(zeros(n_z,1));
for i = 1:n_z
    z(i) = sym(['z' num2str(i,'%d')]);
end

% Loop: reactions
for j = 1:n_r
    
    term{j} = sym([]);
    L{j} = [];
    
    % c
    rate(j) = subs(system.reaction(j).parameter,system.parameter.variable,c);
    
    % h_y(y)
    switch max(S_ey(:,j))
        case 0
            hy{j} = @(y) 1;  
        case 1
            ind = find(S_ey(:,j)==1);
            if length(ind) == 1 
                hy{j} = @(y) y(ind);
            else
                hy{j} = @(y) y(ind(1))*y(ind(2));
            end
        case 2
            ind = find(S_ey(:,j)==2);
            hy{j} = @(y) y(ind)*(y(ind)-1);
    end
    
    % h_z(z)
    switch max(S_ez(:,j))
        case 0
            hz{j} = 1;
        case 1
            ind = find(S_ez(:,j)==1);
            if length(ind) == 1 
                hz{j} = z(ind);
            else
                hz{j} = z(ind(1))*z(ind(2));
            end
        case 2
            ind = find(S_ez(:,j)==2);
            hz{j} = z(ind)*(z(ind)-1);
    end
    dhzdz{j} = simplify(jacobian(hz{j},z));
    d2hzdz2{j} = simplify(hessian(hz{j},z));

    % 
    term{j}(1) = hz{j};
    L{j}(1,1:2) = 0;
    for k = 1:n_z
        term{j}(end+1) = dhzdz{j}(k);
        L{j}(end+1,1:2) = [0,k];
    end
    for k = 1:n_z
        for l = k:n_z
            if k == l
                term{j}(end+1) = 0.5*d2hzdz2{j}(k,l);
            else
                term{j}(end+1) =     d2hzdz2{j}(k,l);
            end
            L{j}(end+1,1:2) = [k,l];
        end
    end
    
    % Reduction to non-zero terms
    ind = [];
    for k = 1:length(term{j})
        if ~strcmp(char(term{j}(k)),'0')
            ind = [ind,k];
        end
    end
    term{j} = term{j}(ind);
    L{j} = L{j}(ind,:);
    
    % Function to evaluate expectation
    E_CI_hz{j} = @(I,str) subs(term{j},z,getMu(mu_ind,str)) * getC(sort([L{j},repmat(I,size(L{j},1),1)],2),str);
end

%% CONSTRUCTION OF DERIVATIVES
% Stochastic states
dpdt   = sym(zeros(    n_y_index,1));
pdmudt = sym(zeros(n_z*n_y_index,1));
pdCdt  = sym(zeros(n_C*n_y_index,1));
% Loop: index
for iy = 1:n_y_index
    
    %% MARGINAL PROBABILITIES
    % Loop: reactions
    for j = 1:n_r
        % Sum 1
        y_  = y_index(iy,:)'-S_y(:,j);
        iy_ = getRowInMat(y_index,y_);
        % Check if initial state is in reachable set of CME
        if ~isempty(iy_)
            sy_ = y_index_str{iy_};
            dpdt(iy) = dpdt(iy) + rate(j)*hy{j}(y_)*E_CI_hz{j}([],sy_)*p(iy_);
        end
        
        % Sum 2
        y  = y_index(iy,:)';
        sy = y_index_str{iy};
        dpdt(iy) = dpdt(iy) - rate(j)*hy{j}(y)*E_CI_hz{j}([],sy)*p(iy);
    end   
    
    %% CONDITIONAL MEANS
    % Loop: reactions
    for j = 1:n_r
        % Sum 1
        y_  = y_index(iy,:)'-S_y(:,j);
        iy_ = getRowInMat(y_index,y_);
        % Check if initial state is in reachable set of CME
        if ~isempty(iy_)
            sy_ = y_index_str{iy_};
            % Loop: conditional means
            for iz = 1:n_z
                pdmudt(n_z*(iy-1)+iz) = pdmudt(n_z*(iy-1)+iz) ...
                    + rate(j)*hy{j}(y_)*(E_CI_hz{j}(iz,sy_)+(getMu(iz,sy_)+S_z(iz,j))*E_CI_hz{j}([],sy_))*p(iy_);
            end
        end
        
        % Sum 2
        y  = y_index(iy,:)';
        sy = y_index_str{iy};
        % Loop: conditional means
        for iz = 1:n_z
            pdmudt(n_z*(iy-1)+iz) = pdmudt(n_z*(iy-1)+iz) ...
                - rate(j)*hy{j}(y)*(E_CI_hz{j}(iz,sy)+getMu(iz,sy)*E_CI_hz{j}([],sy))*p(iy);
        end
    end
    
    % Component 3
    for iz = 1:n_z
        pdmudt(n_z*(iy-1)+iz) = pdmudt(n_z*(iy-1)+iz) ...
            - getMu(iz,sy)*dpdt(iy);
    end
    
    %% CONDITIONAL CENTRAL MOMENTS
    % Loop: reactions
    for j = 1:n_r
        % Sum 1
        y_  = y_index(iy,:)'-S_y(:,j);
        iy_ = getRowInMat(y_index,y_);
        % Check if initial state is in reachable set of CME
        if ~isempty(iy_)
            sy_ = y_index_str{iy_};
            % Loop: conditional central moments
            for iC = 1:n_C
                % Assignment of I-index and alpha-index
                I_I = C_ind(iC,find(C_ind(iC,:)~=0));
                I_alpha = getAlphaIndex(I_I,n_z);
                % Generation of combinations
                [K_alpha,K_I] = getLset(I_I,n_z,'full');
                % Loop: combination
                for k = 1:size(K_alpha,1)
                    k_I = K_I(k,find(K_I(k,:)~=0));
                    k_alpha = K_alpha(k,:);
                    % Prefactor
                    s = nchoosek_vec(I_alpha,k_alpha)*prod((mu{iy_}-mu{iy}+S_z(:,j)).^(I_alpha(:)-k_alpha(:)));
                    pdCdt(n_C*(iy-1)+iC) = pdCdt(n_C*(iy-1)+iC) ...
                        + rate(j)*s*hy{j}(y_)*E_CI_hz{j}(k_I,sy_)*p(iy_);
                end
            end
        end
        
        % Sum 2
        y  = y_index(iy,:)';
        sy = y_index_str{iy};
        % Loop: conditional central moments
        for iC = 1:n_C
            pdCdt(n_C*(iy-1)+iC) = pdCdt(n_C*(iy-1)+iC) ...
                - rate(j)*hy{j}(y)*E_CI_hz{j}(C_ind(iC,:),sy)*p(iy);
        end
    end
    
    % Sum 3
    % Loop: conditional central moments
    for iC = 1:n_C
        % Assignment of I-index and alpha-index
        I_I = C_ind(iC,:);
        I_alpha = getAlphaIndex(I_I,n_z);
        % Set of variable which are contained
        Iz = find(I_alpha >= 1);
        % Loop: high-abundance species with I_i >= 1
        for iz = Iz(:)'
            iz_ = find(I_I==iz,1);
            I_I_eiz = I_I([1:iz_-1,iz_+1:end]);
            pdCdt(n_C*(iy-1)+iC) = pdCdt(n_C*(iy-1)+iC) ...
                - I_alpha(iz)*getC(I_I_eiz,sy)*pdmudt(n_z*(iy-1)+iz)*p(iy);
        end
    end

    % Sum 4
    % Loop: conditional central moments
    for iC = 1:n_C
        pdCdt(n_C*(iy-1)+iC) = pdCdt(n_C*(iy-1)+iC) ...
            - getC(C_ind(iC,:),sy)*dpdt(iy);
    end
        
end

% Simplification of right-hand side
dpdt = simplify(dpdt);
pdmudt = simplify(pdmudt);
pdCdt = simplify(pdCdt);

%% MOMENT CLOSURE
% Higher order moments contained in equations
hoC_used = transpose(setdiff(symvar([dpdt;pdmudt;pdCdt]),[c;M]));
if ~isempty(hoC_used)
    disp('Moment-closure used!')
end
choC = sym(zeros(length(hoC_used),1));
% Loop: higher order moments
for i = 1:length(hoC_used)
    switch options.moment_closure
        case 'low-dispersion'
            choC(i) = 0;
%         case 'log-normal'
%             % Assessment of index
%             k = find(hoM == hoC_used(i));
%             kC = mod(k,n_hoC);
%             ky = (k - kC)/n_hoC + 1;
%             sy = y_index_str{ky};
%             % Index set
%             I = hoC_ind(kC,:);
%             I = I(find(I>=1));
%             % Assignment of closure
%             if length(I) >= 4
%                 error('This case is not implemented yet.');
%             else
%                 muCi = getMu(I',sy);
%                 nom = [getC(I([1,2]),sy) + muCi(1)*muCi(2);...
%                        getC(I([1,3]),sy) + muCi(1)*muCi(3);...
%                        getC(I([2,3]),sy) + muCi(2)*muCi(3)];
%                 choC(i) = prod(nom./muCi);
%                 %choC(i) = prod(getC([I([1,2]);I([1,3]);I([2,3])],sy)./getMu(I',sy));
%             end
        otherwise
            error('This option is not available.');
    end
end
% Substitution
dpdt   = simplify(subs(dpdt  ,hoC_used,choC));
pdmudt = simplify(subs(pdmudt,hoC_used,choC));
if n_C >= 1
    pdCdt  = simplify(subs(pdCdt,hoC_used,choC));
end

%% CONSTRUCTION OF VECTOR FIELD, MASS MATRIX, AND RESIDUAL FUNCTION - STATES
VFsym = dpdt;
MMsym = sym(ones(n_y_index,1));
for iy = 1:n_y_index 
    VFsym((n_z+n_C)*(iy-1)+n_y_index    +[1:n_z]) = pdmudt(n_z*(iy-1)+[1:n_z]);
    VFsym((n_z+n_C)*(iy-1)+n_y_index+n_z+[1:n_C]) = pdCdt(n_C*(iy-1)+[1:n_C]);
    MMsym((n_z+n_C)*(iy-1)+n_y_index +[1:n_z+n_C]) = p(iy);
end
VFsym = simplify(VFsym);
VFsym = collect(VFsym);

RESsym = -MMsym.*dMdt + VFsym;

%% CONVERSION TO EXECUTABLE FUNCTION - STATES
% Write function
str_VF = '@(x,theta) [';
str_MM = '@(x,theta) [';
str_RES = '@(x,dx,theta) [';
for i = 1:length(VFsym)-1
    str_VF = [str_VF char(VFsym(i)) ';'];    
    str_MM = [str_MM char(MMsym(i)) ';'];    
    str_RES = [str_RES char(RESsym(i)) ';'];    
end
str_VF = [str_VF char(VFsym(end))    ']'];
str_MM = [str_MM char(MMsym(end)) ']'];
str_RES = [str_RES char(RESsym(end)) ']'];
% Exchange variables (backwards to avoid errors)
for i = length(M):-1:1
    str_VF = strrep(str_VF,char(M(i)),['x(' num2str(i,'%d') ')']);    
    str_MM = strrep(str_MM,char(M(i)),['x(' num2str(i,'%d') ')']);    
    str_RES = strrep(str_RES,char(dMdt(i)),['dx(' num2str(i,'%d') ')']);    
    str_RES = strrep(str_RES,char(M(i)),['x(' num2str(i,'%d') ')']);    
end
% Exchange parameters (backwards to avoid errors)
for i = n_c:-1:1
    str_VF = strrep(str_VF,char(c(i)),['theta(' num2str(i,'%d') ')']);  
    str_MM = strrep(str_MM,char(c(i)),['theta(' num2str(i,'%d') ')']);  
    str_RES = strrep(str_RES,char(c(i)),['theta(' num2str(i,'%d') ')']);  
end
% Construct function
VF = eval(str_VF);
MM = eval(str_MM);
RES = eval(str_RES);

%% CONSTRUCT FUNCTION HANDLE - STATES
% Open file
fid = fopen([options.filename '.m'],'w');
% Construct string
str_FUN = ['function [res,flag,new_data] = ' options.filename '(t,x,dx,data) \n\n'...
           'theta = data.params;\n\n'...
           'res =' strrep(str_RES(14:end),';',';...\n       ') ';\n\n'...
           'flag = 0;\n'...
           'new_data = [];'];
% Write to file
fprintf(fid,str_FUN);
fclose(fid);

%% CONSTRUCTION OF VECTOR FIELD, MASS MATRIX, AND RESIDUAL FUNCTION - SENSITIVITIES
% Definition of sensitivities
SM = sym(nan(length(M),n_c));
dSMdt = sym(nan(length(M),n_c));
for i = 1:n_c
    for j = 1:length(M)
        SM(j,i) = ['d' char(M(j)) '_dc' num2str(i,'%i')];
        dSMdt(j,i) = ['dd' char(M(j)) '_dcdt' num2str(i,'%i')];
    end
end

% Jacobian
dVFdM = jacobian(VFsym,M);
for i = 1:n_c
    dVFdc{i} = jacobian(VFsym,c(i));
end

% Derivation of residual function
VF_Ssym = sym(nan(length(M),n_c));
MM_Ssym = sym(ones(length(M),n_c));
for i = 1:n_c
    VF_Ssym(:,i) = dVFdM*SM(:,i) + dVFdc{i};
    for j = 1:n_y_index
        I = n_y_index + (j-1)*(n_z+n_C) + [1:(n_z+n_C)];
        VF_Ssym(I,i)  = -SM(j,i)*dMdt(I) + VF_Ssym(I,i);
        MM_Ssym(I,i)  = M(j);
    end
end
RES_Ssym = - MM_Ssym.*dSMdt + VF_Ssym;
    
%% CONVERSION TO EXECUTABLE FUNCTION - SENSITIVITIES
% Write function
str_VF_S  = '@(x,dx,sx,theta) [';
str_MM_S  = '@(x,dx,sx,theta) [';
str_RES_S = '@(x,dx,sx,dsx,theta) [';
for i = 1:length(M)
    for j = 1:n_c
        str_VF_S  = [str_VF_S  char(VF_Ssym(i,j) )];
        str_MM_S  = [str_MM_S  char(MM_Ssym(i,j) )];
        str_RES_S = [str_RES_S char(RES_Ssym(i,j))];
        if j == n_c
            str_VF_S  = [str_VF_S  ';'];
            str_MM_S  = [str_MM_S  ';'];
            str_RES_S = [str_RES_S ';'];
        else
            str_VF_S  = [str_VF_S  ','];
            str_MM_S  = [str_MM_S  ','];
            str_RES_S = [str_RES_S ','];
        end
    end
end
str_VF_S  = [str_VF_S  ']'];
str_MM_S  = [str_MM_S  ']'];
str_RES_S = [str_RES_S ']'];
% Exchange variables (backwards to avoid errors)
for i = length(M):-1:1
    for j = 1:n_c
        str_VF_S  = strrep(str_VF_S ,char(dSMdt(i,j)),['dsx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);    
        str_MM_S  = strrep(str_MM_S ,char(dSMdt(i,j)),['dsx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);    
        str_RES_S = strrep(str_RES_S,char(dSMdt(i,j)),['dsx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);    
        str_VF_S  = strrep(str_VF_S ,char(SM(i,j))   ,['sx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);
        str_MM_S  = strrep(str_MM_S ,char(SM(i,j))   ,['sx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);
        str_RES_S = strrep(str_RES_S,char(SM(i,j))   ,['sx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);
    end
end
for i = length(M):-1:1
    str_VF_S  = strrep(str_VF_S ,char(dMdt(i)),['dx(' num2str(i,'%d') ')']);    
    str_MM_S  = strrep(str_MM_S ,char(dMdt(i)),['dx(' num2str(i,'%d') ')']);    
    str_RES_S = strrep(str_RES_S,char(dMdt(i)),['dx(' num2str(i,'%d') ')']);    
    str_VF_S  = strrep(str_VF_S ,char(M(i)),['x(' num2str(i,'%d') ')']);    
    str_MM_S  = strrep(str_MM_S ,char(M(i)),['x(' num2str(i,'%d') ')']);    
    str_RES_S = strrep(str_RES_S,char(M(i)),['x(' num2str(i,'%d') ')']);    
end
% Exchange parameters (backwards to avoid errors)
for i = n_c:-1:1
    str_VF_S  = strrep(str_VF_S ,char(c(i)),['theta(' num2str(i,'%d') ')']);  
    str_MM_S  = strrep(str_MM_S ,char(c(i)),['theta(' num2str(i,'%d') ')']);  
    str_RES_S = strrep(str_RES_S,char(c(i)),['theta(' num2str(i,'%d') ')']);  
end
% Construct function
VF_S  = eval(str_VF_S);
MM_S  = eval(str_MM_S);
RES_S = eval(str_RES_S);

%% CONSTRUCT FUNCTION HANDLE - SENSITIVITIES
% Open file
fid = fopen([options.filename '_S.m'],'w');
% Construct string
str_FUN = ['function [res_S,flag,new_data] = ' options.filename '_S(t,x,dx,res,sx,dsx,data) \n\n'...
           'theta = data.params;\n\n'...
           'res_S = ' strrep(str_RES_S(21:end),';',';...\n         ') ';\n\n'...
           'flag = 0;\n'...
           'new_data = [];'];
% Write to file
fprintf(fid,str_FUN);
fclose(fid);

%% ASSEMBLE OUTPUT
% Stochastic state
cMFSP.state.stochatic.name = system.state.name(1:n_y);
cMFSP.state.stochatic.variable = system.state.variable(1:n_y);
cMFSP.state.stochatic.xmin = system.state.xmin(1:n_y);
cMFSP.state.stochatic.xmax = system.state.xmax(1:n_y);
cMFSP.state.stochatic.state_index = y_ind;
cMFSP.state.stochatic.FSP_index = y_index;
% Expectation state
cMFSP.state.expectation.name = system.state.name(n_y+1:end);
cMFSP.state.expectation.variable = system.state.variable(n_y+1:end);
cMFSP.state.expectation.xmin = system.state.xmin(n_y+1:end);
cMFSP.state.expectation.xmax = system.state.xmax(n_y+1:end);
cMFSP.state.expectation.state_index = z_ind;
cMFSP.state.expectation.C_index = C_ind;
% Symbolic
cMFSP.state.sym.p = p;
cMFSP.state.sym.mu = mu;
cMFSP.state.sym.C = C;
cMFSP.state.sym.hoC = hoC_used;
cMFSP.state.sym.hoC_closure = choC;
cMFSP.state.sym.M = M;
cMFSP.state.sym.dMdt = dMdt;

% Symbolic
cMFSP.parameters.sym.c = c;

% State of cMFSP
cMFSP.derivatives.sym.dpdt = dpdt;
cMFSP.derivatives.sym.pdmudt = pdmudt;
cMFSP.derivatives.sym.pdCdt = pdCdt;
cMFSP.derivatives.sym.VF = VFsym;
cMFSP.derivatives.sym.mass_matrix = MMsym;
cMFSP.derivatives.sym.res = RESsym;
cMFSP.derivatives.sym.VF_S = VF_Ssym;
cMFSP.derivatives.sym.mass_matrix_S = MM_Ssym;
cMFSP.derivatives.sym.res_S = RES_Ssym;
cMFSP.derivatives.fun.VF = VF;
cMFSP.derivatives.fun.mass_matrix = MM;
cMFSP.derivatives.fun.res = RES;
cMFSP.derivatives.fun.VF_S = VF_S;
cMFSP.derivatives.fun.mass_matrix_S = MM_S;
cMFSP.derivatives.fun.res_S = RES_S;



