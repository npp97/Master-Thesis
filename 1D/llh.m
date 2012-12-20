function P = llh(P)
   pdim = size(P.Xp,2);
   P.N = size(P.Xp,1);
   P.gradllh = zeros(P.N,pdim);
   P.llh = zeros(P.N,1);

   for j=1:P.N
       p=P.Xp(j,:);
       switch(P.difforder)
           case 0
               P.llh(j) = eval_llh(p,P);
           case 1
               [P.llh(j),P.gradllh(j,:)] = eval_llh(p,P);

           case 2
               [P.llh(j),P.gradllh(j,:),P.lapllh(j,:,:)] = eval_llh(p,P);

       end
   end
   if(not(P.pde))
       P.DF=P.gradllh;
       P.Fp=P.llh;
   end
   figure(5)
   quiver3(P.Xp(:,1),P.Xp(:,2),P.llh(:),P.gradllh(:,1),P.gradllh(:,2),sum(P.gradllh.^2,2),'r')
   hold on
   quiver3(P.Xp(:,1),P.Xp(:,2),P.llh(:),P.lapllh(:,1,1),P.lapllh(:,2,2),P.lapllh(:,1,2),'k');
%     figure(5)
%     quiver(P.Xp(:,1),P.Xp(:,2),P.gradllh(:,1),P.gradllh(:,2)); 
%     drawnow

end

