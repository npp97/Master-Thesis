% function MM = getMM_centered(system,options)
function MM = getMM_centered(varargin)

%% CHECK / ASSIGN INPUTS
% Check required inputs
if nargin >= 1
    if ~isempty(varargin{1})
        % Assign inputs
        system = varargin{1};
    else
        % Error message:
        error('The first input must be non-empty!');   
    end
else
    % Error message:
    error('At least one input is required!');
end

% Options
options.moment_order = 2;
options.moment_closure = 'none';
if nargin >= 2
    options = setdefault(varargin{2},options);
end

%% INITIALIZATION (1)
n_s = length(system.state.variable);
n_r = length(system.reaction);
n_c = length(system.parameter.variable);

%% INITIALIZATION (2)
% Generation of I-index
[I,n_I] = getMomentIndexSet(n_s,options.moment_order);

% Mean
mu = getMu(I(1:n_s,:));
% Moments with order >= 2
C = getC(I(n_s+1:end,:));
% All moments
M = [mu;C];

% Parameters
c = sym(zeros(n_c,1));
for i = 1:n_c
    c(i) = sym(['c' num2str(i,'%d')]);
end

%% REACTION STOICHIOMETRY
S_e = zeros(n_s,n_r);
S_p = zeros(n_s,n_r);
% Loop: reatcions
for r = 1:n_r
    % Loop: educts
    for j = 1:length(system.reaction(r).educt)
        ind = find(system.state.variable == system.reaction(r).educt(j));
        S_e(ind,r) = S_e(ind,r) + 1;
    end
    % Loop: products
    for j = 1:length(system.reaction(r).product)
        ind = find(system.state.variable == system.reaction(r).product(j));
        S_p(ind,r) = S_p(ind,r) + 1;
    end
end
% Overall reaction stoichiometry
S = S_p - S_e;

%% ASSIGN PROPENSITIES AND COMPUTE DERIVATIVES
for r = 1:n_r
    term{r} = sym([]);
    L{r} = [];
    % Propensities
    w{r} = system.reaction(r).propensity;
    w{r} = subs(w{r},system.parameter.variable,c);
    w{r} = subs(w{r},system.state.variable,mu);
    dwdx{r} = simplify(jacobian(w{r},mu));
    d2wdx2{r} = simplify(hessian(w{r},mu));
    % 
    if w{r} ~= 0
        term{r}(1) = w{r};
        L{r}(1,1:2) = 0;
        for k = 1:n_s
            term{r}(end+1) = dwdx{r}(k);
            L{r}(end+1,1:2) = [0,k];
        end
        for k = 1:n_s
            for l = k:n_s
                if k == l
                    term{r}(end+1) = 0.5*d2wdx2{r}(k,l);
                else
                    term{r}(end+1) = d2wdx2{r}(k,l);
                end
                L{r}(end+1,1:2) = [k,l];
            end
        end        
    end
    ind = isAlways(term{r}==0);
    term{r}(ind) = [];
    L{r}(ind,:) = [];
end

%% CONSTRUCTION OF MOMENT EQUATION
dMdt  = sym(zeros(n_I,1));
% Loop: Moments
for i = 1:n_I
    % Assignment of I-index and alpha-index
    Ii = I(i,find(I(i,:)~=0));
    for k = 1:n_s
        alphai(k) = sum(Ii == k);
    end
    %% MEAN
    if sum(alphai) == 1
        % Loop: reactions
        for r = 1:n_r
%             % Summand 1
%             dMdt(i) = dMdt(i) + S(Ii,r)*w{r};
%             % Summand 2
%             for q1 = 1:n_s
%                 for q2 = 1:n_s
%                     dMdt(i) = dMdt(i) + 0.5*S(Ii,r)*d2wdx2{r}(q1,q2)*getC(sort([q1,q2]));
%                 end
%             end
            dMdt(i) = dMdt(i) + S(Ii,r)*term{r}*getC(L{r});
        end
    %% MOMENTS WITH ORDER >= 2    
    else
        for r = 1:n_r
            % Generation of combinations
            [L_alpha,L_I] = getLset(Ii,n_s);
            % Loop: combinations
            for l = 1:size(L_alpha,1)
                l_alpha = L_alpha(l,:);
                l_I = L_I(l,:);
                l_I = l_I(find(l_I~=0));
                % Prefactor
                factor = nchoosek_vec(alphai,l_alpha)*prod(S(:,r).^(alphai(:)-l_alpha(:)));
                if factor ~= 0
%                     % Summand 1
%                     dMdt(i) = dMdt(i) + factor*w{r}*getC(l_I);
%                     % Summand 2
%                     for q = 1:n_s
%                         dMdt(i) = dMdt(i) + factor*dwdx{r}(q)*getC(sort([l_I,q]));
%                     end
%                     % Summand 3
%                     for q1 = 1:n_s
%                         for q2 = 1:n_s
%                             dMdt(i) = dMdt(i) + 0.5*factor*d2wdx2{r}(q1,q2)*getC(sort([l_I,q1,q2]));
%                         end
%                     end
                    dMdt(i) = dMdt(i) + factor*term{r}*getC(sort([L{r},repmat(l_I,size(L{r},1),1)],2));
                end
            end
        end
        % Summand 4
        if length(Ii) >= 3
            for q = 1:n_s
                if alphai(q) >= 1
                    Iiq = Ii; Iiq(find(Iiq==q,1)) = [];
                    dMdt(i) = dMdt(i) - alphai(q)*dMdt(q)*getC(Iiq);
                end
            end
        end
    end
end

%% MOMENT CLOSURE
% Determine moments of order > options.moment_order
hoM = transpose(setdiff(symvar(dMdt),[c;M]));
% Closure
hoM_closure = sym([]);
switch options.moment_closure
    case 'low-dispersion'
        hoM_closure = zeros(size(hoM));
    otherwise
        error('This option is not available.');
end
% Set Moments to zero
if ~isempty(hoM)
    dMdt = subs(dMdt,hoM,hoM_closure);
end

%% CONVERSION TO EXECUTABLE FUNCTION
% Write function
str = '@(t,x,theta) [';
for i = 1:length(M)-1
    str = [str char(dMdt(i)) ';'];    
end
str = [str char(dMdt(end))    ']'];
% Exchange variables (backwards to avoid errors)
for i = length(M):-1:1
    str = strrep(str,char(M(i)),['x(' num2str(i,'%d') ')']);    
end
% Exchange parameters (backwards to avoid errors)
for i = n_c:-1:1
    str = strrep(str,char(c(i)),['theta(' num2str(i,'%d') ')']);  
end
% Construct function
f = eval(str);

%% ASSEMBLE OUTPUT
MM.type  = 'centered';
MM.order = options.moment_order;
MM.closure = options.moment_closure;
MM.sym.order = I;
MM.sym.moments = M;
MM.sym.ho_moments = hoM;
MM.sym.ho_moments_closure = hoM_closure;
MM.sym.derivative = dMdt;
MM.fun.derivative = f;

