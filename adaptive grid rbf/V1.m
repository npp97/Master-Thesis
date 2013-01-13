function [ V ] = V1( r,rstar )
    assert( isa(r,'double'))
    V = zeros(size(r));
    r = abs(r);
    s = 0.5>r;
    t = rstar>r;
    V(s) = 0.0847*(r(s));
    V(and(not(s),t)) = 0.8*2.5.^(1-5.*r(and(not(s),t)))-2.5.^(-4.*r(and(not(s),t)));
end

