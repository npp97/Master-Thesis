function [ V ] = dV1( r,rstar )
    V = zeros(size(r));
    r = abs(r);
    s = 0.5>r;
    t = rstar>r;
    V(s) = 0.0847;
    V(and(not(s),t)) = (-5)*log(2.5)*0.8*2.5.^(1-5.*r(and(not(s),t)))-(-4)*log(2.5)*2.5.^(-4.*r(and(not(s),t)));
end

