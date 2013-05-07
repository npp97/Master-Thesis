function [ ceps ] = CostEps( ep,P )
    %COSTEPS Summary of this function goes here
    %   Detailed explanation goes here
    
    if(P.kernel_shape == 2)
        ep = ep.*(P.rcp).^P.gamma;
    else
        ep = ep/mean(P.rcp);
    end
    
    switch(P.error_estim)
        case 1        
            A = rbf(P.R,ep);
            % find solution of Ax=b and A^-1
            invA = pinv(A);
            EF = (invA*P.F)./diag(invA);
            ceps = norm(EF(:),inf);
        case 2
            A = rbf(P.R,ep);
            c = A\P.F;
            ceps = norm(P.F - A*c);
        case 3
            A = rbf(P.R,ep);
            ceps = rcond(A) + 1/eps*(rcond(A)<P.cond_tol*eps);
            
    end
end

