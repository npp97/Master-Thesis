function [ gU ] = laplllh( ~, x)
    %GRADLLH gradient of the log-likelihood function to be approximated

    %gU = bsxfun(@times, 1,x);
    gU = -1*size(x,2);
    
end

