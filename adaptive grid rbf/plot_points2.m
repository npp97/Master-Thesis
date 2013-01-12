function [] = plot_points2( P,fig )
    %PLOT_POINTS Summary of this function goes here
    %   Detailed explanation goes here
    iter = P.Riter;
    Wv = P.W;
    W2v = P.W;
    Cv = P.CI;
    Nv = P.NI;
    Pv = P.PI;
    Xv = P.XI;
    
    if(P.kernel_aniso > 1)
        XX = P.Tp;
    else
        XX = P.Xp;
    end
    
    figure(fig)
    clf
    
    subplot(3,4,1)
    scatter(P.Xp(:,1),P.Xp(:,2),ones(size(P.rcp))*10,log(P.F)/log(10));
    colorbar
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    title('points colored by log-function value');
    
    if(P.kernel_aniso > 1)
        P.vsx = P.vsT;
        P.vsy = P.vsT;
    end
    
    subplot(3,4,2)
    
    scatter(XX(:,1),XX(:,2),16*(sum(P.Nlist,1)+1)/max(sum(P.Nlist,1)),sum(P.Nlist,2))
    %surf(VX,VY,reshape(VI*(sum(Nlist,2)+1),size(VX)))
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    view(0,90)
    colorbar
    title('#Neighbors')
    
    subplot(3,4,3)
    scatter(XX(:,1),XX(:,2),16*P.rcp/max(P.rcp),P.rcp)
    %surf(VX,VY,reshape(VI*rcp,size(VX)))
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    view(0,90)
    colorbar
    title('rcp')
    
    subplot(3,4,4)
    
    scatter(XX(:,1),XX(:,2),10*ones(size(P.Lp)),P.Lp);
    colorbar
    xlim([-P.vsT,P.vsT])
    ylim([-P.vsT,P.vsT])
    title('particle age (Iterations)');
    
    subplot(3,4,5)
    gscatter(XX(:,1),XX(:,2),and((sum(P.Nlist,2)<P.adap_Nstar),(P.F>P.thresh*P.fmax)),'br','ox')
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    legend('sufficient or not in \Omega','too small and in \Omega')
    title('Too Small Neighborhoods')
    
    subplot(3,4,6)
    gscatter(XX(:,1),XX(:,2),P.F<P.thresh*P.fmax,'br','ox')
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    legend('in \Omega','not in \Omega')
    title('Omega')
    
    subplot(3,4,7)
    plot(1:iter,Pv,'r.-')
    hold on
    plot(1:iter,Xv,'b.-')
    title('Number of Points in Omega')
    xlabel('Iteration')
    ylabel('#')
    
    subplot(3,4,8)
    
    if(size(P.Lh,1)>1&&size(P.Lh,2)>1)
        surf(P.Lh)
        title('histogram of particle age')
        xlabel('Age')
        ylabel('Iteration')
        view(0,90)
        shading interp
        xlim([1,10]);
        ylim([1,iter+1])
        colorbar
    end
    
    subplot(3,4,9)
    
    plot(1:iter,Wv./Xv,'b.-')
    hold on
    plot(1:iter,W2v./Xv,'r.-')
    title('Average Potential Energy')
    xlabel('Iteration')
    ylabel('Energy')
    
    subplot(3,4,10)
    
    plot(1:iter,100*Nv./Pv,'.-')
    title('% of Points in Omega with too small Neighborhood')
    xlabel('Iteration')
    ylabel('Point')
    
    subplot(3,4,11)
    
    semilogy(1:iter,Cv,'.-')
    hold on
    semilogy(1:iter,(1:iter)*0+P.adap_dc,'r--')
    title('Maximal ratio between Dpq and the distance for neighbor points')
    xlabel('Iteration')
    ylabel('Point')
    
    subplot(3,4,12)
    
    plot(1:iter,-P.kthresh,'c.-')
    hold on
    plot(1:iter,P.kspawn,'g.-')
    plot(1:iter,-P.kfuse,'b.-')
    plot(1:iter,P.kspawn-P.kfuse-P.kthresh,'k.-')
    title('particle balance')
    xlabel('Iteration')
    ylabel('change')
    legend('threshold','spawning','fusion','total');
    
    
    drawnow
    
end

