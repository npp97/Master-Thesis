function W = OrgEnergy(P,g)
    if(P.kernel_aniso > 1)
        P.Tp = P.Tp + g*P.wp;
        P.R = sqrt(sqdistance(P.Tp'));
    else
        P.Xp = P.Xp + g*P.wp;
        P.R = sqrt(sqdistance(P.Xp'));
    end
    Dp = calcDp( P );
    Dpq = bsxfun(@min,Dp,Dp');
    W = sum(sum(Dpq.^2.*P.pot(P.R./Dpq,P.adap_gradr)));
end