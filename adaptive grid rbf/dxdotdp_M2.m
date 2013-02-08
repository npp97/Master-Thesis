function xdot = dxdotdp_M2(t,x,p)
    xdot = [
        -x(1)*x(3),  x(2),     0;
        x(1)*x(3) , -x(2), -x(2);
        -x(1)*x(3),  x(2),  x(2);
        0         ,     0,  x(2);
        ];
end