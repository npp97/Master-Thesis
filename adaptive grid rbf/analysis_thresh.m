clear all

NN = 20;

vT = logspace(-10,0,NN);

for j = 1:NN
    load adap_dens_latt
    Ps = P;
    Ps.thresh = vT(j);
    Ps = regenerate_lattice(Ps);
    Ps.N
    Ps = interp(Ps);
    if(Ps.kernel_aniso > 1)
        RR = sqrt(sqdistance((bsxfun(@minus,Ps.XX,Ps.Xmean)/Ps.M)',Ps.Tp'));
    else
        RR = sqrt(sqdistance(Ps.XX',Ps.Xp'));
    end
    
    Finterp = rbf(RR,Ps.eps)*Ps.c;

    ml2err(j) = 1/Ps.NX*sum(abs(Ps.Ftrue - Finterp).^2./Ps.Ftrue);
    mlinferr(j) = max(abs(Ps.Ftrue - Finterp));
    mN(j) = Ps.N;
end

figure(100)
clf
plotyy(vT,ml2err,vT,mN,'loglog','semilogx')
axis square
xlabel('Threshold')
vline(exp(-chi2inv(P.alpha,P.pdim)/2),'r','chi-square based threshold');
legend('L_2 error','Number of Points','confidence based threshold')




    


