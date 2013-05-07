clear all


Nspacing = 6;
vN = linspace(0.7,0.9,Nspacing);
Nrepeat = 20;


for j = 1:Nspacing
    load adap_dens_latt
    P.Riter = 0;
    P.max_iter = 20;
    P.adap_d0 = 0.7;
    P.adap_D0 = vN(j);
    
    P.init_d0 = 0.7;
    P.init_D0 = vN(j);
    P.d0 = P.init_d0;
    P.D0 = P.init_D0;
    P.plotflag=false;
    for k = 1:Nrepeat
        Ps = P;
        disp(['j: ' num2str(j) ' / ' num2str(Nspacing)])
        disp(['k: ' num2str(k) ' / ' num2str(Nrepeat)])
        
        
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

str = cellfun(@(x) num2str(x/P.adap_d0,3),num2cell(vN),'UniformOutput',false);

figure(70)
clf
boxplot(mlinferr,str)
xlabel('\frac{D_0}{d_0}')
ylabel('$$\log(L_{\infty}\mbox{-error})$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')
set(gca,'YScale','log')

figure(71)
clf
boxplot(ml2err,str)
xlabel('\frac{D_0}{d_0}')
ylabel('$$\log(L_2\mbox{-error})$$','Interpreter','LaTex')
axis square
set(gcf, 'Color', 'w')
set(gca,'YScale','log')

figure(72)
clf
boxplot(mN,str)
xlabel('\frac{D_0}{d_0}')
ylabel('# Points')
axis square
set(gcf, 'Color', 'w')

save([datestr(clock) '_analysis_dens_difference'],'-v7.3')