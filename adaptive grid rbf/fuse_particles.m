function [ P ] = fuse_particles( P )
    %FUSE_PARTICLES fuse particles where |xp_xq|<Dpq/2
    % do this in a greedy-type fashion by removing particles with most points inside the cutoff radius first

    P.kfuse(P.Riter)=0;
    switch(P.adap_fusion_method)
        case 1
            % 1: where particles are too close to each other
            % initialise counter
            P.kfuse(P.Riter)=0;
            % compute distances
            if(P.Riter == 1) % otherwise we have already computed the distances in the previous iteration
                if(P.kernel_aniso > 1)
                    P.R = sqrt(sqdistance(P.Tp'));
                else
                    P.R = sqrt(sqdistance(P.Xp'));
                end
            end
            % compute neighborhood sizes
            P.Dpq = bsxfun(@min,P.Dp,P.Dp');
            % check for too close particles
            ii = sparse(P.R<P.Dpq/2-eye(P.N));
            % get indexes for too small particles
            [row,col] = find(ii);
            ti = row(row>col);
            % remove particles
            P.Dp(ti)=[];
            P.Xp(ti,:)=[];
            if(P.kernel_aniso > 1)
                P.Tp(ti,:)=[];
                if(P.kernel_aniso > 2)
                    P.M(:,:,ti)=[];
                end
            end
            P.R(ti,:)=[];
            P.R(:,ti)=[];
            P.F(ti)=[];
            P.Lp(ti)=[];
            P.rcp(ti)=[];
            % count removes particles
            P.kfuse(P.Riter)=P.kfuse(P.Riter) + P.N-size(P.Xp,1);
            % update number of particles
            P.N=size(P.Xp,1);
        case 2
            % 2: no fusion
            % nothing to do
    end
end

