function [] = plot_operator( Xp,Xp_adv,vs,f,F,E,D1,D2,EV,dt,c,fig )
    %PLOT_OPERATOR Summary of this function goes here
    %   Detailed explanation goes here
    figure(fig)
    subplot(3,3,1)
    plot(Xp(:,1),Xp(:,2),'bo')
    xlim([-vs,vs])
    ylim([-vs,vs])
    drawnow
    hold on
    plot(Xp(:,1),Xp(:,2),'ro')
    subplot(3,3,2)
    tri_p=delaunay(Xp(:,1),Xp(:,2));
    trisurf(tri_p,Xp(:,1),Xp(:,2),f)
    title('starting f')
    subplot(3,3,3)
    tri_adv=delaunay(Xp_adv(:,1),Xp_adv(:,2));
    trisurf(tri_adv,Xp_adv(:,1),Xp_adv(:,2),F);
    title('new f')
    subplot(3,3,4)
    trisurf(tri_adv,Xp_adv(:,1),Xp_adv(:,2),E*f);
    title('interpolated F')
    subplot(3,3,5)
    trisurf(tri_adv,Xp_adv(:,1),Xp_adv(:,2),D1*f);
    title('grad(U)*grad(f)')
    subplot(3,3,6)
    trisurf(tri_adv,Xp_adv(:,1),Xp_adv(:,2),D2*f);
    title('div(grad(f))')
    subplot(3,3,7)
    plot(dt*EV,'k*')
    hold on  
    circle(-1,0,1);
    subplot(3,3,8)
    semilogy(abs(c),'k.-');
    subplot(3,3,9)
    trisurf(tri_adv,Xp_adv(:,1),Xp_adv(:,2),c);
    drawnow
    
end

