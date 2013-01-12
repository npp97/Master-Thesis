function [ P ] = gradient_step( P )
    %GRADIENT_STEP Summary of this function goes here
    %   Detailed explanation goes here
    P = gradient_descent( P );
    
    if(P.kernel_aniso > 1)
        P.cDp = TriScatteredInterp(P.Tp,P.Dp);
        P.cDpNN = TriScatteredInterp(P.Tp,P.Dp,'nearest');
    else
        P.cDp = TriScatteredInterp(P.Xp,P.Dp);
        P.cDpNN = TriScatteredInterp(P.Xp,P.Dp,'nearest');
    end
    
    [gamma] = fminsearch(@(g) OrgEnergy(P,g),0,P.opts);
    
    if(P.kernel_aniso > 1)
        P.Tp = P.Tp + gamma*P.wp;
    else
        P.Xp = P.Xp + gamma*P.wp;
    end
    
    P = exactDp(P);
    
end

