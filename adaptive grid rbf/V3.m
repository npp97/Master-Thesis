function [ V ] = V3( r, rstar )
    assert( isa(r,'double'))
    V = zeros(size(r));
    r = abs(r);
    t = rstar>r;
    V(t) = 0.8*2.5.^(1-5.*r(t))-2.5.^(-4.*r(t));
end

