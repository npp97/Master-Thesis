function [ P ] = interp( P )
    %INTERP Summary of this function goes here
    %   Detailed explanation goes here
    
    disp(['------- RBF Interpolation -------'])
    
    if(P.kernel_aniso > 1)
        P.R = sqrt(sqdistance(P.Tp'));
    else
        P.R = sqrt(sqdistance(P.Xp'));
    end
    
    P = llh(P);

    switch(P.kernel_inverse)
        case 1
            P.eps = fminbnd(@(ep) CostEps(ep,P),1e-3/mean(P.rcp),1e1/mean(P.rcp),optimset('Display','iter'));
            
            if(P.kernel_shape == 2)
                P.eps = P.eps./P.rcp;
            else
                P.eps = P.eps/mean(P.rcp);
            end
            
            P.RBF = rbf(P.R,P.eps);
            P.c = P.RBF\P.F;
        case 2
            P.eps = fminbnd(@(ep) CostEpsRiley(ep,P),1e-3/mean(P.rcp),1e1/mean(P.rcp));
            
            if(P.kernel_shape == 2)
                P.eps = P.eps./P.rcp;
            else
                P.eps = P.eps/mean(P.rcp);
            end
            
            P.RBF = rbf(P.R,P.eps);
            P.c = Riley_mex(P.RBF,P.F,P.riley_mu);
    end
    
            
    
end

