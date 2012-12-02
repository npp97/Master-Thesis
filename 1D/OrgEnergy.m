function W = OrgEnergy(Xp,cDp,cDpNN,D0)
    Dp = cDp(Xp);
    if any(isnan(Dp))
        Dp(isnan(Dp)) = cDpNN(Xp(isnan(Dp),:));
    end
    Dpq = bsxfun(@min,Dp,Dp');
    W = sum(sum(Dpq.^2.*V1_mex(distm_mex(Xp,Xp)./Dpq)));
end