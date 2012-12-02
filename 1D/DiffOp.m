function [DOP] = DiffOp(X_eval,X_source,eps,d)
    
    M_int = distm(X_source,X_source);
    M_eval = distm(X_eval,X_source);
    %eps=eps/min(min(M_int(M_int>0)));
    eps=3;    
    % M has dimension [ size(X_eval,1) x size(X_source,1) ]
    
    I = rbf(M_int,eps);
    
    % I has same dimension as M
    
    D1 = drbf(M_eval,eps,diffm(X_eval(:,d),X_source(:,d)));
    
    % assemble operator
    
    DOP = D1/I;

end