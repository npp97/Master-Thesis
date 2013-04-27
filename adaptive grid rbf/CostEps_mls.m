function [ ceps ] = CostEps_mls( param,P )
    %COSTEPS_MLS Summary of this function goes here
    %   Detailed explanation goes here
    if(P.kernel_shape == 2)
        eps = param(1)./P.rcp;
    else
        eps = param(1)/mean(P.rcp);
    end
    
    switch(P.error_estim)
        case 1   
            % LOOCV
            A = rbf(P.R,eps)-rbf(0,eps)*eye(P.N);
            ceps = norm(abs(P.F - param(2)*A*P.F),inf);
        case 2
            % 
            A = rbf(P.R,eps);
            ceps = norm(abs(P.F - param(2)*A*P.F),inf);
    end 
    
end

