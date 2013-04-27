function [ P ] = gradient_step( P )
    %GRADIENT_STEP Summary of this function goes here
    %   Detailed explanation goes here
    P = gradient_descent( P );
    
    
    [gamma,P.W(P.Riter)] = fminbnd(@(g) OrgEnergy(P,g),0,1,P.opts);
    
    if(P.kernel_aniso > 1)
        P.Tp = P.Tp + gamma*P.wp;
        P.R = distm(P.Tp,P.Tp);
    else
        P.Xp = P.Xp + gamma*P.wp;
        P.R = distm(P.Xp,P.Xp);
    end
    
    
    
    P = approxDp(P);
    
end

