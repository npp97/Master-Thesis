function xdot = dxdpdp(t,x,p,u,mStruct)
   xdim = size(dxdt(t,x,p,u,mStruct),1);
   pdim = length(p);    
   DFDX = dxdotdx(t,x,p);
   DXDP = reshape(x(xdim+1:xdim+xdim*pdim),xdim,pdim);
   DFDPDP = dxdotdpdp(t,x,p);
   DFDPDX = dxdotdpdx(t,x,p);
   DFDXDP = dxdotdxdp(t,x,p);
   DFDXDX = dxdotdxdx(t,x,p);
   DXDPDP = reshape(x(xdim+xdim*pdim+1:end),xdim,pdim,pdim);

   %B1 = DFDPDX*DXDP;
   B1=zeros(xdim,pdim,pdim);
   for j = 1:xdim
       B1(j,:,:) = squeeze(DFDPDX(j,:,:))*DXDP;
   end
   
   %B2 = DFDXDP*DXDP;
   B2=zeros(xdim,pdim,pdim);
   for j = 1:xdim
       B2(j,:,:) = squeeze(DFDXDP(j,:,:))*DXDP;
   end
   
   %B3 = DFDXDX*DXDP*DXDP;
   B3=zeros(xdim,pdim,pdim);
   for j = 1:xdim
       for k=1:pdim
           for l=1:pdim
               B3(j,k,l) = (DXDP(:,k)')*squeeze(DFDXDX(j,:,:))*(DXDP(:,l));
           end
       end
   end
   
   %B4 = DFDX*DXDPDP;
   B4=zeros(xdim,pdim,xdim);
   for j = 1:xdim
       for k = 1:xdim
           B4(j,:,:) = B4(j,:,:) + DFDX(j,k)*DXDPDP(k,:,:);
       end
   end
   
   B = DFDPDP + B1 + B2 + B3 + B4;
    
    xdot = [
        dxdp(t,x(1:xdim+xdim*pdim),p,u,mStruct);
        B(:)
        ];
    
end