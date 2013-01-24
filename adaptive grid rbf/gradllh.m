function P = gradllh(P)
    % initialize
    P.N = size(P.Xp,1);
    P.DF = zeros(P.N,P.pdim);
    P.F = zeros(P.N,1);
    
    % compute pointwise for every particle
    for j=1:P.N
        p=P.Xp(j,:);
        [P.F(j),P.DF(j,:),P.S(j,:)] = eval_gradllh(p,P);
    end
    
end
