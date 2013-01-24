function lecture()

k=[0.3,0.7];

[tt,xx]=ode15s(@(t,x) dxdt(t,x,k),1:10,[1 0 0 0 0 0])
[tt,xxe1]=ode15s(@(t,x) dxdt(t,x,k+[1e-2 0]),1:10,[1 0 0 0 0 0])
[tt,xxe2]=ode15s(@(t,x) dxdt(t,x,k+[0 1e-2]),1:10,[1 0 0 0 0 0])
ss1=(xxe1(:,[1 2])-xx(:,[1 2]))/1e-2
ss2=(xxe2(:,[1 2])-xx(:,[1 2]))/1e-2

end




function xdot = dxdt(t,x,k)
    xdot(1) = -k(1)*x(1) + k(2)*x(2);
    xdot(2) = -xdot(1);
    xdot(3) = -x(1)-k(1)*x(3)+k(2)*x(5);
    xdot(4) = x(2)-k(1)*x(4)+k(2)*x(6);
    xdot(5) = x(1)+k(1)*x(3)-k(2)*x(5);
    xdot(6) = -x(2)+k(1)*x(4)-k(2)*x(6);
    xdot = xdot(:);
end