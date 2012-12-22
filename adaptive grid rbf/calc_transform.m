function [ P ] = calc_transform( P )
    %CALC_TRANSFORM Summary of this function goes here
    %   Detailed explanation goes here
    
    X = P.Xp(P.F>P.fmax*P.thresh,:);
    P.Xmean = mean(X);
    Xm = bsxfun(@minus,X,P.Xmean);
    P.M = chol(cov(Xm));
end

