clear all


NN = 20;
vG = linspace(-1,1,NN);


load adap_dens_latt
P.Riter = 0;

P.adap_D0 = 1;
P.adap_d0 = P.adap_D0/1.1;

P.init_D0 = 1;
P.init_d0 = P.adap_D0/1.1;

P.d0 = P.init_d0;
P.D0 = P.init_D0;
P.plotflag=false;
P = refine_particles(P);

for j = 1:NN
    Ps = P;
    Ps.kernel_shape = 2;
    Ps.gamma = vG(j);
    
    Ps = interp(Ps);
    if(Ps.kernel_aniso > 1)
        RR = sqrt(sqdistance((bsxfun(@minus,Ps.XX,Ps.Xmean)/Ps.M)',Ps.Tp'));
    else
        RR = sqrt(sqdistance(Ps.XX',Ps.Xp'));
    end
    
    Finterp = rbf(RR,Ps.eps)*Ps.c;

    ml2err(j) = 1/Ps.NX*sum(abs(Ps.Ftrue - Finterp).^2./Ps.Ftrue);
    mlinferr(j) = max(abs(Ps.Ftrue - Finterp));
end

figure(110);
clf
semilogy(vG,ml2err,'.-k','LineWidth',5,'MarkerSize',25)
xlabel('\gamma')
ylabel('L_2 error')
set(gcf, 'Color', 'w')
axis square

figure(111);

clf
semilogy(vG,mlinferr,'.-k','LineWidth',5,'MarkerSize',25)
xlabel('\gamma')
ylabel('max error')
set(gcf, 'Color', 'w')
axis square