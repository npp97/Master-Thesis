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
    P.eps = fminbnd(@(ep) CostEps_mls(ep,P),1e-3/mean(P.rcp),1e1/mean(P.rcp),optimset('Display','iter'));
    P.c = P.F;
    
    % normalize eps
    if(P.kernel_shape == 2)
        P.eps = P.eps./P.rcp;
    else
        P.eps = P.eps/mean(P.rcp);
    end
    
    % compute interpolation matrix
    P.RBF_mls = rbf(P.R,P.eps);    
    
end

