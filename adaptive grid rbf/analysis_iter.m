clear all


Nspacing = 15;
vN = linspace(0,15,Nspacing);
NN = 4;
Nrepeat = 10;


for j = 1:Nrepeat
    load adap_dens_latt
    P.adap_d0 = 1;
    P.adap_D0 = 1.2;
    
    P.init_d0 = 1;
    P.init_D0 = 1.2;
    P.d0 = P.init_d0;
    P.D0 = P.init_D0;
    P.plotflag=false;
    Ps = P;
    for k = 1:Nspacing
        disp(['j: ' num2str(j) ' / ' num2str(Nrepeat)])
        disp(['k: ' num2str(k) ' / ' num2str(Nspacing)])
        
        Ps.max_iter = vN(k);
        
        Ps = refine_particles( Ps );
        mIter(k,j) = Ps.Riter;
        mN(k,j) = Ps.N;
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
        
        ml2err(k,j) = 1/Ps.NX*sum(abs(Ps.Ftrue - Finterp).^2./Ps.Ftrue);
        mlinferr(k,j) = max(abs(Ps.Ftrue - Finterp));
        mdc(k,j) = Ps.dc(max(x.Riter-1,1));
        mPs(k,j) = Ps;
    end
end

%mdc = arrayfun(@(x) max([max(1./x.crit(logical(x.Nlist)),0]);,mPs);
%mdr = arrayfun(@(x) x.rI(max(x.Riter-1,1)),mPs);


str = cellfun(@(x) num2str(x,2),num2cell(vN),'UniformOutput',false);

figure(60)
clf
boxplot(mlinferr',str)
xlabel('# Iterations')
ylabel('l_{\infty} error')
axis square
set(gcf, 'Color', 'w')

figure(61)
clf
boxplot(ml2err',str)
xlabel('# Iterations')
ylabel('l_{2} error')
axis square
set(gcf, 'Color', 'w')

figure(62)
clf
boxplot(mdc',str)
xlabel('# Iterations')
ylabel('d_c')
axis square
set(gcf, 'Color', 'w')



save([datestr(clock) '_analysis_iter'],'-v7.3')