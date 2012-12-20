function xdot = dxdt(t,x,p)
   xdot = [
       -p(1)*x(1) + p(2)*x(2);
       -p(2)*x(2) + p(1)*x(1)
       ];
end