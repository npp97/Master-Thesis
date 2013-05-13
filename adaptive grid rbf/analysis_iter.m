clear all



Nspacing = 13;
vN = linspace(1,13,Nspacing);
NN = 4;
Nrepeat = 20;


for j = 1:Nrepeat
    load init_latt
    P.Riter = 0;
    
    P.adap_D0 = 0.8;
    P.adap_d0 = P.adap_D0/1.2;
    
    P.init_D0 = 0.8;
    P.init_d0 = P.adap_D0/1.2;
    
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
        if(Ps.Riter>1)
            mdc(k,j) = Ps.dc(max(Ps.Riter-1));
            if(k>1)
                mE(k-1,j) = Ps.W(Ps.Riter-1)/Ps.N;
            end
            if(k>3)
                mEdiff(k-2,j) = (Ps.W(Ps.Riter-1)-Ps.W(Ps.Riter-2))/Ps.W(Ps.Riter-1);
            end
        else
            if(P.kernel_aniso > 1)
                P.R = distm(P.Tp,P.Tp);
            else
                P.R = distm(P.Xp,P.Xp);
            end
            P = exactDp(P);
            P.Dpq = bsxfun(@min,P.Dp,P.Dp');
            P.crit = P.Dpq./P.R;
            
            P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1)))-logical(eye(P.N));
            Ps.dc = max([max(P.crit(logical(P.Nlist))),0]);
            mdc(k,j) = Ps.dc;
        end
    end
    end

str = cellfun(@(x) num2str(x-1,2),num2cell(vN),'UniformOutput',false);

figure(60)
clf
boxplot(mlinferr',str)
xlabel('\# Iterations')
ylabel('$$\log(L_{\infty}\mbox{-error})$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')
set(gca,'YScale','log')

figure(61)
clf
boxplot(ml2err',str)
xlabel('\# Iterations')
ylabel('$$\log(L_2\mbox{-error})$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')
set(gca,'YScale','log')

figure(62)
clf
boxplot(mdc',str)
xlabel('\# Iterations')
ylabel('$$\log (d_c) $$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')
set(gca,'YScale','log')

figure(63)
clf
ksr(log(mdc(2:Nspacing,:))/log(10),log(ml2err(2:Nspacing,:))/log(10))
xlabel('$$\log (d_c) $$','Interpreter','LaTex')
ylabel('$$\log(L_2\mbox{-error})$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')

figure(64)
clf
boxplot(mE',str(2:Nspacing))
xlabel('\# Iterations')
ylabel('$$E_{avg}^{(k)}$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')

figure(65)
clf
ksr(mE,log(ml2err(2:Nspacing,:))/log(10))
xlabel('$$E_{avg}^{(k)}$$','Interpreter','LaTex')
ylabel('$$\log(L_2\mbox{-error})$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')
legend('Conditional Expectation','Samples')

figure(66)
clf
ksr(log(abs(mEdiff(2:end,:)))/log(10),log(ml2err(4:Nspacing,:))/log(10))
xlabel('$$\Delta E_{rel}^{(k)}$$','Interpreter','LaTex')
ylabel('$$\log(L_2\mbox{-error})$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')
legend('Conditional Expectation','Samples')

figure(67)
clf
boxplot(abs(mEdiff'),str(3:Nspacing))
xlabel('\# Iterations')
ylabel('$$\Delta E_{rel}^{(k)}$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')
set(gca,'YScale','log')


save([datestr(clock) '_analysis_iter'],'-v7.3')