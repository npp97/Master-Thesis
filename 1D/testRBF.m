vs = 6;

[XX,YY] = meshgrid(linspace(-vs,vs,30),linspace(-vs,vs,30));

%X_source = 2*vs*rand(1000,2)-vs;
X_eval = [XX(:),YY(:)];
X_source = X_eval;

eps = 3;

f = 10*exp(-1/2*sum(10*(X_source-1).^2,2));

D_int = distm(X_source,X_source);
D_eval = distm(X_eval,X_source);

M_int = rbf(D_int,eps);
M_eval =  rbf(D_eval,eps);

c = M_int\f;

D2 = d2rbf(D_eval,eps);

LL = Lop(X_eval,X_source,eps,1,sqrt(2));

EV = eig(LL);
max(real(EV))
dt = 1/max(abs(eig(LL)))

L = dt*LL + M_eval/M_int;

t=0;

while(t<10)
    
    %f = RBF_RK4(Lop(X_eval,X_eval,eps,1,1),Lop(X_eval,X_source,eps,1,1),M_eval/M_int, f, dt);
    f = L*f;
    t=t+dt;
    
    surf(XX,YY,reshape(f,size(XX)))
    drawnow
end


%surf(XX,YY,reshape(rbf(distm(X_source,[0 0]),1),size(XX)))
%surf(XX,YY,reshape(drbf(distm(X_eval,[0 0]),1,diffm(X_eval(:,2),[0])),size(XX)))
%surf(XX,YY,reshape(drbf(distm(X_eval,[0 0]),1,diffm(X_eval(:,1),[0])),size(XX)))
%surf(XX,YY,reshape(d2rbf(distm(X_source,[0 0]),1),size(XX)))

