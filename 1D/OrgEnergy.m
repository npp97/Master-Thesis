function W = OrgEnergy(Xp,rstar,D0)
    assert( isa( Xp , 'double'))
    assert( isa( rstar , 'double'))
    assert( isa( D0 , 'double'))
    Dp = calcDp_mex(Xp,Xp,rstar,D0);
    Dpq = bsxfun(@min,Dp,Dp');
    W = sum(sum(Dpq.^2.*V1(distm(Xp,Xp)./Dpq)));
end