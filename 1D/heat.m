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
opts=optimset('TolFun',1e-2,'TolX',1e-2);

%% 1 Parameters

%% 1.0 Problem

beta = @(t) 1;

t0 = 0;
tf = 1000;

%% 1.1 Time Stepping

% lagrangian velocity D()/Dt = d()/dt + u*\nabla()
du = 1;
% smallest inter particle spacing
dx = 0.01;
% CFL
dt = dx/du;

%% 1.4 Kernel 

eps = 3;

%% 1.3 Particle Distribution

%upper bound on the inter particle spacing
vs = 5;
D0 = 0.5;
Nstar = 12;
%rstar = sqrt(3);
rstar = 3;
dc = 2.5;
% probability tolerance for spawning of new particles
tol = 1e-4;

%% 1.4 Graphical Output

[VX,VY] = meshgrid(linspace(-vs,vs,30),linspace(-vs,vs,30));
Xv = [VX(:),VY(:)];
GG = -gradllh(0,Xv);
subplot(3,3,3)
quiver(VX,VY,reshape(GG(:,1),size(VX)),reshape(GG(:,2),size(VX)))
figure(1)

%% 2 Implementation

%% 2.1 Initialization

N = 100;
d = 2;

% initialise positions

Xp = randn(N,d)+1;
%Xp = [0 0];
D = distm_mex(Xp,Xp);



% initialise radii

Dp = exactDp(Xp,ngprior(Xp),rstar,D0);
rcp = rstar*Dp;

% initialise energy
W = [];

% Time Stepping
t=t0;
n=1;

%% 2.2 Initial particle distribution

Iiter = 1;
while(true)
    subplot(3,3,1)
    hold off
    Iiter

    k=1;
    hold off
    plot(Xp(:,1),Xp(:,2),'o')
    xlim([-vs,vs])
    ylim([-vs,vs])
    drawnow
    hold on
    
    % fuse particles
    [Xp,rcp] = fuse_particles( Xp,Dp,rstar );
    
    Dp = exactDp(Xp,ngprior(Xp),rstar,D0);
    rcp = rstar*Dp;
    
    % spawn new particels
    [Xp] = spawn_particles( Xp,Dp,rcp,Nstar,rstar,D0,tol );    
    
    Dp = exactDp(Xp,ngprior(Xp),rstar,D0);
    rcp = rstar*Dp;
    
    % gradient descent direction
    [ wp,W ] = gradient_descent( Xp,Dp,rcp,rstar,D0,W,Iiter,opts );
    
    % line search for gradient descent step size and move particels by one step   
    [gamma] = fminsearch(@(g) InitOrgEnergy(Xp+g*wp,ngprior(Xp),rstar,D0),-1,opts);
    Xp = Xp + gamma*wp;
    
    plot(Xp(:,1),Xp(:,2),'yo')
    drawnow
    
    Dp = exactDp(Xp,ngprior(Xp),rstar,D0);
    rcp = rstar*Dp;
    
    Dpq = bsxfun(@min,Dp,Dp');
    Rpq = distm_mex(Xp,Xp);
    crit = Dpq./Rpq;
    Nlist = (Rpq<min(repmat(rcp,1,size(Xp,1)),repmat(rcp',size(Xp,1),1)))-logical(eye(size(Xp,1)));
    
    %graphical output
    NI(Iiter) = sum(sum(Nlist(prior(Xp)>tol,:),2)<Nstar-1);
    CI(Iiter) = max(max(crit(logical(Nlist))));
    %plot_points( Xv,Xp,Dp,rcp,VX,VY,W,NN,CC,dc,iter,Nlist,Nstar,vs )
    
    Iiter = Iiter+1;
    
    % if stopping criterion of gradient descent is reached and every particle has N* neighbors stop, else repeat.
    % for crit to work we need to substract a logical eye from Nlist, this leads to Nstar-1
    if(sum(sum(Nlist(prior(Xp)>tol,:),2)<Nstar-1)==0 && max(max(crit(logical(Nlist))))<=dc)
        break;
    end
end

f = prior(Xp);
pause

%% 2.3 Start solving PDE 

Piter = 1;

while (t<tf)
    % advect particles
    disp('advecting')
    Xp_adv=zeros(size(Xp));
    for m=1:size(Xp,1)
        [ik,xt]=ode45(@(t,x) -gradllh(t,x),[t,t+dt],Xp(m,:)');
        Xp_adv(m,:) = xt(end,:)';
    end
%    Xp_adv = Xp - dt*gradllh(0,Xp);
    subplot(2,3,1)
    plot(Xp(:,1),Xp(:,2),'o')
    drawnow
    hold on
    [OP,D1,D2,M_int,M_eval] = Lop(Xp_adv,Xp,rcp,1,1);
    
    EV = eig(OP);
    % scale dt according to eigenvalues to assure stability
    dt = 1/max(abs(eig(OP)));
    % euler integration scheme
    L = dt*OP + M_eval/M_int;
    % apply operator
    f=L*f;
    
    % assure conservation
    c=M_int\f;
    I=irbf(c,eps,sum(Xp,2));
    c=c/sum(I);
    f=M_eval*c;
 
    Xp=Xp_adv;
    % reorganize particles ?
    n=n-1;
    
    if (n==0)

        n=10;
        % construct CD-PSE operators
        
        % compute Dpn
        Dp = calcDp(Xp,Xp,rstar,D0,rcp,f);
        rcp = rstar*Dp;


        % save points
        Xp_old = Xp;
        Dp_old = Dp;
        rcp_old = rcp;
    
        % init plotting 
        Aiter = 1;
        WA=[];
        
        % create x_new
        while(true)            
            subplot(2,3,1)
            hold off           
            % remove bad particles
          
            % fuse particles where |xp_xq|<Dpq/
            % do this in a greedy-type fashion by removing particles with most points inside the cutoff radius first
            k=1;
            hold off
            plot(Xp(:,1),Xp(:,2),'o')
            drawnow
            hold on
            
            % fuse particles
            [Xp,rcp] = fuse_particles( Xp,Dp,rstar );
            
            Dp = calcDp(Xp,Xp_old,rstar,D0,rcp_old,f);
            rcp=Dp*rstar;
            
            % spawn particles                      
            [Xp] = spawn_particles( Xp,Dp,rcp,Nstar,rstar,D0,tol ); 
            
            Dp = calcDp(Xp,Xp_old,rstar,D0,rcp_old,f);
            rcp = rstar*Dp;
            
            % compute total energy and gradient
            [ wp,WA ] = gradient_descent( Xp,Dp,rcp,rstar,D0,WA,Iiter,opts );
            
            % line search for gradient descent step size and move particels by one step
            [gamma] = fminsearch(@(g) OrgEnergy(Xp+g*wp,Xp_old,rcp_old,f,D0),-1,opts);
            Xp = Xp + gamma*wp;
            
            Dp = calcDp(Xp,Xp_old,rstar,D0,rcp_old,f);
            rcp = rstar*Dp;
            
            plot(Xp(:,1),Xp(:,2),'yo')
            drawnow
            
            % compute total energy and gradient
            Dpq = bsxfun(@min,Dp,Dp');
            Rpq = distm_mex(Xp,Xp);
            crit = Dpq./Rpq;
            Nlist = (Rpq<min(repmat(rcp,1,size(Xp,1)),repmat(rcp',size(Xp,1),1)))-logical(eye(size(Xp,1)));
            
            %graphical output
            NA(Aiter) = sum(sum(Nlist(prior(Xp)>tol,:),2)<Nstar-1);
            CA(Aiter) = max(max(crit(logical(Nlist))));
            plot_points( Xv,Xp,Dp,rcp,VX,VY,WA,NA,CA,dc,Aiter,Nlist,Nstar,vs )
            
            Aiter = Aiter+1;
            
            % if stopping criterion of gradient descent is reached and every particle has N* neighbors stop, else repeat.
            % for crit to work we need to substract a logical eye from Nlist, this leads to Nstar-1         
            if(sum(sum(Nlist)<Nstar-1)==0 && max(max(crit(logical(Nlist))))<=dc)               
                break;
            end        
        end       
        f=IntOp(Xp,Xp_old,rcp_old)*f;       
    end
    
    Piter = Piter + 1;
    % Advance time
    t = t + dt;
end



