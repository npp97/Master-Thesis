clear all
figure(1)
clf
hold off

vs = 4;

N = 30;

[XX,YY] = meshgrid(linspace(-vs,vs,N),linspace(-vs,vs,N));
[VX,VY] = meshgrid(linspace(-3,3,N),linspace(-3,3,N));

%X_source = 2*vs*rand(1000,2)-vs;
X_eval = [XX(:),YY(:)];
X_source = [VX(:),VY(:)];


eps = 2;

oo=1;

f = exp(-1/2*sum((X_source-oo).^2,2));
%f=rand(N^2,1);
df = sum((X_source-oo).*X_source,2).*exp(-1/2*sum((X_source-oo).^2,2));
d2f = sum(((X_source-2*oo).*X_source),2).*exp(-1/2*sum((X_source-oo).^2,2));
ftarget = exp(-llh(0,X_source));

%f = sin(1/10*sum((X_source-1).^2,2));

D_int = distm(X_source,X_source);
D_eval = distm(X_eval,X_source);

M_int = rbf(D_int,eps);
M_eval =  rbf(D_eval,eps);

E = M_int/M_int;

[VOP,VD1,VD2] = Lop(X_eval,X_source,eps,1,1);
[OP,D1,D2] = Lop(X_source,X_source,eps,1,1);

EV = eig(OP);
max(real(EV))
%dt = min(1/max(abs(EV)),1e-2);
dt = 0.9/((max(abs(EV))+min(abs(EV)))/2);
L = dt*OP + E;

t=0;

subplot(3,4,9)
surf(XX,YY,reshape(f,size(XX)))
shading interp
title('true initial F')
subplot(3,4,10)
surf(XX,YY,reshape(df,size(XX)))
shading interp
title('true initial grad(f)*grad(u)')
%surf(XX,YY,reshape(drbf(distm(X_eval,[0 0]),1,diffm(X_eval(:,1),[0])),size(XX)))
subplot(3,4,11)
surf(XX,YY,reshape(d2f,size(XX)))
shading interp
title('true initial div(grad(f))')

It = sum(irbf(M_int\ftarget,eps,sum(X_source,2)));
    c=M_int\f;
    I=sum(irbf(c,eps,sum(X_source,2)));
    f=f*It/I;
Piter=1;
while(t<10)
    
    F = f;
    D1F = VD1*f;
    D2F = VD2*f;
    OPF = VOP*f;
    
    %f = RBF_RK4(Lop(X_eval,X_eval,eps,1,1),Lop(X_eval,X_source,eps,1,1),M_eval/M_int, f, dt);
    f = L*f;
    c=M_int\f;
    I=sum(irbf(c,eps,sum(X_source,2)));
    f=f*It/I;
    t=t+dt;
    Piter=Piter+1;
    if mod(Piter,10)==0
        subplot(3,4,1)
        surf(XX,YY,reshape(f,size(XX)))
        shading interp
        title(['rbf f at t = ' num2str(t)])
        subplot(3,4,2)
        surf(XX,YY,reshape(f,size(XX)))
        shading interp
        view(0,90)
        title('rbf f')
        subplot(3,4,3)
        surf(XX,YY,reshape(f,size(XX)))
        view(90,0)
        title('rbf f')
        shading interp
        subplot(3,4,5)
        surf(VX,VY,reshape(D1F,size(VX)))
        shading interp
        title('rbf grad(f)*grad(u)')
        subplot(3,4,6)
        surf(VX,VY,reshape(D2F,size(VX)))
        shading interp
        title('rbf div(grad(f))')
        subplot(3,4,7)
        surf(VX,VY,reshape(OPF,size(VX)))
        shading interp
        title('rbf -grad(U)*grad(f)+div(grad(f))')
        subplot(3,4,4)
        surf(XX,YY,reshape(ftarget,size(XX)))
        shading interp
        title('equilibrium solution')
        view(90,0)
        subplot(3,4,8)
        hold off
        surf(XX,YY,reshape(abs(ftarget-f),size(XX)))
        set(gca,'ZScale','log')
        shading interp
        title('error')
        view(45,0)
        subplot(3,4,12)
        title('average L2 and absolute Linf error')
        hold on
        semilogy(t,norm(f-ftarget,2)/(N^2),'r.-')
        semilogy(t,norm(f-ftarget,inf),'k.-')
        set(gca,'YScale','log')
        hold off
        drawnow
    end
end