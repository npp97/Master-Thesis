function xdot = dxdotdpdx(t,x,p)
    %(df,dx,dp)
    xdot(1,:,:) = [
        -1, 0;
        0, 1
        ];
    xdot(2,:,:) = [
        1, 0;
        0, -1
        ];
end
