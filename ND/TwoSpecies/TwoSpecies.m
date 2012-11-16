%%
% \dot{A} = -r*A/(K+A)
% \dot{B} = r*A/(K+A)
 
%% U & GRAD(U)
figure(3)
clf

k0(1)=7;
k0(2)=2;
sigma = 0.5;

A0 = 30;
B0 = 0;

y0 = [A0;B0];

dxdt = @(t,x,p) [ -p(1)*x(1)/(p(2)+x(1)); p(1)*x(1)/(p(2)+x(1))];
ddxdp = @(t,x,p) [ -x(1)/(p(2)+x(1)), p(1)*x(1)/((p(2)+x(1))^2); x(1)/(p(2)+x(1)), -p(1)*x(1)/((p(2)+x(1))^2)];
ddxdx = @(t,x,p) [ -p(1)*p(2)/((p(2)+x(1))^2), 0; p(1)*p(2)/((p(2)+x(1))^2), 0];

tdata = linspace(0,10,11);

[tt,yy] = ode23s(@(t,x) dxdt(t,x,k0),tdata,y0);

ydata = yy(:,2) + sigma*randn(length(tdata),1);

plot(tdata,ydata,'.-r')
hold on

gradnormllh(sigma,k0,tdata,ydata,y0,dxdt,ddxdx,ddxdp,2)

%% PDE OPERATOR

%Notes590_Ch43 P9
eps = 3; % check LOOCV-optimization of the RBF shape parameters!
kernel = @(r) exp(-(eps*r).^2);
dkernel = @(r) exp(-(eps*r).^2)*(-2*(eps)^2)*(dx);
%d2kernel = @(r,dx)













xx=0.5:0.5:10;
[X,Y] = meshgrid(xx, xx);


Z=zeros(size(xx,2),size(xx,2),2);
ZZ=zeros(size(xx,2),size(xx,2));
for i=1:(size(xx,2)) 
    for j=1:(size(xx,2))
        Z(i,j,:) = gradnormllh(sigma,[xx(i),xx(j)],tdata,ydata,y0,dxdt,ddxdx,ddxdp,2);
        ZZ(i,j) = normllh(sigma, [xx(i),xx(j)], tdata, ydata, y0, dxdt, 2);
    end
end

figure(1)
quiver(X,Y,Z(:,:,2),Z(:,:,1))
figure(2)
surf(X,Y,ZZ)
%[kk] = fminsearch(@(k) normllh(sigma, k, tdata, ydata, y0, dxdt, 2),[10 10]);
%[tt,yy] = ode23s(@(t,x) dxdt(x,kk),tdata,y0);
%ydata = yy(:,2);
%plot(tdata,ydata,'.-g')




