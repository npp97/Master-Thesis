function [ P ] = gradient_descent( P )
    %GRADIENT_DESCENT Summary of this function goes here
    %   Detailed explanation goes here
    % compute total energy and gradient
    P.Dpq = bsxfun(@min,P.Dp,P.Dp');
    P.R = distm_mex(P.Xp,P.Xp);
    if(P.init)
        P.W(P.Iiter) = sum(sum(P.Dpq.^2*V1_mex(P.R./P.Dpq)));
    else
        P.WA(P.Aiter) = sum(sum(P.Dpq.^2*V1_mex(P.R./P.Dpq)));
    end
    P.wp = zeros(size(P.Xp));
    for k = 1:size(P.Xp,1);
        ind = P.R(:,k)<min(P.rcp(k),P.rcp);
        ind(k) = 0;
        Np = P.Xp(ind,:);
        NDp = P.Dp(ind);
        for l=1:size(Np,1)
            r=norm(P.Xp(k,:)-Np(l,:))/min(P.Dp(k),NDp(l));
            P.wp(k,:) = P.wp(k,:) - 2*min(P.Dp(k),NDp(l))*(dV1(r)*(P.Xp(k,:)-Np(l,:))/norm(P.Xp(k,:)-Np(l,:)));% + (2*V1(r)-r*dV1(r))\nabla_x_pDpq);
        end
    end    
end

