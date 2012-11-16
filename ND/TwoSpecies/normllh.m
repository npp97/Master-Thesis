function [ p ] = normllh( sigma, k, tdata, ydata, y0, dxdt, species )
       
[~,yy] = ode15s(@(t,x) dxdt(t,x,k),tdata,y0);

yfit = yy(:,species);

p = sum(sum(((yfit - ydata)/sigma).^2)) - numel(ydata)*log(1/(sqrt(2*pi*sigma^2)));
    
end

