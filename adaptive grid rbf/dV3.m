function [ V ] = dV3( r, rstar )
    V = zeros(size(r));
    r = abs(r);
    t = rstar>r;
    V(t) = (-5)*log(2.5)*0.8*2.5.^(1-5.*r(t))-(-4)*log(2.5)*2.5.^(-4.*r(t));
end

