function xdot = dxdotdp_M1(t,x,p)
    xdot = [
        -x(1), x(2);
        x(1), -x(2)
        ];
end