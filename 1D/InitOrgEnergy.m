function W = InitOrgEnergy(P)
    P.DF = ngprior(P.Xp);
    P = exactDp(P);
    P.Dpq = bsxfun(@min,P.Dp,P.Dp');
    W = sum(sum(P.Dpq.^2.*V1_mex(distm_mex(P.Xp,P.Xp)./P.Dpq)));
end