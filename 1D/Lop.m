function [L,D1,D2,I,E] = Lop(X_eval,X_source,eps,U,V)
    
    M_int = distm(X_source,X_source);
    M_eval = distm(X_eval,X_source);
    
    
    % M has dimension [ size(X_eval,1) x size(X_source,1) ]
    
    I = rbf(M_int,eps);
    E = rbf(M_eval,eps);
    
    % I has same dimension as M
    
    D1 = zeros(size(E));
    
    grad = gradllh(0,X_source)';
    
    % grad has dimension [ size(Xp,2) x size(X_source,1)]
    
    for d = 1:size(X_eval,2)
        
        % sum_j=1^d(\frac{\delta U}{\delta x_j}*\frac{\delta y}{\delta x_j})
        
        D1 = D1 + repmat(grad(d,:),size(X_eval,1),1).*drbf(M_eval,eps,diffm(X_eval(:,d),X_source(:,d)));
        
    end
    
    
    D2 = d2rbf(M_eval,eps);
    
    % assemble operator
    
    L = (-U*D1+V*D2)/I;
    
    D1 = D1/I;
    D2 = D2/I;
    %L = (V*D2)/I;

end