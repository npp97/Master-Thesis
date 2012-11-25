function W = InitOrgEnergy(Xp,DF,rstar,D0)
    assert( isa( Xp , 'double'))
    assert( isa( DF , 'double'))
    assert( isa( rstar , 'double'))
    assert( isa( D0 , 'double'))
    Dp = exactDp(Xp,DF,rstar,D0);
    Dpq = bsxfun(@min,Dp,Dp');
    W = sum(sum(Dpq.^2.*V1_mex(distm_mex(Xp,Xp)./Dpq)));
end