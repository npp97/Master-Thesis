function [ wp,W ] = gradient_descent( Xp,Dp,rcp,rstar,D0,W,iter,opts )
    %GRADIENT_DESCENT Summary of this function goes here
    %   Detailed explanation goes here
    % compute total energy and gradient
    Dpq = bsxfun(@min,Dp,Dp');
    W(iter) = sum(sum(Dpq.^2*V1(distm_mex(Xp,Xp)./Dpq)));
    wp = zeros(size(Xp));
    for k = 1:size(Xp,1);
        ind = distm_mex(Xp,Xp(k,:))<min(rcp(k),rcp);
        ind(k) = 0;
        Np = Xp(ind,:);
        NDp = Dp(ind);
        for l=1:size(Np,1)
            r=norm(Xp(k,:)-Np(l,:))/min(Dp(k),NDp(l));
            wp(k,:) = wp(k,:) - 2*min(Dp(k),NDp(l))*(dV1(r)*(Xp(k,:)-Np(l,:))/norm(Xp(k,:)-Np(l,:)));% + (2*V1(r)-r*dV1(r))\nabla_x_pDpq);
        end
    end    
end

