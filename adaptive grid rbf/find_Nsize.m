function [P,Px] = find_Nsize( P )

    
    % tries
    for k = 1:10
        Ps = P;
        % intialise
        Ps.Xp(1,:) = zeros(1,Ps.pdim);
        Ps.Tp(1,:) = zeros(1,Ps.pdim);
        Ps.F(1) = 1;
        Ps.Dp(1) = 1;
        Ps.rcp(1) = Ps.adap_rstar;
        Ps.adap_Nstar = 10^Ps.pdim;
        Ps.N=1;
        Ps.Riter = 1;
        Ps.fmax = 1;
        Ps.M = eye(Ps.pdim);
        Ps.Xmean = zeros(1,Ps.pdim);
        Ps.Lp = 1;
        Ps.D0 = 1;
        Ps.d0 = 1;
        Ps.finding_Nsize = true;
        Ps.adap_fusion_method = 1;
        
        N = 1;
        % iterations
        for j = 1:50
            % spawn particles
            Ps = spawn_particles( Ps );
            % all new particles should have value 0 and radius 1
            if(Ps.kernel_aniso > 1)
                Ps = TptoXp(Ps);
                Ps.R1 = distm_mex(Ps.Tp(1,:),Ps.Tp);
            else
                Ps.R1 = distm_mex(Ps.Xp(1,:),Ps.Xp);
            end
            ind = (Ps.R1<Ps.adap_rstar);
            Ps.F = zeros(Ps.N,1);
            Ps.F(ind) = ones(sum(ind),1);
            Ps.Dp(1:Ps.N) = 1;
            Ps.rcp(1:Ps.N) = Ps.adap_rstar;
            % create Xp if necessary

            
            % fuse particles
            Ps = fuse_particles( Ps );
            
            % fix size
            if (size(Ps.Dp,2)>size(Ps.Dp,1))
                Ps.Dp = Ps.Dp';
            end
            
            % gradient step
            Ps = gradient_step( Ps );

        end
        Ps = fuse_particles( Ps );
        if(Ps.kernel_aniso > 1)
            Ps = TptoXp(Ps);
            Ps.R1 = distm_mex(Ps.Tp(1,:),Ps.Tp);
        else
            Ps.R1 = distm_mex(Ps.Xp(1,:),Ps.Xp);
        end
        ind = (Ps.R1<Ps.adap_rstar);
        if(sum(ind)>N)
            Px = Ps;
        end
        N = max(N,sum(ind));
    end
    
    % find neighborhood size
    P.adap_Nstar = N - 1;
    
    figure(3)
    scatter(Ps.Xp(:,1),Ps.Xp(:,2))
    
    display([' Found optimal Neighborhood size ' num2str(P.adap_Nstar) ])
    
end