function P = approxDp(P)
    Dp = calcDp( P );
    if(size(Dp,2)>size(Dp,1))
        Dp = Dp';
    end
    P.Dp=Dp;
    P.rcp=P.adap_rstar*P.Dp;
end