function [ V ] = V1( r )
    assert( isa(r,'double'))
    V = zeros(size(r));
    r = abs(r);
    s = 0.5>r;
    V(s) = 0.0847*(r(s));
    V(not(s)) = 0.8*2.5.^(1-5.*r(not(s)))-2.5.^(-4.*r(not(s)));
end

