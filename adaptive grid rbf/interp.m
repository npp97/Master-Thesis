function [ P ] = interp( P )
    %INTERP Summary of this function goes here
    %   Detailed explanation goes here
    if(P.kernel_aniso > 1)
        P.R = distm_mex(P.Tp,P.Tp);
    else
        P.R = distm_mex(P.Xp,P.Xp);
    end
    P = llh(P);
    

    
    switch(P.kernel_inverse)
        case 1
            P.eps = fminsearch(@(ep) CostEps(ep,P),2/mean(P.rcp));

            if(P.kernel_shape == 2)
                P.eps = P.eps./P.rcp;
            else
                P.eps = P.eps/mean(P.rcp);
            end
            
            P.RBF = rbf(P.R,P.eps);
            P.c = P.RBF\P.F;
        case 2
            P.eps = fminbnd(@(ep) CostEpsRiley(ep,P),P.kernel_eps_min,P.kernel_eps_max);
            
            if(P.kernel_shape == 2)
                P.eps = P.eps./P.rcp;
            else
                P.eps = P.eps/mean(P.rcp);
            end
            
            P.RBF = rbf(P.R,P.eps);
            P.c = Riley_mex(P.RBF,P.F,P.riley_mu);
    end
    
            
    
end

