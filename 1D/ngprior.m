function [df] = ngprior(x)
    %PRIOR Summary of this function goes here
    %   Detailed explanation goes here
    df = 6*(sum((x-1).^2,2)).*prior(x);
end