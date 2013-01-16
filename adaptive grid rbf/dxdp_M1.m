function xdot = dxdp_M1(t,x,p,u,mStruct)
   xdim = size(dxdt_M1(t,x,p,u,mStruct),1);
   pdim = length(p);
   DXDP = reshape(x(xdim+1:xdim+xdim*pdim),xdim,pdim);
   DFDP = dxdotdp_M1(t,x,p);
   DFDX = dxdotdx_M1(t,x,p);
   A = DFDX*DXDP + DFDP;
   
   xdot=[
       dxdt_M1(t,x,p,u,mStruct);
       A(:)
       ];
end