function [ P ] = calc_transform( P )
    %CALC_TRANSFORM Summary of this function goes here
    %   Detailed explanation goes here
    
    X = P.Xp(P.F>P.fmax*P.thresh,:);
    P.Xmean = mean(X);
    Xm = bsxfun(@minus,X,P.Xmean);
    try
        P.M = chol(cov(Xm));
    catch
        P.M = chol(cov(Xm)+diag(P.pdim)*1e-10);
    end
    P.D0 = P.adap_D0;
    P.d0 = P.adap_d0;
end

