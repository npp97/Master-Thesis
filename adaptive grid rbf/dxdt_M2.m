function dx = dxdt_M2(t,x,p,u, mStruct)
  
   kplus = p( mStruct.p.kplus );
   kminus = p( mStruct.p.kminus );
   k2 = p( mStruct.p.k2 );
   A = x( mStruct.s.A );
   AE = x( mStruct.s.AE );
   E = x( mStruct.s.E );
   P = x( mStruct.s.P );

   dx( mStruct.s.A ) = - kplus * A * E + kminus * AE;
   dx( mStruct.s.AE ) = + kplus * A * E - kminus * AE - k2 * AE;
   dx( mStruct.s.E ) = k2 * AE - kplus * A * E + kminus * AE;
   dx( mStruct.s.P ) = k2 * AE;
   
   dx = dx(:);
   
