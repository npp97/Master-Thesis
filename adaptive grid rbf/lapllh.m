function P = lapllh(P)
    
   P.F = zeros(P.N,1);
   P.DF = zeros(P.N,P.pdim);
   P.D2F = zeros(P.N,P.pdim,P.pdim);

   for j=1:P.N
       p=P.Xp(j,:);
       [P.F(j),P.DF(j,:),P.D2F(j,:,:)] = eval_lapllh(p,P);
   end
end
