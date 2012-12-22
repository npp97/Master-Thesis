function [ P ] = TptoXp( P )
    %TPTOXP Summary of this function goes here
    %   Detailed explanation goes here
    P.Xp = bsxfun(@plus,P.Tp*P.M,P.Xmean);
    
end

