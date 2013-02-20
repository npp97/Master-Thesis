function [ P ] = error_estim( P )
    %ERROR Summary of this function goes here
    %   Detailed explanation goes here
    
    disp(['------- Error Estimates -------'])
    
    Ftrue = zeros(P.NX,1);
    Fgradtrue = zeros(P.NX,P.pdim);
    if(P.kernel_aniso > 1)
        RR = sqrt(sqdistance((bsxfun(@minus,P.XX,P.Xmean)/P.M)',P.Tp'));
    else
        RR = sqrt(sqdistance(P.XX',P.Xp'));
    end
    
    P = gradllh(P);
    
    disp(['# Computing Gradients on MCMC Samples'])
    textprogressbar('Progress: ');
    for j = 1 : P.NX
        textprogressbar(j/P.NX*100)
        [Ftrue(j),Fgradtrue(j,:)] = eval_gradllh(P.XX(j,:),P);
    end
    textprogressbar('done');
    
    disp(['# Interpolating on MCMC Samples'])
    if(P.kernel_aniso > 1)
        Finterp = rbf(RR,P.eps)*P.c;
    else
        Finterp = rbf(RR,P.eps)*P.c;
    end
    
    P.inferror = max(abs(Ftrue-Finterp)/P.fmax);
    P.l1error = 1/P.NX*sum(abs(1-Ftrue./Finterp));

    A = rbf(P.R,P.eps);
    invA = pinv(A);
    EF = (invA*P.F)./diag(invA);

    figure(13)
    clf
    
    subplot(2,4,1)
    plot(log(Ftrue),log(abs(Ftrue-Finterp)/P.fmax),'r*')
    hold on
    error_ellipse(cov([log(Ftrue),log(abs(Ftrue-Finterp)/P.fmax)])+eye(P.pdim)*1e-16,mean([log(Ftrue),log(abs(Ftrue-Finterp)/P.fmax)]))
    xlabel('log function value')
    ylabel('log rel MCMC error')
    
    subplot(2,4,5)
    plot(log(P.F),log(abs(EF)/P.fmax),'r*')
    hold on
    error_ellipse(cov([log(Ftrue),log(abs(Ftrue-Finterp)/P.fmax)])+eye(P.pdim)*1e-16,mean([log(Ftrue),log(abs(Ftrue-Finterp)/P.fmax)]))
    xlabel('log function value')
    ylabel('log rel particle error')
    
    subplot(2,4,2)
    plot(log(sqrt(sum(Fgradtrue.^2,2))),log(abs(Ftrue-Finterp)/P.fmax),'r*')
    hold on
    error_ellipse(cov([log(sqrt(sum(Fgradtrue.^2,2))),log(abs(Ftrue-Finterp)/P.fmax)])+eye(P.pdim)*1e-16,mean([log(sqrt(sum(Fgradtrue.^2,2))),log(abs(Ftrue-Finterp)/P.fmax)]))
    xlabel('log norm of gradient')
    ylabel('log rel MCMC error')
    
    subplot(2,4,6)
    plot(log(sqrt(sum(P.DF.^2,2))),log(abs(EF)/P.fmax),'r*')
    hold on
    error_ellipse(cov([log(sqrt(sum(Fgradtrue.^2,2))),log(abs(Ftrue-Finterp)/P.fmax)])+eye(P.pdim)*1e-16,mean([log(sqrt(sum(Fgradtrue.^2,2))),log(abs(Ftrue-Finterp)/P.fmax)]))
    xlabel('log norm of gradient')
    ylabel('log rel particle error')
   
    subplot(2,4,3)
    plot(log(min(RR,[],2)),log(abs(Ftrue-Finterp)/P.fmax),'r*')
    hold on
    error_ellipse(cov([log(min(RR,[],2)),log(abs(Ftrue-Finterp)/P.fmax)])+eye(P.pdim)*1e-16,mean([log(min(RR,[],2)),log(abs(Ftrue-Finterp)/P.fmax)]))
    xlabel('log min distance to grid')
    ylabel('log rel MCMC error')
    
    subplot(2,4,7)
    plot(log(min(P.R+max(max(P.R))*eye(P.N),[],2)),log(abs(EF)/P.fmax),'r*')
    hold on
    error_ellipse(cov([log(min(P.R+max(max(P.R))*eye(P.N),[],2))+eye(P.pdim)*1e-16,log(abs(EF)/P.fmax)]),mean([log(min(P.R+max(max(P.R))*eye(P.N),[],2)),log(abs(EF)/P.fmax)]))
    xlabel('log min distance to grid')
    ylabel('log rel particle error') 
    

    
    try
        P.Nlist;
    catch
        P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1)))-logical(eye(P.N));
    end

    subplot(2,4,4)
    semilogy(sum(RR<P.D0*P.adap_rstar,2),log(abs(Ftrue-Finterp)/P.fmax),'r*')
    hold on
    error_ellipse(cov([sum(RR<P.D0*P.adap_rstar,2),log(abs(Ftrue-Finterp)/P.fmax)]),mean([sum(RR<P.D0*P.adap_rstar,2),log(abs(Ftrue-Finterp)/P.fmax)]))
    xlabel('Neighborhood size')
    ylabel('MCMC error')  
    
    subplot(2,4,8)
    semilogy(sum(P.Nlist,2),log(abs(EF)/P.fmax),'r*')
    hold on
    error_ellipse(cov([sum(P.Nlist,2),log(abs(EF)/P.fmax)])+eye(P.pdim)*1e-16,mean([sum(P.Nlist,2),log(abs(EF)/P.fmax)]))
    xlabel('Neighborhood size')
    ylabel('log rel particle error')  
    
    %% error on mcmc samples
    figure(14)
    title('Error on MCMC samples')
    for j = 1 : P.pdim
        for k = 1 : P.pdim
           subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
           if(j==k)
               %% 1D
               semilogy(P.XX(:,j),abs(Ftrue-Finterp)/P.fmax,'k*')
               xlim([P.paramspec{j}{3},P.paramspec{j}{4}]);
               xlabel(['log(' P.paramspec{j}{1} ')'])
               ylabel('relative error to f_{max}')
           else
               %% 2D
               scatter3(P.XX(:,k),P.XX(:,j),abs(Ftrue-Finterp)/P.fmax,log(abs(Ftrue-Finterp)),log(abs(Ftrue-Finterp)))
               view(0,90)
               set(gca,'ZScale','log')
               xlim([P.paramspec{k}{3},P.paramspec{k}{4}]);
               ylim([P.paramspec{j}{3},P.paramspec{j}{4}]);
               view(0,90)
               xlabel(['log(' P.paramspec{k}{1} ')'])
               ylabel(['log(' P.paramspec{j}{1} ')'])
           end
        end
    end
    
    %% error on particles
    figure(15)
    title('Error on particles')
    for j = 1 : P.pdim
        for k = 1 : P.pdim
           subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
           if(j==k)
               %% 1D
               semilogy(P.Xp(:,j),EF/P.fmax,'k*')
               xlim([P.paramspec{j}{3},P.paramspec{j}{4}]);
               xlabel(['log(' P.paramspec{j}{1} ')'])
               ylabel('relative error to f_{max}')
           else
               %% 2D
               scatter3(P.Xp(:,k),P.Xp(:,j),EF/P.fmax,log(EF),log(EF))
               view(0,90)
               set(gca,'ZScale','log')
               xlim([P.paramspec{k}{3},P.paramspec{k}{4}]);
               ylim([P.paramspec{j}{3},P.paramspec{j}{4}]);
               view(0,90)
               xlabel(['log(' P.paramspec{k}{1} ')'])
               ylabel(['log(' P.paramspec{j}{1} ')'])
           end
        end
    end
    
    %% shape parameter analysis
    figure(16)
    clf
    % number of scans
    Ne = 20;
    % scan range
    ee=logspace(-1,0.5,Ne);
    
    % L-\infty error
    erf = zeros(1,Ne);
    
    % L-1 error
    erf1 = zeros(1,Ne);

    % Particle error
    erl = zeros(1,Ne);
    
    % Condition number
    ercond = zeros(1,Ne);
    
    % transfer settings
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
        erf(j)=max(abs(Ftrue-Finterp)/Ps.fmax);
        Ps.error_estim = 1;
        erl(j)=CostEps(ee(j),Ps)/Ps.fmax;
        erf1(j)=norm(abs(Ftrue-Finterp),1)/Ps.fmax;
        ercond(j)=rcond(Ps.RBF);
        
        % visualisation
        loglog(ee/mean(Ps.rcp),erf,'.-k')
        hold on
        loglog(ee/mean(Ps.rcp),erf1,'--k')
        loglog(ee/mean(Ps.rcp),erl,'.-r')
        loglog(ee/mean(Ps.rcp),ercond,'.-b')
        ylim([1e-10,1e0])
        title(['Shape Parameter Analysis'])
        legend('rel. max error on extra grid','rel. l1 error on extra grid','rel. max error with Rippa Method','RCOND of Interpolation Matrix','Location','SouthOutside')
        xlabel(' Shape Parameter ')
        ylabel(' Error ' )
        
        drawnow
    end
    textprogressbar('done')
    
    warning('on','MATLAB:nearlySingularMatrix')
end