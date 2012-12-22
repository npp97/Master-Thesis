function [ P ] = XptoTp( P )
    %GLOBAL_COV Summary of this function goes here
    %   Detailed explanation goes here 
    P.Tp = bsxfun(@minus,P.Xp,P.Xmean)/P.M; 
end

