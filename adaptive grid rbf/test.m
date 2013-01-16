
Ne=20;
Nt=9;
et=linspace(0,1,Nt);
ee=logspace(-0.1,1,Ne);

Ftrue = arrayfun(@(x,y) eval_llh([x y],Ps),Ps.Xv(:,1),Ps.Xv(:,2));
ind = Ftrue>Ps.fmax*Ps.thresh;
Ftrue = Ftrue(ind);

erf=zeros(Ne,1);
erf1=zeros(Ne,1);
erl=zeros(Ne,1);
erg=zeros(Ne,1);
econdest=zeros(Ne,1);
econd=zeros(Ne,1);
ercond=zeros(Ne,1);

Ps.kernel_shape = 2;


figure(11)
clf
for k=1:Nt
    for j=1:Ne;
        if(Ps.kernel_shape == 2)
            Ps.eps = ee(j)./(Ps.rcp.^(et(k)));
        else
            Ps.eps = ee(j)/mean(Ps.rcp);
        end
        if(Ps.kernel_aniso > 1)
            Ps.RBF = rbf(distm_mex(Ps.Tp,Ps.Tp),Ps.eps);
            R_eval = rbf(distm_mex(bsxfun(@minus,Ps.Xv(ind,:),Ps.Xmean)/Ps.M,Ps.Tp),Ps.eps);
        else
            Ps.RBF = rbf(distm_mex(Ps.Xp,Ps.Xp),Ps.eps);
            R_eval = rbf(distm_mex(Ps.Xv(ind,:),Ps.Xp),Ps.eps);
        end
        Ps.c = Ps.RBF\Ps.F;
        
        Finterp = R_eval*Ps.c;
        erf(j)=max(abs(Ftrue-Finterp)/Ps.fmax);
        Ps.error_estim = 1;
        erl(j)=CostEps(ee(j).*Ps.rcp.^(1-et(k)),Ps)/Ps.fmax;
        erg(j)=max(abs(Ps.F-Ps.RBF*Ps.c))/Ps.fmax;
        erf1(j)=norm(abs(Ftrue-Finterp),1)/Ps.fmax;
        econdest(j)=condest(Ps.RBF);
        ercond(j)=1/rcond(Ps.RBF);
        econd(j)=cond(Ps.RBF,inf);
    end
    % subplot(2,3,4)
    %
    %
    % subplot(2,3,[5 6])
    figure(11)
    subplot(1,Nt,k)
    semilogy(ee,erf,'.-k')
    hold on
    semilogy(ee,erf1,'--k')
    semilogy(ee,erl,'.-r')
    ylim([1e-5,1e0])
    title(['Exponent: ' num2str(et(k))])
    legend('rel. max error on extra grid','rel. l1 error on extra grid','rel. max error with Rippa Method','Location','SouthOutside')
    drawnow
end