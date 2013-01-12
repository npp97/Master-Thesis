function [ ceps ] = CostEps( ep,P )
    %COSTEPS Summary of this function goes here
    %   Detailed explanation goes here
    
    if(P.kernel_shape == 2)
        ep = P.rcp*ep;
    end
    
    A = rbf(P.R,ep);
    % find solution of Ax=b and A^-1
    invA = pinv(A);
    EF = (invA*P.F)./diag(invA);
    ceps = norm(EF(:),inf);
end

