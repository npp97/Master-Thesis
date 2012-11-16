function [ grad ] = gradnormllh( sigma, k, tdata, ydata, y0, dxdt, ddxdx, ddxdp, species )
       
xdim = length(y0);
kdim = length(k);

[~,yy] = ode15s(@(t,x) dxdp(t,x,k,dxdt,ddxdx,ddxdp),tdata,[y0;zeros(length(k)*length(y0),1)]);

grad = zeros(kdim,1);



for i=1:length(tdata)
    dydp = reshape(yy(i,xdim+1:end),xdim,kdim);
    
    jspec = 1;
    for j=species
        grad = grad + (2*(yy(i,j) - ydata(i,jspec))/sigma) * dydp(j,:)';
        jspec = jspec + 1;
    end
end

    
end



function [dxdp] = dxdp(t,x,p,dxdt,ddxdx,ddxdp)

xdim = length(dxdt(t,x,p));
kdim = length(p);

M = reshape(x(xdim+1:end),xdim,kdim);

H = ddxdp(t,x,p);
    
S = ddxdx(t,x,p);

R = S*M + H;

dxdp = [
    dxdt(t,x,p);
    reshape(R,numel(R),1);
    ];

end