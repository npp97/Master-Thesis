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
vs = 3;
D0 = 1.5;
Nstar = 12;
rstar = 5;
dc = 2.5;

%% 1.4 Graphical Output

[XX,YY] = meshgrid(linspace(-vs,vs,40),linspace(-vs,vs,40));
GG = -gradllh(0,[XX(:),YY(:)]);
subplot(2,2,4)
quiver(XX,YY,reshape(GG(:,1),size(XX)),reshape(GG(:,2),size(XX)))



%% 2 Implementation

%% 2.1 Initialization

N = 10;
d = 2;



% initialise positions


[XX,YY] = meshgrid(linspace(0,2,10),linspace(0,2,10));
Xp = [XX(:),YY(:)];
rcp = eps*ones(size(Xp,1),1);
D = distm_mex(Xp,Xp);

% initialise CD-PSE
f = exp(-10*sum((Xp-1).^2,2));
wp = rbf(D,rcp)\f;

% initialise radii


Dp = calcDp(Xp,Xp,rstar,D0,rcp,f);
rcp = rstar*Dp;

% Time Stepping
t=t0;
n=1;



while (t<tf)
    % choose dt according to CFL
    
    % advect particles
    disp('advecting')
%     for m=1:size(Xp,1)
%         [ik,xt]=ode45(@gradllh,[t,t+dt],Xp(m,:)');
%         Xp(m,:) = xt(end,:)';
%     end
    Xp_adv = Xp - dt*gradllh(0,Xp);
    subplot(2,2,1)
    plot(Xp(:,1),Xp(:,2),'o')
    drawnow
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
    I=irbf(c,eps);
    c=c/sum(I);
    f=M_eval*c;

    
    Xp=Xp_adv;
    % reorganize particles ?
    n=n-1;
    
    subplot(2,2,2)
    plot3(Xp(:,1),Xp(:,2),f,'x')
    
    if (n==0)

        n=10;
        % construct CD-PSE operators
        
        % compute Dpn
        Dp = calcDp(Xp,Xp,rstar,D0,rcp,f);
        rcp = rstar*Dp;


        % save points
        X_old = Xp;
        Dp_old = Dp;
        rcp_old = rcp;
    
        % create x_new
        while(true)            
            subplot(2,2,1)
            hold off
            
            % remove bad particles
            ind = Dp>0;
            Xp=Xp(ind,:);
            Dp=Dp(ind);
            rcp=rcp(ind);
            
            size(Xp,1)
            
            % fuse particles where |xp_xq|<Dpq/
            % do this in a greedy-type fashion by removing particles with most points inside the cutoff radius first
            k=1;
            hold off
            plot(Xp(:,1),Xp(:,2),'o')
            xlim([-vs, vs])
            ylim([-vs, vs])
            drawnow
            hold on
            while(true)
                
                Dpq = bsxfun(@min,Dp,Dp');
                ind = distm_mex(Xp,Xp)<Dpq/2;
                if(max(sum(ind))==1)
                    break
                else
                    [m,ind] = max(sum(ind));
                    plot(Xp(ind,1),Xp(ind,2),'ro')
                    Dp=Dp([1:ind-1 ind+1:end]);
                    Xp=Xp([1:ind-1 ind+1:end],:);
                    rcp = rstar*Dp;
                end
 
            end
            drawnow
            % new particles
                        
            size(Xp,1)
            
            
            kk=size(Xp,1);
            Nlist = (distm_mex(Xp,Xp)<min(repmat(rcp,1,size(Xp,1)),repmat(rcp',size(Xp,1),1)));
            Nfill = Nstar-sum(Nlist);
           for l=1:size(Xp,1)
               for j=1:Nfill(l)
                   % wiki n-sphere
                   plot(Xp(l,1),Xp(l,2),'co')
                   circle(Xp(l,1),Xp(l,2),Dp(l)/2);
                   circle(Xp(l,1),Xp(l,2),rcp(l));
                   hold on
                   xnew = randn(1,size(Xp,2));
                   % normalize & make sure we do not insert points inside the cutoff radii ... 
                   xnew = Dp(l)*xnew/norm(xnew)+Xp(l,:);
                   Xp = [Xp; xnew];
                   Dp(end+1) = IntOp(xnew,X_old,rcp_old)*f;
                   rcp(end+1) = rstar*Dp(end);
                  plot(xnew(1),xnew(2),'go')
                   %%%drawnow
               end
               if(size(rcp,2)>size(rcp,1))
                   rcp=rcp';
               end
               Nlist = (distm_mex(Xp,Xp)<min(repmat(rcp,1,size(Xp,1)),repmat(rcp',size(Xp,1),1)));
               Nfill = Nstar-sum(Nlist);
           end

            drawnow
          
            % construct neighbor lists within x_new and between x_new and x_old
            
            % compute Dp of x_new by interpolation from Dp of x_old
            Dp = calcDp(Xp,X_old,rstar,D0,rcp_old,f);
            rcp = rstar*Dp;
            % compute total energy and gradient
            Dpq = bsxfun(@min,Dp,Dp');
            W = sum(sum(Dpq.^2*V1(distm_mex(Xp,Xp)./Dpq)));
            wp = zeros(size(Xp));
            for k = 1:size(Xp,1);
                ind = distm_mex(Xp,Xp(k,:))<min(rcp(k),rcp);
                ind(k) = 0;
                Np = Xp(ind,:);
                NDp = Dp(ind);
                for l=1:size(Np,1)
                    r=norm(Xp(k,:)-Np(l,:))/min(Dp(k),NDp(l));
                    wp(k,:) = wp(k,:) - 2*min(Dp(k),NDp(l))*(dV1(r)*(Xp(k,:)-Np(l,:))/norm(Xp(k,:)-Np(l,:)));% + (2*V1(r)-r*dV1(r))\nabla_x_pDpq);
                end
            end
            % line search for gradient descent step size and move particels by one step
            
            [gamma] = fminsearch(@(g) OrgEnergy(Xp+g*wp,X_old,rcp_old,f,D0),-1,opts);
            Xp = Xp + gamma*wp;
            Dp = calcDp(Xp,X_old,rstar,D0,rcp_old,f);
            rcp = rstar*Dp;
            plot(Xp(:,1),Xp(:,2),'yo')
            %drawnow
            % compute totalm energy and gradient
            Dpq = bsxfun(@min,Dp,Dp');
            Rpq = distm_mex(Xp,Xp);
            crit = Dpq./Rpq;
            Nlist = (Rpq<min(repmat(rcp,1,size(Xp,1)),repmat(rcp',size(Xp,1),1)))-logical(eye(size(Xp,1)));
%             %FF = reshape(calcDp_mex([XX(:),YY(:)],Xp,rstar,D0),size(XX));
%              subplot(2,2,2)
%             plot3(Xp(:,1),Xp(:,2),Dp)
%             colormap(jet(1000))
%             colorbar
%             II = reshape(monitor_function([XX(:),YY(:)],D0),size(XX));
%             subplot(2,2,3)
%             contourf(XX,YY,II)
%             colormap(jet(1000))
%             colorbar
%             colormap(jet(1000))
%             colorbar
            % if stopping criterion of gradient descent is reached and every particle has N* neighbors stop, else repeat.
            % for crit to work we need to substract a logical eye from Nlist, this leads to Nstar-1
            if(sum(sum(Nlist)<Nstar-1)==0 && max(max(crit(logical(Nlist))))<=dc)               
                break;
            end
            drawnow

        end
        
        f=IntOp(Xp,X_old,rcp_old)*f;
        
    end
    
    % Advance time
    t = t + dt;
end



