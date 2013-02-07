function [ P ] = spawn_particles( P )
    %NEW_PARTICLES Inserts new particles where neighborhood is too small
    %   Detailed explanation goes here
    P.kspawn(P.Riter)=0;
    if(P.kernel_aniso > 1)
        P.R = distm_mex(P.Tp,P.Tp);
    else
        P.R = distm_mex(P.Xp,P.Xp);
    end
    P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1))-eye(P.N));
    
    
    ind = find(P.adap_Nstar-sum(P.Nlist)>0);
    for l=ind
        inbound = true;
        for k=1:P.pdim
            if(P.Xp(l,k)<P.paramspec{k}{3}||P.Xp(l,k)>P.paramspec{k}{4})
                inbound = false;
                break
            end
        end
       
        if(P.F(l)>P.fmax*P.thresh && inbound)
            if(P.kernel_aniso > 1)
                nbor = distm_mex(P.Tp(l,:),P.Tp)<min(P.rcp,P.rcp(l))';
                Nfill=P.adap_Nstar-sum(nbor)+1;
            else
                nbor = distm_mex(P.Xp(l,:),P.Xp)<min(P.rcp,P.rcp(l))';
                Nfill=P.adap_Nstar-sum(nbor)+1;
            end
            
            for j=1:Nfill
                xnew = randn(1,P.pdim);
                switch(P.adap_spawn_method)
                    case 1
                        xnew = P.Dp(l)*(xnew)/norm(xnew);
                    case 2
                        if(P.kernel_aniso > 1)
                            xhat = mean(bsxfun(@minus,P.Tp(nbor,:),P.Tp(l,:)));
                        else
                            xhat = mean(bsxfun(@minus,P.Xp(nbor,:),P.Xp(l,:)));
                        end
                        xnew = P.Dp(l)*(xnew-xhat)/norm(xnew-xhat);
                end
                
                if(P.adap_spawn_var)
                    xnew=((P.adap_rstar-1/2)*rand(1)+1/2)*xnew;
                end
                
                if(P.kernel_aniso > 1)
                    P.Tp = [P.Tp; xnew+P.Tp(l,:)];
                else
                    P.Xp = [P.Xp; xnew+P.Xp(l,:)];
                end
                
                % initialise new particle
                P.Dp(end+1) = P.Dp(l);
                if(not(P.finding_Nsize))
                    if(P.kernel_aniso > 1)
                        if(P.kernel_aniso_method > 2)
                            P.F(end+1) = eval_llh(xnew*P.M(:,:,l)+P.Xmean,P);
                        else
                            P.F(end+1) = eval_llh(xnew*P.M+P.Xmean,P);
                        end
                    else
                        P.F(end+1) = eval_llh(xnew,P);
                    end
                end
                P.Lp(end+1) = 0;
                P.rcp(end+1) = P.adap_rstar*P.Dp(end);
                if(P.kernel_aniso == 3)
                    P.M(:,:,end+1) = P.M(:,:,l);
                end
                P.kspawn(P.Riter)=P.kspawn(P.Riter)+1;
                P.N=P.N+1;
            end
            if(size(P.rcp,2)>size(P.rcp,1))
                P.rcp=P.rcp';
            end
        end
    end
end


