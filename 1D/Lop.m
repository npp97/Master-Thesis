function [P] = Lop(P)

    P.M_int = distm(P.Xp,P.Xp);
    P.M_eval = distm(P.Xp_adv,P.Xp);
    P.M_target = distm(P.Xp_adv,P.Xp_adv);
    %eps=eps/min(min(M_int(M_int>0)));
    % M has dimension [ size(X_eval,1) x size(X_source,1) ]
    
    P.I = rbf(P.M_int,P.eps);
    P.E = rbf(P.M_eval,P.eps);
    P.T = rbf(P.M_target,P.eps);
    
    % I has same dimension as M
    P = llh(P);
    P.ftarget = exp(P.llh);
    P.It = sum(irbf(P.M_int\P.ftarget,P.eps,P.dim));

    
    

    
    
    
    D1 = zeros(size(P.E));
    
    grad = P.gradllh;
    
    % grad has dimension [ size(Xp,2) x size(X_source,1)]
    
    for d = 1:P.dim
        
        % sum_j=1^d(\frac{\delta U}{\delta x_j}*\frac{\delta y}{\delta x_j})
        
        D1 = D1 + bsxfun(@times,grad(:,d),drbf(P.M_eval,P.eps,diffm(P.Xp_adv(:,d),P.Xp(:,d))));
        
    end
    
    
    D2 = d2rbf(P.M_eval,P.eps);
    
    % assemble operator
    
    P.OP = (-P.U*D1 -bsxfun(@times,P.lapllh,P.E)+P.V*D2)/P.I;
    
    P.D1 = D1/P.I;
    P.D2 = D2/P.I;

end