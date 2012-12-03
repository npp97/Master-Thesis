function [] = plot_points( P,fig )
    %PLOT_POINTS Summary of this function goes here
    %   Detailed explanation goes here
    if(P.init)
        iter=P.Iiter;
        Wv = P.W;
        Cv = P.CI;
        Nv = P.NI;
        P.Fp = prior(P.Xp);
    else
        iter=P.Aiter;
        Wv = P.WA;
        Cv = P.CA;
        Nv = P.NA;
        P.Fp = IntOp(P.Xp,P.Xp_old,P.rcp_old)*P.f;
    end
    figure(fig)
    tri = delaunay(P.Xp(:,1),P.Xp(:,2));
    %VI=IntOp(Xv,Xp,rcp);
    
    subplot(3,3,2)
    trisurf(tri,P.Xp(:,1),P.Xp(:,2),P.Fp)
    %surf(VX,VY,reshape(VI*(sum(Nlist,2)+1),size(VX)))
    xlim([-P.vs,P.vs])
    ylim([-P.vs,P.vs])
    shading interp
    view(0,90)
    colorbar
    title('f')
    
    subplot(3,3,3)
    trisurf(tri,P.Xp(:,1),P.Xp(:,2),max(sum(P.Nlist,2)+1,P.Nstar))
    %surf(VX,VY,reshape(VI*(sum(Nlist,2)+1),size(VX)))
    xlim([-P.vs,P.vs])
    ylim([-P.vs,P.vs])
    shading interp
    view(0,90)
    colorbar
    title('#Neighbors')
    
    subplot(3,3,4)
    trisurf(tri,P.Xp(:,1),P.Xp(:,2),P.rcp)
    %surf(VX,VY,reshape(VI*rcp,size(VX)))
    xlim([-P.vs,P.vs])
    ylim([-P.vs,P.vs])
    shading interp
    view(0,90)
    colormap(jet)
    colorbar
    title('rcp')
    
    subplot(3,3,5)
    surf(P.VX,P.VY,reshape(prior(P.Xv),size(P.VX)))
    shading interp
    view(0,90)
    colorbar
    title('prior f')
    
    subplot(3,3,6)
    surf(P.VX,P.VY,reshape(ngprior(P.Xv),size(P.VX)))
    shading interp
    view(0,90)
    colorbar
    title('prior ||grad(f)||')
    drawnow
    
    subplot(3,3,7)

    plot(1:iter,Wv,'.-')
    title('Potential Energy')
    xlabel('Iteration')
    ylabel('Energy')
    
    subplot(3,3,8)

    plot(1:iter,Nv,'.-')
    title('Number of Points with too small Neighborhood')
    xlabel('Iteration')
    ylabel('Point')
    
    subplot(3,3,9)

    semilogy(1:iter,Cv,'.-')
    hold on
    semilogy(1:iter,(1:iter)*0+P.dc,'r--')
    title('Maximal ratio between Dpq and the distance for neighbor points')
    xlabel('Iteration')
    ylabel('Point')
    
end

