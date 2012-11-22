function [ Xp,Dp,rcp ] = spawn_particles( Xp,Dp,rcp,Nstar,rstar,D0,tol )
    %NEW_PARTICLES Inserts new particles where neighborhood is too small
    %   Detailed explanation goes here
    Rpq = distm_mex(Xp,Xp);
    Nlist = (Rpq<min(repmat(rcp,1,size(Xp,1)),repmat(rcp',size(Xp,1),1)));
    ind = find(Nstar-sum(Nlist)>0);
    for l=ind
        if(prior(Xp(l,:))>tol)
            Nfill=Nstar-sum(distm_mex(Xp(l,:),Xp)<min(rcp,rcp(l))');
            for j=1:Nfill
                % wiki n-sphere
                plot(Xp(l,1),Xp(l,2),'co')
                circle(Xp(l,1),Xp(l,2),Dp(l)/2);
                circle(Xp(l,1),Xp(l,2),rcp(l));
                hold on
                xnew = randn(1,size(Xp,2));
                % normalize & make sure we do not insert points inside the cutoff radii ...
                %xnew = (((rstar-1/2)*rand(1)+1/2)*Dp(l))*xnew/norm(xnew)+Xp(l,:);
                xnew = Dp(l)*xnew/norm(xnew)+Xp(l,:);
                Xp = [Xp; xnew];
                Dp(end+1) = Dp(l);
                rcp(end+1) = rstar*Dp(end);
                plot(xnew(1),xnew(2),'go')
                %%%drawnow
            end
            if(size(rcp,2)>size(rcp,1))
                rcp=rcp';
            end
        end
    end
    drawnow
end

