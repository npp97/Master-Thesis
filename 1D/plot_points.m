function [] = plot_points( Xv,Xp,rcp,Fp,VX,VY,W,NN,CC,dc,iter,Nlist,Nstar,vs,fig )
    %PLOT_POINTS Summary of this function goes here
    %   Detailed explanation goes here
    figure(fig)
    tri = delaunay(Xp(:,1),Xp(:,2));
    VI=IntOp(Xv,Xp,rcp);
    
    subplot(3,3,2)
    trisurf(tri,Xp(:,1),Xp(:,2),Fp)
    %surf(VX,VY,reshape(VI*(sum(Nlist,2)+1),size(VX)))
    xlim([-vs,vs])
    ylim([-vs,vs])
    shading interp
    view(0,90)
    colorbar
    title('f')
    
    subplot(3,3,3)
    trisurf(tri,Xp(:,1),Xp(:,2),max(sum(Nlist,2)+1,Nstar))
    %surf(VX,VY,reshape(VI*(sum(Nlist,2)+1),size(VX)))
    xlim([-vs,vs])
    ylim([-vs,vs])
    shading interp
    view(0,90)
    colorbar
    title('#Neighbors')
    
    subplot(3,3,4)
    trisurf(tri,Xp(:,1),Xp(:,2),rcp)
    %surf(VX,VY,reshape(VI*rcp,size(VX)))
    xlim([-vs,vs])
    ylim([-vs,vs])
    shading interp
    view(0,90)
    colormap(jet)
    colorbar
    title('rcp')
    
    subplot(3,3,5)
    surf(VX,VY,reshape(prior(Xv),size(VX)))
    shading interp
    view(0,90)
    colorbar
    title('prior f')
    
    subplot(3,3,6)
    surf(VX,VY,reshape(ngprior(Xv),size(VX)))
    shading interp
    view(0,90)
    colorbar
    title('prior ||grad(f)||')
    drawnow
    
    subplot(3,3,7)
    plot(1:iter,W,'.-')
    title('Potential Energy')
    xlabel('Iteration')
    ylabel('Energy')
    
    subplot(3,3,8)

    plot(1:iter,NN,'.-')
    title('Number of Points with too small Neighborhood')
    xlabel('Iteration')
    ylabel('Point')
    
    subplot(3,3,9)

    semilogy(1:iter,CC,'.-')
    hold on
    semilogy(1:iter,(1:iter)*0+dc,'r--')
    title('Maximal ratio between Dpq and the distance for neighbor points')
    xlabel('Iteration')
    ylabel('Point')
    
end
