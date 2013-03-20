function [ ceps ] = CostEps_test( ep , gamma, P )
    %COSTEPS_TEST Summary of this function goes here
    %   Detailed explanation goes here
    
    if(P.kernel_shape == 2)
        ep = ep./P.rcp;
    else
        ep = ep/mean(P.rcp);
    end
    
    gamma = 1;
    
    
    
    A = zeros((P.pdim+1)*P.N,P.N);
    A(1:P.N,1:P.N) = rbf(P.R,ep);
    for j = 1 : P.pdim
        A(j*P.N+1:(j+1)*P.N,1:P.N) = gamma*drbf(P.R,ep,squeeze(P.DM(j,:,:)));
    end
    F = [P.F;gamma*P.DF(:)];
    
    c = lsqnonneg(A,F);
    
    ceps = norm(F - A*c,2);                                                 
end

