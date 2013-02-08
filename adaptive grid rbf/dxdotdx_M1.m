function xdot = dxdotdx_M1(t,x,p)
    xdot = [
        -p(1), p(2);
        p(1), -p(2)
        ];
end