function [ P ] = gradient_descent( P )
    %GRADIENT_DESCENT Summary of this function goes here
    %   Detailed explanation goes here
    % compute total energy and gradient
    P.Dpq = bsxfun(@min,P.Dp,P.Dp');
    if(P.kernel_aniso == 3)
        P.R = distm_mex(P.Tp,P.Tp);
        XX = P.Tp;
        P.wp = zeros(size(P.Tp));
    else
        P.R = distm_mex(P.Xp,P.Xp);
        XX = P.Xp;
        P.wp = zeros(size(P.Xp));
    end
    
    P.W(P.Riter) = sum(sum(P.Dpq.^2*V1_mex(P.R./P.Dpq)));
    
    for k = 1:size(P.wp,1);
        ind = P.R(:,k)<min(P.adap_gradr*P.Dp(k),P.adap_gradr*P.Dp);
        ind(k) = 0;
        Np = XX(ind,:);
        NDp = P.Dp(ind);
        for l=1:size(Np,1)
            r=norm(XX(k,:)-Np(l,:))/min(P.Dp(k),NDp(l));
            P.wp(k,:) = P.wp(k,:) - 2*min(P.Dp(k),NDp(l))*(dV1(r)*(XX(k,:)-Np(l,:))/norm(XX(k,:)-Np(l,:)));% + (2*V1(r)-r*dV1(r))\nabla_x_pDpq);
        end
    end    
end

