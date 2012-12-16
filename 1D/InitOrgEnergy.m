function W = InitOrgEnergy(P,g)
    P.Xp = P.Xp + g*P.wp;
    if(P.pde)
        P.DF = ngprior(P.Xp);
    else
        P = llh(P);
    end
    P = exactDp(P);
    P.Dpq = bsxfun(@min,P.Dp,P.Dp');
    W = sum(sum(P.Dpq.^2.*V1_mex(distm_mex(P.Xp,P.Xp)./P.Dpq)));
end