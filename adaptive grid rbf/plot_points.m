function [] = plot_points( P,fig )
    %PLOT_POINTS Summary of this function goes here
    %   Detailed explanation goes here
    iter = P.Riter;
    Wv = P.W;
    Cv = P.CI;
    Nv = P.NI;
    Pv = P.PI;

    figure(fig)
    tri = delaunay(P.Xp(:,1),P.Xp(:,2));
    %VI=IntOp(Xv,Xp,rcp);
    
    subplot(3,3,1)
    scatter(P.Xp(:,1),P.Xp(:,2),16*P.rcp/max(P.rcp),log(P.F));
    colorbar
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    title('points');
    
    subplot(3,3,2)
    trisurf(tri,P.Xp(:,1),P.Xp(:,2),log(P.F))
    %surf(VX,VY,reshape(VI*(sum(Nlist,2)+1),size(VX)))
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    shading interp
    view(0,90)
    colorbar
    title('f')
    
    subplot(3,3,3)
    
    scatter(P.Xp(:,1),P.Xp(:,2),16*(sum(P.Nlist,1)+1)/max(sum(P.Nlist,1)),sum(P.Nlist,2))
    %surf(VX,VY,reshape(VI*(sum(Nlist,2)+1),size(VX)))
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    shading interp
    view(0,90)
    colorbar
    title('#Neighbors')
    
    subplot(3,3,4)
    scatter(P.Xp(:,1),P.Xp(:,2),12*P.rcp/max(P.rcp),P.rcp)
    %surf(VX,VY,reshape(VI*rcp,size(VX)))
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    shading interp
    view(0,90)
    colormap(jet)
    colorbar
    title('rcp')
    
    subplot(3,3,6)
    plot(1:iter,Pv,'-.')
    title('Number of Points')
    xlabel('Iteration')
    ylabel('#')
    
    
    subplot(3,3,7)

    plot(1:iter,Wv,'.-')
    title('Potential Energy')
    xlabel('Iteration')
    ylabel('Energy')
    
    subplot(3,3,8)

    plot(1:iter,100*Nv./Pv,'.-')
    title('% of Points with too small Neighborhood')
    xlabel('Iteration')
    ylabel('Point')
    
    subplot(3,3,9)

    semilogy(1:iter,Cv,'.-')
    hold on
    semilogy(1:iter,(1:iter)*0+P.adap_dc,'r--')
    title('Maximal ratio between Dpq and the distance for neighbor points')
    xlabel('Iteration')
    ylabel('Point')
    
end

