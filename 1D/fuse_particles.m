function [ Xp,rcp ] = fuse_particles( Xp,Dp,rstar )
    %FUSE_PARTICLES fuse particles where |xp_xq|<Dpq/2
    % do this in a greedy-type fashion by removing particles with most points inside the cutoff radius first
    while(true)
        Dpq = bsxfun(@min,Dp,Dp');
        ind = distm_mex(Xp,Xp)<Dpq/2;
        if(max(sum(ind))==1)
            rcp = rstar*Dp;
            break
        else
            [m,ind] = max(sum(ind));
            plot(Xp(ind,1),Xp(ind,2),'ro')
            Dp=Dp([1:ind-1 ind+1:end]);
            Xp=Xp([1:ind-1 ind+1:end],:);
            rcp = rstar*Dp;
        end
    end
    drawnow
end

