function [ P ] = fuse_particles( P )
    %FUSE_PARTICLES fuse particles where |xp_xq|<Dpq/2
    % do this in a greedy-type fashion by removing particles with most points inside the cutoff radius first
    
    if(P.kernel_aniso == 3)
        P.R = distm_mex(P.Tp,P.Tp);
    else
        P.R = distm_mex(P.Xp,P.Xp);
    end
    while(true)
        P.Dpq = bsxfun(@min,P.Dp,P.Dp');
        ind = P.R<P.Dpq/2;
        if(max(sum(ind))==1)
            P.rcp = P.adap_rstar*P.Dp;
            break
        else
            [~,ind] = max(sum(ind));
%             plot(P.Xp(ind,1),P.Xp(ind,2),'ro')
            P.Dp=P.Dp([1:ind-1 ind+1:end]);
            P.Xp=P.Xp([1:ind-1 ind+1:end],:);
            if(P.kernel_aniso == 3)
                P.Tp=P.Tp([1:ind-1 ind+1:end],:);
            end
            P.F=P.F([1:ind-1 ind+1:end]);
            P.Lp=P.Lp([1:ind-1 ind+1:end]);
            P.rcp = P.adap_rstar*P.Dp;
            P.R=P.R([1:ind-1 ind+1:end],[1:ind-1 ind+1:end]);
            P.N=P.N-1;
        end
    end
%     drawnow
end

