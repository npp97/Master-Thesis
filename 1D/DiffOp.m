function [DOP] = DiffOp(X_eval,X_source,eps)
    
    M_int = distm(X_source,X_source);
    M_eval = distm(X_eval,X_source);
    
    % M has dimension [ size(X_eval,1) x size(X_source,1) ]
    
    I = rbf(M_int,eps);
    E = rbf(M_eval,eps);
    
    % I has same dimension as M
    
    D1 = zeros(size(E));
    
    for d = 1:size(X_eval,2)
        
        % sum_j=1^d(\frac{\delta U}{\delta x_j}*\frac{\delta y}{\delta x_j})
        
        D1 = D1 + drbf(M_eval,eps,diffm(X_eval(:,d),X_source(:,d))).^2;
        
    end
    
    D1 = sqrt(D1);
    
    % assemble operator
    
    DOP = D1/I;

end