function W = OrgEnergy(Xp,X_old,rcp_old,f,D0)
    assert( isa( Xp , 'double'))
    assert( isa( f , 'double'))
    assert( isa( D0 , 'double'))
    Dp = IntOp(Xp,X_old,rcp_old)*f;
    Dpq = bsxfun(@min,Dp,Dp');
    W = sum(sum(Dpq.^2.*V1(distm(Xp,Xp)./Dpq)));
end