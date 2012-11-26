clear all
figure(1)
clf

vs = 4;

[XX,YY] = meshgrid(linspace(-vs,vs,30),linspace(-vs,vs,30));

%X_source = 2*vs*rand(1000,2)-vs;
X_eval = [XX(:),YY(:)];
X_source = X_eval;

eps = 2;

f = exp(-1/2*sum((X_source-1).^2,2));
df = sum((X_source-1).*X_source,2).*exp(-1/2*sum((X_source-1).^2,2));
d2f = sum(((X_source-2).*X_source),2).*exp(-1/2*sum((X_source-1).^2,2));

%f = sin(1/10*sum((X_source-1).^2,2));

D_int = distm(X_source,X_source);
D_eval = distm(X_eval,X_source);

M_int = rbf(D_int,eps);
M_eval =  rbf(D_eval,eps);

E = M_eval/M_int;

[OP,D1,D2] = Lop(X_eval,X_source,eps,1,1);

EV = eig(OP);
max(real(EV))
dt = min(1/max(abs(EV)),1e-2)

L = dt*OP + E;

t=0;

view (0,0)
colorbar




subplot(3,3,9)
surf(XX,YY,reshape(f,size(XX)))
%shading interp
title('true F')
subplot(3,3,7)
surf(XX,YY,reshape(df,size(XX)))
%shading interp
title('true grad(f)*grad(u)')
%surf(XX,YY,reshape(drbf(distm(X_eval,[0 0]),1,diffm(X_eval(:,1),[0])),size(XX)))
subplot(3,3,8)
surf(XX,YY,reshape(d2f,size(XX)))
%shading interp
title('true div(grad(f))')

while(t<10)
    
    F = f;
    D1F = D1*f;
    D2F = D2*f;
    OPF = OP*f;
    
    %f = RBF_RK4(Lop(X_eval,X_eval,eps,1,1),Lop(X_eval,X_source,eps,1,1),M_eval/M_int, f, dt);
    f = L*f;
    c=M_int\f;
    I=sum(irbf(c,eps,sum(X_source,2)));
    f=f/I;
    t=t+dt
%     subplot(3,3,1)
%     surf(XX,YY,reshape(F,size(XX)))
%     subplot(3,3,2)
%     surf(XX,YY,reshape(F,size(XX)))
%     view(0,90)
%     subplot(3,3,3)
%     surf(XX,YY,reshape(f,size(XX)))
%     subplot(3,3,4)
%     surf(XX,YY,reshape(D1F,size(XX)))
%     title('rbf grad(f)*grad(u)')
%     subplot(3,3,5)
%     surf(XX,YY,reshape(D2F,size(XX)))
%     title('rbf div(grad(f))')
%     subplot(3,3,6)
%     surf(XX,YY,reshape(OPF,size(XX)))
%     title('rbf -grad(U)*grad(f)+div(grad(f))')
%     drawnow
end