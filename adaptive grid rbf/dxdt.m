function dx = dxdt(t,x,p,u, mStruct)
  
   p1 = p( mStruct.p.k1 );
   p2 = p( mStruct.p.k2 );
   x1 = x( mStruct.s.x1 );
   x2 = x( mStruct.s.x2 );

   dx( mStruct.s.x1 ) = - p1 * x1 + p2 * x2;
   dx( mStruct.s.x2 ) = - p2 * x2 + p1 * x1;
   
   dx = dx(:);
   
