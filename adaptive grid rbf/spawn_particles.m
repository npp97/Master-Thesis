function [ P ] = spawn_particles( P )
    %NEW_PARTICLES Inserts new particles where neighborhood is too small
    %   Detailed explanation goes here
    if(P.kernel_aniso == 3)
        P.R = distm_mex(P.Tp,P.Tp);
    else
        P.R = distm_mex(P.Xp,P.Xp);
    end

    P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1)));
    ind = find(P.adap_Nstar-sum(P.Nlist)>0);
    for l=ind
        if(P.F(l)>P.fmax*P.thresh)
            if(P.kernel_aniso == 3)
                Nfill=P.adap_Nstar-sum(distm_mex(P.Tp(l,:),P.Tp)<min(P.rcp,P.rcp(l))');
            else
                Nfill=P.adap_Nstar-sum(distm_mex(P.Xp(l,:),P.Xp)<min(P.rcp,P.rcp(l))');
            end
            for j=1:Nfill
                % wiki n-sphere
%                 plot(P.Xp(l,1),P.Xp(l,2),'co')
%                 circle(P.Xp(l,1),P.Xp(l,2),P.Dp(l)/2);
%                 circle(P.Xp(l,1),P.Xp(l,2),P.rcp(l));
%                 hold on
                xnew = randn(1,size(P.Xp,2));
                % normalize & make sure we do not insert points inside the cutoff radii ...
                %xnew = (((rstar-1/2)*rand(1)+1/2)*Dp(l))*xnew/norm(xnew)+Xp(l,:);
                
                if(P.kernel_aniso == 3)
                    xnew = P.Dp(l)*xnew/norm(xnew)+P.Tp(l,:);
                    P.Tp = [P.Tp; xnew];
                else
                    xnew = P.Dp(l)*xnew/norm(xnew)+P.Xp(l,:);
                    P.Xp = [P.Xp; xnew];
                end
                P.Dp(end+1) = P.Dp(l);
                if(P.kernel_aniso == 3)
                    P.F(end+1) = eval_llh(xnew*P.M+P.Xmean,P);
                else
                    P.F(end+1) = eval_llh(xnew,P);
                end
                P.Lp(end+1) = 0;
                P.rcp(end+1) = P.adap_rstar*P.Dp(end);
%                 plot(xnew(1),xnew(2),'go')
                P.N=P.N+1;
            end
            if(size(P.rcp,2)>size(P.rcp,1))
                P.rcp=P.rcp';
            end
        end
    end
    drawnow
end

