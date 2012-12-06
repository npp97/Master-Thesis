function [] = plot_operator( P,fig )
    %PLOT_OPERATOR Summary of this function goes here
    %   Detailed explanation goes here
    [XX,YY]=meshgrid(linspace(-P.vs,P.vs,30),linspace(-P.vs,P.vs,30));
    Xv=[XX(:),YY(:)];
    if(not(P.adgrid))
        P.rcp=P.eps*ones(P.N);
    end
    VI=IntOp(Xv,P.Xp,P.rcp);
    Fp=VI*P.f;
    ftarget = exp(-llh(0,Xv));
    figure(fig)
    subplot(3,3,1)
    surf(XX,YY,reshape(Fp,size(XX)))
    shading interp
    title(['rbf f at t = ' num2str(P.t)])
    subplot(3,3,2)
    surf(XX,YY,reshape(Fp,size(XX)))
    view(90,0)
    title('rbf f')
    shading interp
    subplot(3,3,3)
    surf(XX,YY,reshape(ftarget,size(XX)))
    shading interp
    title('equilibrium solution')
    view(90,0)
    subplot(3,3,4)
    surf(XX,YY,reshape(VI*P.D1*P.f,size(XX)))
    shading interp
    title('rbf grad(f)*grad(u)')
    subplot(3,3,5)
    surf(XX,YY,reshape(VI*P.D2*P.f,size(XX)))
    shading interp
    title('rbf div(grad(f))')
    subplot(3,3,6)
    surf(XX,YY,reshape(VI*P.OP*P.f,size(XX)))
    shading interp
    title('rbf -(grad(U)*grad(f)+div(grad(U))*f)+div(grad(f))')
    subplot(3,3,7)
    plot(P.dt*P.EV,'k*')
    hold on
    circle(-1,0,1);
    title('eigenvalues and stability region')
    subplot(3,3,8)
    semilogy(abs(P.c),'k.-');
    title('rbf coefficients')
    subplot(3,3,9)
    title('average L1 and absolute Linf error')
    hold on
    semilogy(P.t,norm(P.f-ftarget,1),'r.-')
    semilogy(P.t,norm(P.f-ftarget,inf),'k.-')
    set(gca,'YScale','log')
    xlabel('time')
    hold off
    drawnow
end

