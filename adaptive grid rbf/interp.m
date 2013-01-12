function [ P ] = interp( P )
    %INTERP Summary of this function goes here
    %   Detailed explanation goes here
    if(P.kernel_aniso > 1)
        P.R = distm_mex(P.Tp,P.Tp);
    else
        P.R = distm_mex(P.Xp,P.Xp);
    end
    P = llh(P);
    
    switch(P.kernel_shape)
        case 1% 1: global
            P.eps = fminsearch(@(ep) CostEpsRiley(ep,P),P.kernel_eps_min,P.kernel_eps_max);
            P.RBF = rbf(P.R,P.eps);
            P.c = Riley_mex(P.RBF,P.F,P.riley_mu);
        case 2% 2: local
            
        case 3% 3: local anisotropic
            
    end
    
end

