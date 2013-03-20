function [ P ] = refine_particles( P )
    %REFINE_PARTICLES Summary of this function goes here
    %   Detailed explanation goes here
    
    disp(['------- Refining Particles -------'])
    
    % we might start from a previous run
    try
        P.Riter = P.Riter;
    catch
        
        
        P.Riter = 1;
        
        % Initialise Values that are updated every iteration
        P.NI = [];
        P.CI = [];
        P.PI = [];
        P.XI = [];
        P.Lh = [];
        P.W = [];
    end
    P.fuse_hits = 0;
    P.break_hits = 0;
    
    while(P.Riter < P.max_iter)
        
        % find particles that are below removal threshold
        ind = P.F > P.fmax*P.rem_thresh;
        
        % count the number of particles to be removed
        P.kthresh(P.Riter)=P.N-sum(ind);
        
        % remove particles and respective values
        P.F = P.F(ind);
        P.Xp = P.Xp(ind,:);
        if(P.kernel_aniso > 1)
            P.Tp = P.Tp(ind,:);
        end
        P.Dp = P.Dp(ind);
        P.Lp = P.Lp(ind);
        P.rcp = P.rcp(ind);
        P.R = P.R(ind,ind);
        
        % update number of points
        P.N = size(P.Xp,1);
        
        % fuse close particles
        P = fuse_particles( P );
        
        % recalculate Neighborhood sizes
        P = exactDp( P );
        
        % spawn new particles
        P = spawn_particles( P );
        
        % recalculate Neighborhood sizes 
        P = exactDp( P );
        
        % check whether we should do gradient steps
        if(P.Riter>P.adap_gradient_start)
            for s=1:P.adap_ngradstep
                % do specified number of gradient steps
                P = gradient_step( P );
            end
            % calculate energy
            P.Dpq = bsxfun(@min,P.Dp,P.Dp');
            P.W(P.Riter) = sum(sum(P.Dpq.^2*P.pot(P.R./P.Dpq,P.adap_gradr)));
        else
            % calculate energy
            if(P.kernel_aniso > 1)
                P.cDp = TriScatteredInterp(P.Tp,P.Dp);
                P.cDpNN = TriScatteredInterp(P.Tp,P.Dp,'nearest');
            else
                P.cDp = TriScatteredInterp(P.Xp,P.Dp);
                P.cDpNN = TriScatteredInterp(P.Xp,P.Dp,'nearest');
            end
            P.wp = zeros(P.N,P.pdim);
            P.W(P.Riter) = OrgEnergy(P,0);
        end
        
        if(P.kernel_aniso > 1)
            % transform new particles back
            P = TptoXp(P);

            P.Mdiffinf(P.Riter) = 0;
            P.Mdifffish(P.Riter) = 0;

            if(P.Riter>P.cov_iter)
                % calculate new transformation
                P = calc_transform(P);
                % retransform points
                P = XptoTp(P);
                % start with updated 
                P.d0 = P.adap_d0;
                P.D0 = P.adap_D0;
            end
            
        else 

        end
        
        % update function values
        P = llh(P);
        
        % update neighborhood sizes
        P = exactDp(P);
        
        % update distances
        if(P.kernel_aniso > 1)
            P.R = distm(P.Tp,P.Tp);
        else
            P.R = distm(P.Xp,P.Xp);
        end
        P.Dpq = bsxfun(@min,P.Dp,P.Dp');
        
        % analyse distribtion 
        P.crit = P.R./P.Dpq;
        P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1)))-logical(eye(P.N));
        
        P.NI(P.Riter) = sum(and(sum(P.Nlist,2)<P.adap_Nstar,P.F>P.fmax*P.thresh));
        P.RI(P.Riter) = max([max(P.crit(logical(P.Nlist))),0]);
        P.rI(P.Riter) = max([min(P.crit(logical(P.Nlist))),0]);
        P.PI(P.Riter) = sum(P.F>P.fmax*P.thresh);
        P.XI(P.Riter) = P.N;
        P.Lp = P.Lp+ones(size(P.Lp));
        P.Lh = [P.Lh,zeros(size(P.Lh,1),max(size(hist(P.Lp,1:max(P.Lp)),2)-size(P.Lh,2),0));hist(P.Lp,1:max(P.Lp))/P.N,zeros(1,max(size(P.Lh,2)-size(hist(P.Lp,1:max(P.Lp)),2),0))];
        
        
        % plotting
        if(mod(P.Riter,P.plotinter)==0 && P.plotflag)
            switch(P.pdim)
                case 2
                    plot_points2( P , 1 )
                case 3
                    plot_points3( P , 1 )
            end
        end
        
        % check break condition
        if( abs((P.W(P.Riter)-P.W(max(P.Riter-1,1)))/P.W(P.Riter))<1e-2 && P.Riter > 5 && abs(P.XI(P.Riter) - P.XI(max(P.Riter-1,1))) == 0 )
            P.break_hits = P.break_hits + 1;
            if(P.break_hits > 5)       
                break;
            end
        else
            P.break_hits = 0;
        end
        

        if(P.switch_fusion_off && P.NI(P.Riter)==0)
            P.fuse_hits = P.fuse_hits + 1;        
            if( P.fuse_hits >= P.switch_hits );
                P.adap_fusion_method = 2;
                P.pot = @(r,rstar) V3(r,rstar);
                P.dpot = @(r,rstar) dV3(r,rstar);
            end
        else
            P.fuse_hits = 0;
        end

        P.Riter = P.Riter+1;
    end
    
end

