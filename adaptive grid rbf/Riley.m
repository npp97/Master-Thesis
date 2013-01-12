function x = Riley(A,b,mu)
    kend = 10;
    C = A + mu*eye(size(A));
    L = chol(C,'lower');
    z = L\b;
    y = L\z;
    x = y;
    for k = 1:kend
        z = mu*(L\y);
        y = L\z;
        x = x + y;
    end
end
