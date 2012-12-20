 function ceps = CostEpsRiley(ep,P)
 A = rbf(ep,P.R);
 % find solution of Ax=b and A^-1
 D = Riley_mex(A,[P.llh eye(size(A))],P.riley_mu);
 errorvector = D(:,1)./diag(D(:,2:end));
 ceps = norm(errorvector);
 end