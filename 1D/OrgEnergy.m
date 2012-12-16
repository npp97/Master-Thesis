function W = OrgEnergy(P,g)
    P.Xp = P.Xp + g*P.wp;
    Dp = P.cDp(P.Xp);
    if any(isnan(Dp))
        Dp(isnan(Dp)) = P.cDpNN(P.Xp(isnan(Dp),:));
    end
    Dpq = bsxfun(@min,Dp,Dp');
    W = sum(sum(Dpq.^2.*V1_mex(distm_mex(P.Xp,P.Xp)./Dpq)));
end