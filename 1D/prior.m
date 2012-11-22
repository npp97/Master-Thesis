function [ f ] = prior( x )
    %PRIOR Summary of this function goes here
    %   Detailed explanation goes here
    
    f = 3/sqrt(pi)*exp(-3*sum((x-1).^2,2));
end

