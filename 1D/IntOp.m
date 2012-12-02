function [IOP] = IntOp(X_eval,X_source,eps)

    
    M_int = distm(X_source,X_source);
    M_eval = distm(X_eval,X_source);
    %eps=eps/min(min(M_int(M_int>0)));
    eps=3;    
    % M has dimension [ size(X_eval,1) x size(X_source,1) ]
    
    I = rbf(M_int,eps);
    E = rbf(M_eval,eps);
    
    % assemble operator
    
    IOP = E/I;

end