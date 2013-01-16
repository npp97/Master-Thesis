function dx = dxdt_M1(t,x,p,u, mStruct)
  
   k1 = p( mStruct.p.k1 );
   k2 = p( mStruct.p.k2 );
   x1 = x( mStruct.s.x1 );
   x2 = x( mStruct.s.x2 );

   dx( mStruct.s.x1 ) = - k1 * x1 + k2 * x2;
   dx( mStruct.s.x2 ) = - k2 * x2 + k1 * x1;
   
   dx = dx(:);
   
