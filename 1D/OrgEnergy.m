function W = OrgEnergy(Xp,cDp,D0)
    Dp = cDp(Xp);
    Dpq = bsxfun(@min,Dp,Dp');
    W = sum(sum(Dpq.^2.*V1_mex(distm_mex(Xp,Xp)./Dpq)));
end