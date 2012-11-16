function [ U ] = llh( t, x)
    %LLH  the log-likelihood function to be approximated

    U = 1/2*(sum(x.^2,2));
    
end