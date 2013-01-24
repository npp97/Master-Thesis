function [ P ] = error_estim( P )
    %ERROR Summary of this function goes here
    %   Detailed explanation goes here
    
    Ftrue = arrayfun(@(j) eval_llh(P.XX(j,:),P) , 1:P.NX)';
    
    if(P.kernel_aniso > 1)
        Finterp = rbf(distm(bsxfun(@minus,P.XX,P.Xmean)/P.M,P.Tp),P.eps)*P.c;
    else
        Finterp = rbf(distm(P.XX,P.Xp),P.eps)*P.c;
    end
    
    P.inferror = max(abs(Ftrue-Finterp)/P.fmax);
    P.l1error = 1/P.NX*sum(abs(1-Ftrue./Finterp));

    
end

