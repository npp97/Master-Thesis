function xdot = dxdotdx_M2(t,x,p)
    xdot = [
        -p(1)*x(3),       p(2), -p(1)*x(1), 0;
        +p(1)*x(3), -p(2)-p(3), +p(1)*x(1), 0;
        -p(1)*x(3), +p(2)+p(3), -p(1)*x(1), 0;
                 0,       p(3),          0, 0;
        ];
end