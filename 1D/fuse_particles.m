function [ P ] = fuse_particles( P )
    %FUSE_PARTICLES fuse particles where |xp_xq|<Dpq/2
    % do this in a greedy-type fashion by removing particles with most points inside the cutoff radius first
    while(true)
        P.Dpq = bsxfun(@min,P.Dp,P.Dp');
        ind = distm_mex(P.Xp,P.Xp)<P.Dpq/2;
        if(max(sum(ind))==1)
            P.rcp = P.rstar*P.Dp;
            break
        else
            [m,ind] = max(sum(ind));
            plot(P.Xp(ind,1),P.Xp(ind,2),'ro')
            P.Dp=P.Dp([1:ind-1 ind+1:end]);
            P.Xp=P.Xp([1:ind-1 ind+1:end],:);
            P.Fp=P.Fp([1:ind-1 ind+1:end]);
            P.rcp = P.rstar*P.Dp;
            P.N=P.N-1;
        end
    end
    drawnow
end

