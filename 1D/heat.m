%% 0 Problem
%
% See nonasymptotic mixing of the MALA
% 
% $$ \pi (x) = Z^{-1} exp(-\beta U(x)) \quad | \quad Z=\int exp(-\beta U(x))$$
%
% $$ U = (\frac{x^2}{2})^2 $$
%
% $$ dY_\tau = -\nabla U(Y_\tau) d\tau + \sqrt{2\beta^{-1}}dW_\tau $$
%
% Feynman Kac
%
% $$ dY_\tau = \mu d\tau + \sigma dW_\tau $$
%
% $$ \mu = - \nabla U(Y_\tau) $$
%
% $$ \sigma = \sqrt{2\beta^{-1}} $$
%
% $$ g(\tau,x) = E(h(Y_T)|Y_0 = x) $$
%
% $$ g_\tau(\tau,x) = - \mu g_x - \frac{1}{2} \sigma^2 g_xx \quad | \quad  g(T,x) = h(x) $$
%
% Reverse time :
%
% $$ t = T - \tau \quad dt = -d\tau $$
%
% $$ g_t = \mu g_x + \frac{1}{2} \sigma^2 g_xx \quad | \quad g(0,x) = h(x) $$
%
% $$ g_t = - x * g_x + \beta^{-1} g_xx
clear all;
clf
P.opts=optimset('TolFun',1e-2,'TolX',1e-2);

%% 1 Parameters

%% 1.0 Problem

beta = @(t) 1;

P.t0 = 0;
P.tf = 1000;

%% 1.1 Time Stepping

% lagrangian velocity D()/Dt = d()/dt + u*\nabla()
P.du = 1;
% smallest inter particle spacing
P.dx = 0.01;
% CFL
P.dt = P.dx/P.du;

%% 1.4 Kernel 

P.eps = 3;

%% 1.3 Particle Distribution

%upper bound on the inter particle spacing
P.vs = 3;
P.D0 = 0.5;
P.Nstar = 8;
%rstar = sqrt(3);
P.rstar = 3;
P.dc = 2.5;
% probability tolerance for spawning of new particles
P.tol = 1e-20;
% adaptive grid?
P.adgrid = false;
% number of points in every dimension for a fixed grid
P.gridN = 30;


%% 1.4 Graphical Output

[P.VX,P.VY] = meshgrid(linspace(-P.vs,P.vs,30),linspace(-P.vs,P.vs,30));
P.Xv = [P.VX(:),P.VY(:)];
figure(1)

%% 2 Implementation

%% 2.1 Initialization

P.N = 100;
P.dim = 2;

% initialise positions

P.Xp = randn(P.N,P.dim)+1;
%Xp = [0 0];
P.R = distm_mex(P.Xp,P.Xp);

% initialise radii
P.DF = ngprior(P.Xp);
P = exactDp(P);

% initialise energy
WI = [];



%% 2.2 Initial particle distribution
figure(1)
clf
P.Iiter = 1;

P.init = true;
if(P.adgrid)
    try
        load Xp_init
    catch
        while(true)
            subplot(3,3,1)
            hold off
            P.Iiter
            
            k=1;
            hold off
            plot(P.Xp(:,1),P.Xp(:,2),'o')
            xlim([-P.vs,P.vs])
            ylim([-P.vs,P.vs])
            drawnow
            hold on
            
            % fuse particles
            P = fuse_particles( P );
            
            P.DF = ngprior(P.Xp);
            P = exactDp( P );
            
            % spawn new particels
            P = spawn_particles( P );
            
            P.DF = ngprior(P.Xp);
            P = exactDp( P );
            
            % gradient descent direction
            P = gradient_descent( P );
            
            % line search for gradient descent step size and move particels by one step
            [gamma] = fminsearch(@(g) InitOrgEnergy(P),-1,P.opts);
            P.Xp = P.Xp + gamma*P.wp;
            
            plot(P.Xp(:,1),P.Xp(:,2),'mo')
            drawnow
            
            P.DF = ngprior(P.Xp);
            P = exactDp(P);
            
            P.Dpq = bsxfun(@min,P.Dp,P.Dp');
            P.R = distm_mex(P.Xp,P.Xp);
            P.crit = P.Dpq./P.R;
            P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1)))-logical(eye(P.N));
            
            %graphical output
            P.NI(P.Iiter) = sum(sum(P.Nlist(prior(P.Xp)>P.tol,:),2)<P.Nstar-1);
            P.CI(P.Iiter) = max(max(P.crit(logical(P.Nlist))));
            plot_points( P,1 )
            
            P.Iiter = P.Iiter+1;
            
            % if stopping criterion of gradient descent is reached and every particle has N* neighbors stop, else repeat.
            % for crit to work we need to substract a logical eye from Nlist, this leads to Nstar-1
            if(sum(sum(P.Nlist(prior(P.Xp)>P.tol,:),2)<P.Nstar-1)==0 && max(max(P.crit(logical(P.Nlist))))<=P.dc)
                break;
            end
        end
    end
else
    try
        load Xp_init
    catch
        [XX,YY] = meshgrid(linspace(-P.vs,P.vs,P.gridN),linspace(-P.vs,P.vs,P.gridN));
        P.Xp = [XX(:),YY(:)];
        P.Xp_adv = P.Xp;
        P.R = distm(P.Xp,P.Xp);
        P.eps = fminbnd(@(ep) CostEpsRiley(ep,P.R,prior(P.Xp)),0,20);
        [P.OP,P.D1,P.D2,P.M_int,P.M_eval,P.M_target] = Lop(P.Xp,P.Xp,P.eps,1,1);
        P.E = eye(P.gridN^P.dim);
        P.EV = eig(P.OP);
        max(real(P.EV))
        %dt = min(1/max(abs(EV)),1e-2);
        dt = 1.9/max(abs(P.EV));
        P.L = dt*P.OP + P.E;
    end
end

save Xp_Init


P.f = prior(P.Xp);

if(P.adgrid)
    P.Xp = P.Xp(P.f>P.tol,:);
    P.f = P.f(P.f>P.tol);
    P.Dp = P.Dp(P.f>P.tol);
    P.rcp = P.rcp(P.f>P.tol);
end

P.N=size(P.Xp,1);

%% 2.3 Start solving PDE 

P.init = false;

P.Piter = 1;
% Time Stepping
P.t=P.t0;
n=3;

while (P.t<P.tf)
    % advect particles
    if(P.adgrid)
        P.Xp_adv = P.Xp + P.dt*gradllh(0,P.Xp);
        
        [P.OP,P.D1,P.D2,P.M_int,P.M_eval,P.M_target] = Lop(P.Xp_adv,P.Xp,P.rcp,1,1);
        
        P.EV = eig(P.OP);
        % scale dt according to eigenvalues to assure stability
        P.dt = 1/((max(abs(P.EV))+min(abs(P.EV)))/2);
        % euler integration scheme
        P.E = P.M_eval/P.M_int;
        P.L = P.dt*P.OP + P.E;
    end
    % apply operator
    P.F=P.L*P.f;
    % assure conservation
    P.c=P.M_target\P.F;
    P.IF=sum(irbf(P.c,P.eps,P.dim));
    P.c=P.c/P.IF;
    P.F=P.M_target*P.c;
    
    plot_operator( P,2 )
    
    if(P.adgrid)
        P = calcDp(P);
        P.Xp=P.Xp_adv;
    end
    P.f=P.F;
    
    % reorganize particles ?
    n=n-1;
    
    if (n==0 && P.adgrid)
        
        figure(3)
        clf
        n=15;
        % construct CD-PSE operators
        
        subplot(3,3,4)
        tri = delaunay(P.Xp(:,1),P.Xp(:,2));
        trisurf(tri,P.Xp(:,1),P.Xp(:,2),P.rcp)
        xlim([-P.vs,P.vs])
        ylim([-P.vs,P.vs])
        shading interp
        view(0,90)
        colormap(jet)
        colorbar
        title('rcp')

        % save points
        P.Xp_old = P.Xp;
        P.Dp_old = P.Dp;
        P.rcp_old = P.rcp;
        
        P.cDp = TriScatteredInterp(P.Xp,P.Dp);
        P.cDpNN = TriScatteredInterp(P.Xp,P.Dp,'nearest');
        P.cFp = TriScatteredInterp(P.Xp,P.f);
        
        % init plotting 
        P.Aiter = 1;
        P.WA=[];
        P.NA=[];
        P.CA=[];
        
        % create x_new
        while(true)            
            subplot(3,3,1)
            hold off           
            % remove bad particles
          
            % fuse particles where |xp_xq|<Dpq/
            % do this in a greedy-type fashion by removing particles with most points inside the cutoff radius first
            k=1;
            plot(P.Xp(:,1),P.Xp(:,2),'o')
            drawnow
            hold on
            
            % fuse particles
            P = fuse_particles( P );
            
            P.Fp=P.cFp(P.Xp);
            % spawn particles                      
            P = spawn_particles( P );
            
            P.Dp = P.cDp(P.Xp);
            P.rcp = P.rstar*P.Dp;
            if any(isnan(P.rcp))
                P.Dp(isnan(P.rcp)) = P.cDpNN(P.Xp(isnan(P.rcp),:));
                P.rcp = P.rstar*P.Dp;
            end
            
            % compute total energy and gradient
            P = gradient_descent( P );
            
            % line search for gradient descent step size and move particels by one step
            [gamma] = fminsearch(@(g) OrgEnergy(P),-1,P.opts);
            P.Xp = P.Xp + gamma*P.wp;
            
            P.Dp = P.cDp(P.Xp);
            P.rcp = P.rstar*P.Dp;
            if any(isnan(P.rcp))
                P.Dp(isnan(P.rcp)) = P.cDpNN(P.Xp(isnan(P.rcp),:));
                P.rcp = P.rstar*P.Dp;
            end
            
            plot(P.Xp(:,1),P.Xp(:,2),'mo')
            drawnow
            
            % compute total energy and gradient
            P.Dpq = bsxfun(@min,P.Dp,P.Dp');
            P.R = distm_mex(P.Xp,P.Xp);
            P.crit = P.Dpq./P.R;
            P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1)))-logical(eye(P.N));
            
            %graphical output
            P.NA(P.Aiter) = sum(sum(P.Nlist(P.cFp(P.Xp)>P.tol,:),2)<P.Nstar-1);
            P.CA(P.Aiter) = max(max(P.crit(logical(P.Nlist))));
            plot_points( P,3 )
            
            P.Aiter = P.Aiter+1;
            
            % if stopping criterion of gradient descent is reached and every particle has N* neighbors stop, else repeat.
            % for crit to work we need to substract a logical eye from Nlist, this leads to Nstar-1         
            if(sum(sum(P.Nlist(P.cFp(P.Xp)>P.tol,:),2)<P.Nstar-1)==0 && max(max(P.crit(logical(P.Nlist))))<=P.dc)              
                break;
            end        
        end       
        P.f=IntOp(P.Xp,P.Xp_old,P.rcp_old)*P.f;     
        P.Xp = P.Xp(P.f>P.tol,:);
        P.f = P.f(P.f>P.tol);
        P.Dp = P.Dp(P.f>P.tol);
        P.rcp = P.rcp(P.f>P.tol);
        P.N=size(P.Xp,1);
    end
    
    P.Piter = P.Piter + 1;
    % Advance time
    P.t = P.t + P.dt;
end



