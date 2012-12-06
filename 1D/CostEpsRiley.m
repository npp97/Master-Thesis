 function ceps = CostEpsRiley(ep,r,rhs)
 A = rbf(ep,r);
 mu = 1e-11;
 % find solution of Ax=b and A^-1
 D = Riley_mex(A,[rhs eye(size(A))],mu);
 errorvector = D(:,1)./diag(D(:,2:end));
 ceps = norm(errorvector);
 end