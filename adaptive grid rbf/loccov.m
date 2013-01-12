function M = loccov(XX,x,F)
    T = bsxfun(@minus,XX,x).*F;
    M = T'*T / (size(XX,1) - 1);
end

