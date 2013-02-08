function xdot = dxdp_M2(t,x,p,u,mStruct)
   xdim = size(dxdt_M2(t,x,p,u,mStruct),1);
   pdim = length(p);
   DXDP = reshape(x(xdim+1:xdim+xdim*pdim),xdim,pdim);
   DFDP = dxdotdp_M2(t,x(1:xdim),p);
   DFDX = dxdotdx_M2(t,x(1:xdim),p);
   A = DFDX*DXDP + DFDP;
   
   xdot=[
       dxdt_M2(t,x,p,u,mStruct);
       A(:)
       ];
end