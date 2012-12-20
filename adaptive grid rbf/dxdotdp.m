function xdot = dxdotdp(t,x,p)
    xdot = [
        -x(1), x(2);
        x(1), -x(2)
        ];
end