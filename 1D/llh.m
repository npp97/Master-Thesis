function P = llh(P)
   pdim = size(P.Xp,2);
   P.N = size(P.Xp,1);
   P.gradllh = zeros(P.N,pdim);
   P.llh = zeros(P.N,1);

   for j=1:P.N
       p=P.Xp(j,:);
       [P.llh(j),P.gradllh(j)] = eval_llh(p,P);
   end
   if(not(P.pde))
       P.DF=P.gradllh;
       P.Fp=P.llh;
   end
    figure(5)
    quiver(P.Xp(:,1),P.Xp(:,2),P.gradllh(:,1),P.gradllh(:,2)); 
    drawnow
end

