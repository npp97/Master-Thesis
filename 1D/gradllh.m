function [ gU ] = gradllh( ~, x)
    %GRADLLH gradient of the log-likelihood function to be approximated

    %gU = bsxfun(@times, 1,x);
    gU = x;
    
end

