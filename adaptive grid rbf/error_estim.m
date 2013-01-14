function [ P ] = error_estim( P )
    %ERROR Summary of this function goes here
    %   Detailed explanation goes here

    Ftrue = arrayfun(@(x,y) eval_llh([x y],P),P.Xv(:,1),P.Xv(:,2));
    
    ind = Ftrue>P.thresh*P.fmax;
    
    if(P.kernel_aniso > 1)
        Finterp = rbf(distm(bsxfun(@minus,P.Xv(ind,:),P.Xmean)/P.M,P.Tp),P.eps)*P.c;
    else
        Finterp = rbf(distm(P.Xv(ind,:),P.Xp),P.eps)*P.c;
    end
    
    P.inferror = max(abs(Ftrue(ind)-Finterp)/P.fmax);
    
%     figure(6)
%     subplot(2,3,1)
%     surf(P.VX,P.VY,reshape(Finterp,size(P.VX)))
%     view(0,90)
%     colorbar
%     
%     subplot(2,3,2)
%     surf(P.VX,P.VY,reshape(Ftrue,size(P.VX)))
%     view(0,90)
%     colorbar
%     
%     subplot(2,3,3)
%     surf(P.VX,P.VY,reshape(abs(Ftrue-Finterp)/P.fmax,size(P.VX)))
%     view(0,90)
%     colorbar
%     
%     subplot(2,3,4)
%     hold on
%     plot(P.Xv(b,1),P.Xv(b,1),'rx');
%     hold off
%     xlim([-2,2])
%     ylim([-2,2])
%     
%     max(abs(P.F-P.RBF*P.c)/P.fmax)
    

    
end

