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
    param = fminsearch(@(param) CostEps_mls(param,P),[1,1],optimset('Display','iter','MaxIter',500,'MaxFunEvals',10^3));
    P.eps = param(1);
    P.c = param(2)*P.F;
%     param = fminbnd(@(param) CostEps_mls(exp([param,0]),P),-3,3,optimset('Display','iter','MaxIter',500,'MaxFunEvals',10^3));
%     P.esp = param;
%     P.c = P.F;
    % normalize eps
    if(P.kernel_shape == 2)
        P.eps = P.eps./P.rcp;
    else
        P.eps = P.eps/mean(P.rcp);
    end
    
    % compute interpolation matrix
    P.RBF_mls = rbf(P.R,P.eps);    
    
end

