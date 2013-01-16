function dx = dxdt_M2(t,x,p,u, mStruct)
  
   kplus = p( mStruct.p.kplus );
   kminus = p( mStruct.p.kminus );
   k2 = p( mStruct.p.k2 );
   x1 = x( mStruct.s.x1 );
   AE = x( mStruct.s.AE );
   E = x( mStruct.s.E );
   P = x( mStruct.s.P );

   dx( mStruct.s.x1 ) = - kplus * x1 * E + kminus * AE;
   dx( mStruct.s.AE ) = + kplus * x1 * E - kminus * AE - k2 * AE;
   dx( mStruct.s.E ) = k2 * AE - kplus * x1 * E + kminus * AE;
   dx( mStruct.s.P ) = k2 * AE;
   
   dx = dx(:);
   
