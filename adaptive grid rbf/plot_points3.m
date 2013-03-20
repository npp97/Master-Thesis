function [] = plot_points3( P,fig )
    %PLOT_POINTS Summary of this function goes here
    %   Detailed explanation goes here
    iter = P.Riter;
    Wv = P.W;
    W2v = P.W;
    Nv = P.NI;
    Pv = P.PI;
    Xv = P.XI;
    
    if(P.kernel_aniso > 1)
        XX = P.Tp;
    else
        XX = P.Xp;
    end
    
    try
        P.Nlist;
    catch
        P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1)))-logical(eye(P.N));
    end
    
    figure(fig)
    clf
    
    subplot(3,4,1)
    scatter3(P.Xp(:,1),P.Xp(:,2),P.Xp(:,3),ones(size(P.rcp))*10,log(P.F)/log(10));
    colorbar
    hold on
    [V,E] = eig(P.M*P.M);
    quiver3(P.Xmean(1),P.Xmean(2),P.Xmean(3),30*E(1,1)*V(1,1),30*E(1,1)*V(1,2),30*E(1,1)*V(1,3))
    quiver3(P.Xmean(1),P.Xmean(2),P.Xmean(3),30*E(2,2)*V(2,1),30*E(2,2)*V(2,2),30*E(2,2)*V(2,3))
    quiver3(P.Xmean(1),P.Xmean(2),P.Xmean(3),30*E(3,3)*V(3,1),30*E(3,3)*V(3,2),30*E(3,3)*V(3,3))
    xlim([-P.vsx,P.vsx])
    ylim([-P.vsy,P.vsy])
    title('points colored by log-function value');
    
    if(P.kernel_aniso == 3)
        P.vsx = P.vsT;
        P.vsy = P.vsT;
    end
    
    subplot(3,4,2)
    scatter3(XX(:,1),XX(:,2),XX(:,3),16*(sum(P.Nlist,1)+1)/max(sum(P.Nlist,1)),sum(P.Nlist,2))
    %surf(VX,VY,reshape(VI*(sum(Nlist,2)+1),size(VX)))
    xlim([-P.vsT,P.vsT])
    ylim([-P.vsT,P.vsT])
    colorbar
    title('#Neighbors')
    
    subplot(3,4,3)
    scatter3(XX(:,1),XX(:,2),XX(:,3),16*P.rcp/max(P.rcp),P.rcp)
    %surf(VX,VY,reshape(VI*rcp,size(VX)))
    xlim([-P.vsT,P.vsT])
    ylim([-P.vsT,P.vsT])
    colorbar
    title('rcp')
    
    subplot(3,4,4)
    
    scatter3(XX(:,1),XX(:,2),XX(:,3),10*ones(size(P.Lp)),P.Lp);
    colorbar
    xlim([-P.vsT,P.vsT])
    ylim([-P.vsT,P.vsT])
    title('particle age (Iterations)');
    
    subplot(3,4,5)
    ii=or((sum(P.Nlist,2)>=P.adap_Nstar),(P.F<P.thresh*P.fmax));
    scatter3(XX(ii,1),XX(ii,2),XX(ii,3),'rx');
    hold on
    scatter3(XX(not(ii),1),XX(not(ii),2),XX(not(ii),3),'bo');
    xlim([-P.vsT,P.vsT])
    ylim([-P.vsT,P.vsT])
    legend('sufficient or not in \Omega','too small and in \Omega')
    title('Too Small Neighborhoods')
    
    subplot(3,4,6)
    ii=P.F<P.thresh*P.fmax;
    scatter3(XX(ii,1),XX(ii,2),XX(ii,3),'rx');
    hold on
    scatter3(XX(not(ii),1),XX(not(ii),2),XX(not(ii),3),'bo');
    xlim([-P.vsT,P.vsT])
    ylim([-P.vsT,P.vsT])
    legend('not in \Omega','in \Omega')
    title('Omega')
    
    subplot(3,4,7)
    plot(1:iter,Pv,'r.-')
    hold on
    plot(1:iter,Xv,'b.-')
    title('Number of Points in Omega')
    xlabel('Iteration')
    ylabel('#')
    
%     subplot(3,4,8)
%     
%     if(size(P.Lh,1)>1&&size(P.Lh,2)>1)
%         surf(P.Lh)
%         title('histogram of particle age')
%         xlabel('Age')
%         ylabel('Iteration')
%         view(0,90)
%         shading interp
%         xlim([1,10]);
%         ylim([1,iter+1])
%         colorbar
%     end

    subplot(3,4,8)
    
    plot(1:iter,P.Mdiffinf,'r.-')
    hold on
    plot(1:iter,P.Mdifffish,'b.-')
    title('Norm of difference in transformation')
    legend('previous iterations','fisher-information')
    xlabel('Iteration')
    ylabel('\Vert \cdot \Vert')
    
    subplot(3,4,9)
    
    plot(1:iter,Wv./Xv,'b.-')
    hold on
    plot(1:iter,W2v./Xv,'r.-')
    title('Average Potential Energy')
    xlabel('Iteration')
    ylabel('Energy')
    
    subplot(3,4,10)
    
    semilogy(1:iter,100*Nv./Pv,'.-')
    title('% of Points in Omega with too small Neighborhood')
    xlabel('Iteration')
    ylabel('Point')
    
%     subplot(3,4,11)
%     
%     semilogy(1:iter,Cv,'.-')
%     hold on
%     semilogy(1:iter,(1:iter)*0+P.adap_dc,'r--')
%     title('Maximal ratio between Dpq and the distance for neighbor points')
%     xlabel('Iteration')
%     ylabel('Point')

    subplot(3,4,11)

    hist(P.crit(logical(P.Nlist)),30)
    xlim([0,P.adap_rstar])
    title('histogram of normalized particle distances in Neighborhood')
    xlabel('normalized distance')
    ylabel('# of occurences')
    
    
    subplot(3,4,12)
    
    semilogy(1:iter,-P.kthresh,'c.-')
    hold on
    semilogy(1:iter,abs(P.kspawn),'g.-')
    semilogy(1:iter,abs(P.kfuse),'b.-')
    semilogy(1:iter,abs(P.kspawn-P.kfuse-P.kthresh),'k.-')
    title('particle balance')
    xlabel('Iteration')
    ylabel('change')
    legend('threshold','spawning','fusion','total');
    
    
    drawnow
    
end

