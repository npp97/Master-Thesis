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
    
    tri = delaunay(P.XX(:,1),P.XX(:,2));
    figure(11)
    clf
    trisurf(tri,P.XX(:,1),P.XX(:,2),abs(Finterp-Ftrue)/P.fmax);
    hold on
    scatter3(P.Xp(:,1),P.Xp(:,2),ones(P.N,1)*P.inferror)
    set(gca,'ZScale','log')
    
    figure(13)
    
    A = rbf(P.R,P.eps);
    invA = pinv(A);
    EF = (invA*P.F)./diag(invA);
end

