function [ P ] = gradient_descent( P )
    %GRADIENT_DESCENT Summary of this function goes here
    %   Detailed explanation goes here
    % compute total energy and gradient
    P.Dpq = bsxfun(@min,P.Dp,P.Dp');
    if(P.kernel_aniso > 1)
        XX = P.Tp;
        P.wp = zeros(size(P.Tp));
    else
        XX = P.Xp;
        P.wp = zeros(size(P.Xp));
    end
    
    for k = 1:size(P.wp,1);
        ind = P.R(:,k)<min(P.adap_gradr*P.Dp(k),P.adap_gradr*P.Dp);
        ind(k) = 0;
        Np = XX(ind,:);
        NDp = P.Dp(ind);
        for l=1:size(Np,1)
            r=norm(XX(k,:)-Np(l,:))/min(P.Dp(k),NDp(l));
            P.wp(k,:) = P.wp(k,:) - 2*min(P.Dp(k),NDp(l))*(P.dpot(r,P.adap_gradr)*(XX(k,:)-Np(l,:))/norm(XX(k,:)-Np(l,:)));% + (2*V1(r)-r*dV1(r))\nabla_x_pDpq);
        end
    end    
end

