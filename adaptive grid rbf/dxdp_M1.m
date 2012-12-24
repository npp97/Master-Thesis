function xdot = dxdp(t,x,p,u,mStruct)
   xdim = size(dxdt(t,x,p,u,mStruct),1);
   pdim = length(p);
   DXDP = reshape(x(xdim+1:xdim+xdim*pdim),xdim,pdim);
   DFDP = dxdotdp(t,x,p);
   DFDX = dxdotdx(t,x,p);
   A = DFDX*DXDP + DFDP;
   
   xdot=[
       dxdt(t,x,p,u,mStruct);
       A(:)
       ];
end