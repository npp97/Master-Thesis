clear all
NN = 40;

vD = logspace(-0.7,0,NN);

for j = 1:NN
    load adap_dens_latt
    Ps = P;
    Ps.kernel_aniso = 1;
    Ps.init_latt_d = 0.75*vD(j);
    Ps = regenerate_lattice(Ps);
    Ps.N
    Ps = interp(Ps);
    if(Ps.kernel_aniso > 1)
        RR = sqrt(sqdistance((bsxfun(@minus,Ps.XX,Ps.Xmean)/Ps.M)',Ps.Tp'));
    else
        RR = sqrt(sqdistance(Ps.XX',Ps.Xp'));
    end
    
    Finterp = rbf(RR,Ps.eps)*Ps.c;

    ml2err_iso(j) = 1/Ps.NX*sum(abs(Ps.Ftrue - Finterp).^2./Ps.Ftrue);
    mlinferr_iso(j) = max(abs(Ps.Ftrue - Finterp));
    mN_iso(j) = Ps.N;
end

for j = 1:NN
    load adap_dens_latt
    Ps = P;
    Ps.kernel_aniso = 2;
    Ps.init_latt_d = 2*vD(j);
    Ps = regenerate_lattice(Ps);
    Ps.N
    Ps = interp(Ps);
    if(Ps.kernel_aniso > 1)
        RR = sqrt(sqdistance((bsxfun(@minus,Ps.XX,Ps.Xmean)/Ps.M)',Ps.Tp'));
    else
        RR = sqrt(sqdistance(Ps.XX',Ps.Xp'));
    end
    
    Finterp = rbf(RR,Ps.eps)*Ps.c;

    ml2err_aniso(j) = 1/Ps.NX*sum(abs(Ps.Ftrue - Finterp).^2./Ps.Ftrue);
    mlinferr_aniso(j) = max(abs(Ps.Ftrue - Finterp));
    mN_aniso(j) = Ps.N;
end

for j = 1:NN
    load adap_dens_latt
    Ps = P;
    Ps.kernel_aniso = 2;
    Ps.init_lattice = 4;
    Ps.init_latt_d = 2*vD(j);
    Ps = regenerate_lattice(Ps);
    Ps.N
    Ps = interp(Ps);
    if(Ps.kernel_aniso > 1)
        RR = sqrt(sqdistance((bsxfun(@minus,Ps.XX,Ps.Xmean)/Ps.M)',Ps.Tp'));
    else
        RR = sqrt(sqdistance(Ps.XX',Ps.Xp'));
    end
    
    Finterp = rbf(RR,Ps.eps)*Ps.c;

    ml2err_aniso_Z(j) = 1/Ps.NX*sum(abs(Ps.Ftrue - Finterp).^2./Ps.Ftrue);
    mlinferr_aniso_Z(j) = max(abs(Ps.Ftrue - Finterp));
    mN_aniso_Z(j) = Ps.N;
end

figure(90)
clf
semilogy(mN_iso,ml2err_iso,'.-k','LineWidth',5,'MarkerSize',25)
hold on
semilogy(mN_aniso,ml2err_aniso,'.-r','LineWidth',5,'MarkerSize',25)
legend('untransformed','transformed using covariance')
xlabel('Number of Points')
ylabel('L_2 error')
set(gcf, 'Color', 'w')
axis square

figure(91)
clf
semilogy(mN_iso,ml2err_iso,'.-k','LineWidth',5,'MarkerSize',25)
hold on
semilogy(mN_aniso,ml2err_aniso,'.-r','LineWidth',5,'MarkerSize',25)
legend('untransformed','transformed using covariance')
xlabel('Number of Points')
ylabel('L_2 error')
set(gcf, 'Color', 'w')
axis square

figure(92)
clf
semilogy(mN_aniso_Z,ml2err_iso,'.-k','LineWidth',5,'MarkerSize',25)
hold on
semilogy(mN_aniso,ml2err_aniso,'.-r','LineWidth',5,'MarkerSize',25)
legend('Z^2 lattice','A^*_2 lattice')
xlabel('Number of Points')
ylabel('L_2 error')
set(gcf, 'Color', 'w')
axis square

save analysis_transformation

    


