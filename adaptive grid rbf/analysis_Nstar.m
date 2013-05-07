clear all



vN = [4 5 6 7];
NN = 4;
Nrepeat = 10;


for j = 1:NN
    for k = 1:Nrepeat
        disp(['j: ' num2str(j) ' / ' num2str(NN)])
        disp(['k: ' num2str(k) ' / ' num2str(Nrepeat)])
        load adap_dens_latt
        P.Riter = 0;
        
        P.adap_D0 = 1;
        P.adap_d0 = P.adap_D0/1.2;
        
        P.init_D0 = 1;
        P.init_d0 = P.adap_D0/1.2;
        
        P.d0 = P.init_d0;
        P.D0 = P.init_D0;
        P.plotflag=false;
        
        Ps = P;
        Ps = refine_particles( Ps );
        mPs(j,k) = Ps;
        mIter(j,k) = Ps.Riter;
        mN(j,k) = Ps.N;
        Ps = mPs(j,k);
        Ps = interp(Ps);
        
        if(Ps.kernel_aniso > 1)
            RR = sqrt(sqdistance((bsxfun(@minus,Ps.XX,Ps.Xmean)/Ps.M)',Ps.Tp'));
        else
            RR = sqrt(sqdistance(Ps.XX',Ps.Xp'));
        end
        
        if(P.kernel_aniso > 1)
            Finterp = rbf(RR,Ps.eps)*Ps.c;
        else
            Finterp = rbf(RR,Ps.eps)*Ps.c;
        end
        
        ml2err(j,k) = 1/Ps.NX*sum(abs(Ps.Ftrue - Finterp).^2./Ps.Ftrue);
        mlinferr(j,k) = max(abs(Ps.Ftrue - Finterp));
        mPs(j,k) = Ps;
    end
end


str = cellfun(@(x) num2str(x,2),num2cell(vN),'UniformOutput',false);

figure(50)
clf
boxplot(mlinferr',str)
xlabel('N^*')
ylabel('l_{\infty} error')
axis square
set(gcf, 'Color', 'w')

figure(51)
clf
boxplot(mN',str)
xlabel('N^*')
ylabel('# Points')
axis square
set(gcf, 'Color', 'w')

figure(52)
clf
boxplot(mIter',str)
xlabel('N^*')
ylabel('# Iterations')
axis square
set(gcf, 'Color', 'w')


figure(53)
clf
boxplot(ml2err',str)
xlabel('N^*')
ylabel('L_{2} error')
axis square
set(gcf, 'Color', 'w')

save([datestr(clock) '_analysis_Nstar'])
