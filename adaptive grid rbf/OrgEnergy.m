function W = OrgEnergy(P,g)
    if(P.kernel_aniso > 1)
        P.Tp = P.Tp + g*P.wp;
        P.R = distm_mex(P.Tp,P.Tp);
        Dp = P.cDp(P.Tp);
        if (any(isnan(Dp)) || numel(Dp)==0)
            Dp(isnan(Dp)) = P.cDpNN(P.Tp(isnan(Dp),:));
        elseif(numel(Dp)==0)
            Dp = P.cDpNN(P.Tp);
        end
    else
        P.Xp = P.Xp + g*P.wp;
        P.R = distm_mex(P.Xp,P.Xp);
        Dp = P.cDp(P.Xp);
        if (any(isnan(Dp)))
            Dp(isnan(Dp)) = P.cDpNN(P.Xp(isnan(Dp),:));
        elseif(numel(Dp)==0)
            Dp = P.cDpNN(P.Xp);
        end
    end
    

    Dpq = bsxfun(@min,Dp,Dp');
    W = sum(sum(Dpq.^2.*P.pot(P.R./Dpq,P.adap_gradr)));
end