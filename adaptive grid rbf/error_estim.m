function [ P ] = error_estim( P )
    %ERROR Summary of this function goes here
    %   Detailed explanation goes here
    
    if(P.kernel_aniso > 2)
        Finterp = rbf(distm(bsxfun(@minus,P.Xv,P.Xmean)/P.M,P.Tp),P.eps)*P.c;
    else
        Finterp = rbf(distm(P.Xv,P.Xp),P.eps)*P.c;
    end
    Ftrue = arrayfun(@(x,y) eval_llh([x y],P),P.Xv(:,1),P.Xv(:,2));
    P.inferror = max(Ftrue-Finterp)/P.fmax;
    
%     figure(6)
%     subplot(1,3,1)
%     surf(P.VX,P.VY,reshape(log(abs(Finterp)),size(P.VX)))
%     view(0,90)
%     colorbar
%     
%     subplot(1,3,2)
%     surf(P.VX,P.VY,reshape(log(Ftrue),size(P.VX)))
%     view(0,90)
%     colorbar
%     
%     subplot(1,3,3)
%     surf(P.VX,P.VY,reshape(log(abs(Ftrue-abs(Finterp))),size(P.VX)))
%     view(0,90)
%     colorbar
%     

    
end

