function P = llh(P)
   P.F = zeros(P.N,1);

   for j=1:P.N
       p=P.Xp(j,:);
       P.F(j) = eval_llh(p,P);
   end
end
