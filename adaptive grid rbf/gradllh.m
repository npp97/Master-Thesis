function P = gradllh(P)
   P.N = size(P.Xp,1);
   P.DF = zeros(P.N,P.pdim);
   P.F = zeros(P.N,1);

   for j=1:P.N
       p=P.Xp(j,:);
       [P.F(j),P.DF(j,:)] = eval_gradllh(p,P);
   end
%    figure(5)
%    quiver3(P.Xp(:,1),P.Xp(:,2),P.llh(:),P.gradllh(:,1),P.gradllh(:,2),sum(P.gradllh.^2,2),'r')

end
