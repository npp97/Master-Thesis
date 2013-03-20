% getFSP.m
% constructs the matrix A(theta) of the finite state projection
%      dp/dt = A(theta) p
% using the provided state vector x, the parameter vector theta and the
% propensity functions. The limites of the regions consider for the 
% finite state projection are defined by
%       xmin <= x <= xmax
%       g(x) <= 0.
% The function g(x) can be an arbitrary nonlinear function of the
% configuration x.
% Besides the matrix A(theta) also the mapping between the state vector of
% the FSP and the CME is provided.
%
% NOTE: The propensity functions are assumed to be linear in theta!
%
% USAGE:
% ======
% [system] = getFSP(system,xmin,xmax)
% [system] = getFSP(system,xmin,xmax,g)
%
% INPUT:
% ======
% x ... columnvector containing the symbolic expressions of the species.
% theta ... rowvector containing the symbolic expressions of the parameter.
% reaction ... struct containing the reaction details:
%   (i).propensity ... rate of the i.th propensity function (e.g. = k1*x1*x2).
%   (i).stoichiometry ... update of after i.th reaction occures.
%           This has to be a columnvector of the same dimension as the x
%           (e.g. = [0,1,0]').
%   (i).parameter ... parameter of i.th propensity function (e.g. = k1).
% xmin ... lower bound of species numbers in FSP.
% xmax ... upper bound of species numbers in FSP.
% g ... functional expression which provieds additional constraints for the
%           number of species. Only configurations with g(x) <= 0 are
%           considered.
%
% OUTPUT:
% =======
% system.A ... function handle providing A(theta).
% system.B ... function handle providing B(theta).
% system.C ... function handle providing C(theta).
% system.D ... function handle providing D(theta).
% system.index ... mapping from state index to molecule number.
%       
% 27/01/2011 ... Jan Hasenauer

% function [Ah,index,A] = getFSP(system)
function [system] = getFSP(varargin)

%% CHECK / ASSIGN INPUTS
% Check required inputs
if nargin >= 3
    if ~isempty(varargin{1}) && ~isempty(varargin{2}) && ~isempty(varargin{3})
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
    error('At least one input is required!');
end

% Check for additional constraints g(x) < 0
if nargin == 4
	g = varargin{4};
else
    g = @(x) 1;
end

%% INITIALIZE ROUTINE
% Boundaries
xmin = max(max([floor(xmin),floor(system.state.xmin)],[],2),0);
xmax =     min([ ceil(xmax), ceil(system.state.xmax)],[],2);
max_index = prod(xmax-xmin+1);
g = system.state.constraint;
% States
x = system.state.variable;
nx = length(xmin);

%% GENERATE STATE INDEX SET:
% Note: The states of the FSP are ordered according to the index set.

% Initialize index matrix:
index = zeros(max_index,nx);
% Initialize state
ind = xmin;
% Construct index matrix
for i = 1:prod(xmax-xmin+1)
    % Assign index
    index(i,:) = ind';
    % Update current index:
    j = min(setdiff(1:nx,find(ind == xmax))); % index which is updated
    ind(j) = ind(j) + 1; 
    ind(1:j-1) = xmin(1:j-1); % reset of all previous indexes
end

% Truncate index such that only the indexes which fulfill g(x) <= 0
% are contained:
ind = [];
% Construct index matri~x
for i = 1:max_index
    % Evaluate g
    if g(index(i,:)') && system.state.constraint(index(i,:)')
        ind = [ind;i];
    end
end
% Find indexes which fulfill constraint
index = index(ind,:);

% Assign index
system.index = index;

% Number of states of FSP:
nindex = size(index,1);

%% GENERATE MATRIX A
% The matrix A is generate for all propensity functions independently.

% Loop: propensity functions
for i = 1:length(system.reaction)
    % Find right probensity function:
    
    % Construct numerical function for rates:
    rate_wo_par = sym2fun(simplify(system.reaction(i).propensity/system.reaction(i).parameter),x);
    % Initialize matrix:
    system.A_i{i} = sparse(zeros(nindex));
    % Construction of A^{(i)} column-wise:
    for j = 1:nindex
       system.A_i{i}(j,j) = - rate_wo_par(index(j,:)');
       
       j2 = (index(:,1) == (index(j,1)+system.reaction(i).stoichiometry(1)));
       for k = 2:nx
           j2 = j2 .* (index(:,k) == (index(j,k)+system.reaction(i).stoichiometry(k)));
       end
       j2 = find(j2);
       % Assign reaction
       if ~isempty(j2)
           system.A_i{i}(j2,j) = rate_wo_par(index(j,:)');
       end
    end
    % Assign coefficient:
    system.sigma_A_i{i} = eval(['@(theta) theta(' num2str(find(system.parameter.variable == system.reaction(i).parameter)) ');']);
end

%% CONSTRUCTION OF FUNCTION HANDLE 'A'
% Construct functional expression:
expr = '@(theta) [system.sigma_A_i{1}(theta)*system.A_i{1}';
for i = 2:length(system.parameter.variable)
    expr = [expr '+ system.sigma_A_i{' num2str(i) ' }(theta)*system.A_i{' num2str(i) '}'];
end
expr = [expr '];'];
% Construct function handle
system.A = eval(expr);

%% CONSTRUCTION OF B, C AND D MATRIX
% B Matrix:
system.B = @(theta) [];
% C Matrix:
system.C = @(theta) [];
% D Matrix:
system.D = @(theta) [];


