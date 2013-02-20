function [ ceps ] = CostEps_hermite( ep,P )
    %COSTEPS Summary of this function goes here
    %   Detailed explanation goes here
    
    if(P.kernel_shape == 2)
        ep = ep./P.rcp;
    else
        ep = ep/mean(P.rcp);
    end
    
    switch(P.error_estim)
        case 1        
            A = rbf_hermite(P.R,ep,P.DM);
            % find solution of Ax=b and A^-1
            invA = pinv(A);
            EF = (invA*[P.F;P.DF(:)])./diag(invA);
            ceps = norm(EF(:),inf);
        case 2
            A = rbf_hermite(P.R,ep,P.DM);
            c = A\[P.F;P.DF(:)];
            ceps = norm([P.F;P.DF(:)] - A*c);
        case 3
            A = rbf_hermite(P.R,ep,P.DM);
            ceps = rcond(A) + 1/eps*(rcond(A)<P.cond_tol*eps);
            
    end
end

