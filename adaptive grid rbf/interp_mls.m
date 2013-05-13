function [ P ] = interp_mls( P )
    %INTERP_MLS Summary of this function goes here
    %   Detailed explanation goes here
    
    disp(['------- MLS RBF Interpolation -------'])
    
    % compute distances
    if(P.kernel_aniso > 1)
        P.R = sqrt(sqdistance(P.Tp'));
    else
        P.R = sqrt(sqdistance(P.Xp'));
    end
    
    % get function values
    disp(['# Evaluating Function '])
%     P = llh(P);

    % estimate optimal eps
    disp(['# Optimizing Shape Parameter '])
    P.error_estim = 1;
    eps = fminbnd(@(param) CostEps_mls(exp([param,0]),P),-2,2,optimset('Display','iter','MaxIter',500,'MaxFunEvals',10^3));
    if(P.kernel_shape == 2)
        P.eps = exp(eps)/P.rcp;
    else
        P.eps = exp(eps)/mean(P.rcp);
    end
    P.c = P.F;
    P.error_estim = 2;
    alpha = fminbnd(@(param) CostEps_mls([exp(eps),param],P),1e-3,1,optimset('Display','iter','MaxIter',500,'MaxFunEvals',10^3));
    P.c = alpha*P.F;
    P.error_estim = 1;

    % normalize eps

    
    % compute interpolation matrix
    P.RBF_mls = rbf(P.R,P.eps);    
    
end

