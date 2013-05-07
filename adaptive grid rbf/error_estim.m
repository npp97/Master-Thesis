function [ P ] = error_estim( P )
    %ERROR Summary of this function goes here
    %   Detailed explanation goes here
    
    try
        P.c;
    catch
        assert(false,'Missing RBF coefficients. Please run interp(P) first.')
    end

    disp(['------- Error Estimates -------'])
    
    if(P.kernel_aniso > 1)
        RR = sqrt(sqdistance((bsxfun(@minus,P.XX,P.Xmean)/P.M)',P.Tp'));
    else
        RR = sqrt(sqdistance(P.XX',P.Xp'));
    end
    
    disp(['# Interpolating on MCMC Samples'])
    if(P.kernel_aniso > 1)
        Finterp = rbf(RR,P.eps)*P.c;
    else
        Finterp = rbf(RR,P.eps)*P.c;
    end
    
    P.inferror = max(abs(P.Ftrue-Finterp)/P.fmax);
    P.l1error = 1/P.NX*sum(abs(1-Finterp./P.Ftrue));
    P.l2error = 1/P.NX*sum(abs(P.Ftrue-Finterp).^2./P.Ftrue);

    A = rbf(P.R,P.eps);
    invA = pinv(A);
    EF = (invA*P.F)./diag(invA);

    figure(13)
    clf
    
    
%     %subplot(2,2,1)
%     figure(6)
%     clf
%     r_fval = ksr(log(P.Ftrue)/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10));
%     plot3(r_fval.x,r_fval.m,10*ones(1,100),'k-','LineWidth',5)
%     plot3(r_fval.x,r_fval.m+r_fval.s,10*ones(1,100),'r--','LineWidth',5)
%     plot3(r_fval.x,r_fval.m-r_fval.s,10*ones(1,100),'r--','LineWidth',5)
%     hold on
%     plot_dens2D([log(P.Ftrue)/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10)]);
%     box on
%     set(gcf, 'Color', 'w')
%     axis square
%     colorbar
%     xlabel('log function value')
%     ylabel('log error')
%     legend('Conditional Expectation')
%     
%     %subplot(2,2,2)
%     figure(7)
%     clf
%     r_grad = ksr(log(sqrt(sum(P.Fgradtrue.^2,2)))/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10));
%     plot3(r_grad.x,r_grad.f,10*ones(1,100),'k-','LineWidth',5)
%     hold on
%     plot_dens2D([log(sqrt(sum(P.Fgradtrue.^2,2)))/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10)]);
%     box on
%     set(gcf, 'Color', 'w')
%     axis square
%     colorbar
%     xlabel('log norm of gradient')
%     ylabel('log error')
%     legend('Conditional Expectation')
%     
    %subplot(2,2,3)
%     figure(8)
%     clf
%     r_fval = ksr(log(P.F(P.F>0))/log(10),log(abs(EF(P.F>0))/P.fmax)/log(10));
%     plot3(r_fval.x,r_fval.f,10*ones(1,100),'k-','LineWidth',5)
%     hold on
%     plot_dens2D([log(P.F(P.F>0))/log(10),log(abs(EF(P.F>0))/P.fmax)/log(10)]);
%     box on
%     set(gcf, 'Color', 'w')
%     axis square
%     colorbar
%     xlabel('log function value')
%     ylabel('log error')
%     legend('Conditional Expectation')
%     
%     %subplot(2,2,4)
%     figure(9)
%     clf
%     r_grad = ksr(log(sqrt(sum(P.DF(sqrt(sum(P.DF.^2,2))>0).^2,2)))/log(10),log(abs(EF(sqrt(sum(P.DF.^2,2))>0))/P.fmax)/log(10));
%     plot3(r_grad.x,r_grad.f,10*ones(1,100),'k-','LineWidth',5)
%     hold on
%     plot_dens2D([log(sqrt(sum(P.DF(sqrt(sum(P.DF.^2,2))>0).^2,2)))/log(10),log(abs(EF(sqrt(sum(P.DF.^2,2))>0))/P.fmax)/log(10)]);
%     box on
%     set(gcf, 'Color', 'w')
%     axis square
%     colorbar
%     xlabel('log norm of gradient')
%     ylabel('log error')
%     legend('Conditional Expectation')
    
    % error on mcmc samples
%     figure(14)
%     clf
%     
%     for j = 1 : P.pdim
%         for k = 1 : P.pdim
%            subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
%            if(j==k)
%                % 1D
%                scatter(P.XX(:,j),abs(P.Ftrue-Finterp)/P.fmax,ones(size(Finterp)),log(abs(P.Ftrue-Finterp)+1))
%                set(gca,'YScale','log')
%                xlim([P.paramspec{j}{3},P.paramspec{j}{4}]);
%                xlabel(['log(' P.paramspec{j}{1} ')'])
%                ylabel('relative error to f_{max}')
%                title('Error on MCMC samples')
%            else
%                % 2D
%                scatter3(P.XX(:,k),P.XX(:,j),abs(P.Ftrue-Finterp)/P.fmax,ones(size(Finterp)),log(abs(P.Ftrue-Finterp)+1))
%                view(0,90)
%                set(gca,'ZScale','log')
%                xlim([P.paramspec{k}{3},P.paramspec{k}{4}]);
%                ylim([P.paramspec{j}{3},P.paramspec{j}{4}]);
%                view(0,90)
%                xlabel(['log(' P.paramspec{k}{1} ')'])
%                ylabel(['log(' P.paramspec{j}{1} ')'])
%                title('Error on MCMC samples')
%            end
%         end
%     end
%     
%     % error on particles
%     figure(15)
%     clf
%     
%     for j = 1 : P.pdim
%         for k = 1 : P.pdim
%            subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
%            if(j==k)
%                % 1D
%                scatter(P.Xp(:,j),abs(EF/P.fmax),ones(size(EF))*5,log(abs(EF/P.fmax)+1))
%                %semilogy(P.Xp(:,j),EF/P.fmax,'k*')
%                set(gca,'YScale','log')
%                xlim([P.paramspec{j}{3},P.paramspec{j}{4}]);
%                xlabel(['log(' P.paramspec{j}{1} ')'])
%                ylabel('relative error to f_{max}')
%                title('Error on particles')
%            else
%                % 2D
%                scatter3(P.Xp(:,k),P.Xp(:,j),abs(EF/P.fmax),ones(size(EF))*5,log(abs(EF/P.fmax)+1))
%                view(0,90)
%                set(gca,'ZScale','log')
%                xlim([P.paramspec{k}{3},P.paramspec{k}{4}]);
%                ylim([P.paramspec{j}{3},P.paramspec{j}{4}]);
%                view(0,90)
%                xlabel(['log(' P.paramspec{k}{1} ')'])
%                ylabel(['log(' P.paramspec{j}{1} ')'])
%                title('Error on particles')
%            end
%         end
%     end
%     
%     % shape parameter analysis
    figure(16)
    clf
    %number of scans
    Ne = 100;
    %scan range
    ee=logspace(-4,2,Ne);
    
    %L-\infty error
    erf = zeros(1,Ne);
    
    %L-1 error
    erf1 = zeros(1,Ne);

    %Particle error
    erl = zeros(1,Ne);
    
    %Condition number
    ercond = zeros(1,Ne);
    
    %transfer settings
    Ps = P;
    
    warning('off','MATLAB:nearlySingularMatrix')
    
    disp(['# Testing different shape parameters'])
    textprogressbar('Progress: ');
    for j=1:Ne;
        textprogressbar(j/Ne*100)
        
        % set shape parameter
        if(Ps.kernel_shape == 2)
            Ps.eps = ee(j)./(Ps.rcp);
        else
            Ps.eps = ee(j)/mean(Ps.rcp);
        end
        
        % compute interpolation matrix and evaluation matrix
        Ps.RBF = rbf(Ps.R,Ps.eps);
        R_eval = rbf(RR,Ps.eps);
        
        % interpolate
        Ps.c = Ps.RBF\Ps.F;
        Finterp = R_eval*Ps.c;
        
        % compute errors
        erf(j)=max(abs(P.Ftrue-Finterp)/Ps.fmax);
        Ps.error_estim = 1;
        erl(j)=CostEps(ee(j),Ps)/Ps.fmax;
        erf1(j)=norm(abs(P.Ftrue-Finterp),1)/Ps.fmax;
        ercond(j)=rcond(Ps.RBF);
        
        
        % visualisation

    end
    loglog(ee/mean(Ps.rcp),erf,'.-k','LineWidth',5,'MarkerSize',25)
    hold on
    %loglog(ee/mean(Ps.rcp),erf1,'--k')
    loglog(ee/mean(Ps.rcp),erl,'.-r','LineWidth',5,'MarkerSize',25)
    loglog(ee/mean(Ps.rcp),ercond,'.-b','LineWidth',5,'MarkerSize',25)
    ylim([1e-5,1e2])
    title(['Shape Parameter Analysis'])
    legend('rel. max error on MCMC samples','rel. l1 error on MCMC samples','rel. max error with Cross Validation','RCOND of Interpolation Matrix','Location','SouthOutside')
    xlabel(' Shape Parameter ')
    ylabel(' Error ' )
    vline(P.eps)
    plot(P.eps,CostEps(P.eps*mean(P.rcp),P)/P.fmax,'r*')
    textprogressbar('done')
    
    warning('on','MATLAB:nearlySingularMatrix')
end