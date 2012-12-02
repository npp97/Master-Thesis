function [L,D1,D2,I,E,T] = Lop(X_eval,X_source,eps,U,V)

    
    M_int = distm(X_source,X_source);
    M_eval = distm(X_eval,X_source);
    M_target = distm(X_eval,X_eval);
    %eps=eps/min(min(M_int(M_int>0)));
    eps=3;
    % M has dimension [ size(X_eval,1) x size(X_source,1) ]
    
    I = rbf(M_int,eps);
    E = rbf(M_eval,eps);
    T = rbf(M_target,eps);
    
    % I has same dimension as M
    
    D1 = zeros(size(E));
    
    grad = gradllh(0,X_eval);
    
    % grad has dimension [ size(Xp,2) x size(X_source,1)]
    
    for d = 1:size(X_eval,2)
        
        % sum_j=1^d(\frac{\delta U}{\delta x_j}*\frac{\delta y}{\delta x_j})
        
        D1 = D1 + bsxfun(@times,grad(:,d),drbf(M_eval,eps,diffm(X_eval(:,d),X_source(:,d))));
        
    end
    
    
    D2 = d2rbf(M_eval,eps);
    
    % assemble operator
    
    L = (-U*D1 -laplllh(0,X_eval)*E+V*D2)/I;
    
    D1 = D1/I;
    D2 = D2/I;

end