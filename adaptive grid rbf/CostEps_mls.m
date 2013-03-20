function [ ceps ] = CostEps_mls( ep,P )
    %COSTEPS_MLS Summary of this function goes here
    %   Detailed explanation goes here
    if(P.kernel_shape == 2)
        ep = ep./P.rcp;
    else
        ep = ep/mean(P.rcp);
    end
    
    switch(P.error_estim)
        case 1   
            % LOOCV
            A = rbf(P.R,ep)-rbf(0,ep)*eye(P.N);
            ceps = norm(abs(P.F - A*P.F),inf);
        case 2
            % 
            A = rbf(P.R,ep);
            ceps = norm(abs(P.F - A*P.F),inf);
    end 
    
end

