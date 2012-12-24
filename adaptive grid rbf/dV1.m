function [ V ] = dV1( r )
    V = zeros(size(r));
    r = abs(r);
    s = 0.5>r;
    V(s) = 0.0847;
    V(not(s)) = (-5)*log(2.5)*0.8*2.5.^(1-5.*r(not(s)))-(-4)*log(2.5)*2.5.^(-4.*r(not(s)));
    %V = (-5)*log(2.5)*0.8*2.5.^(1-5.*r)-(-4)*log(2.5)*2.5.^(-4.*r);
end

