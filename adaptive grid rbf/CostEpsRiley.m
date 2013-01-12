 function ceps = CostEpsRiley(ep,P)
         
     if(P.kernel_shape == 2)
         ep = P.rcp*ep;
     end
     
     A = rbf(ep,P.R);
     % find solution of Ax=b and A^-1
     D = Riley_mex(A,[P.F eye(size(A))],P.riley_mu);
     errorvector = D(:,1)./diag(D(:,2:end));
     ceps = norm(errorvector);
 end