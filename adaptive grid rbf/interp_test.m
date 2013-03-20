function [ P ] = interp_test( P )
    %INTERP_TEST Summary of this function goes here
    %   Detailed explanation goes here
      
    disp(['------- RBF Interpolation -------'])
    
    % compute distances
    if(P.kernel_aniso > 1)
        P.R = sqrt(sqdistance(P.Tp'));
    else
        P.R = sqrt(sqdistance(P.Xp'));
    end
    
    % get function values
    disp(['# Evaluating Function '])
    P = llh(P);
    
        % get difference matrix
    P = diff_mat(P);

    % choose inversion method
    switch(P.kernel_inverse)
        case 1
            % estimate optimal eps
            disp(['# Optimizing Shape Parameter '])
            gamma = 1;
            P.eps = fminbnd(@(ep) CostEps_test(ep,gamma,P),1e-3/mean(P.rcp),1e1/mean(P.rcp));
             
            % normalize eps
            if(P.kernel_shape == 2)
                P.eps = P.eps./P.rcp;
            else
                P.eps = P.eps/mean(P.rcp);
            end
            
            % compute interpolation matrix 
            P.RBF = rbf(P.R,P.eps);
            
            A = zeros((P.pdim+1)*P.N,P.N);
            A(1:P.N,1:P.N) = rbf(P.R,P.eps);
            for j = 1 : P.pdim
                A(j*P.N+1:(j+1)*P.N,1:P.N) = gamma*drbf(P.R,P.eps,squeeze(P.DM(j,:,:)));
            end
            F = [P.F;gamma*P.DF(:)];
            
            P.c = lsqnonneg(A,F);
            
    end
    
            
    
end

