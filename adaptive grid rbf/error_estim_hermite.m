function [ P ] = error_estim_hermite( P )
    %ERROR Summary of this function goes here
    %   Detailed explanation goes here
    
    disp(['------- Error Estimates -------'])
    
    try
        P.c_herm;
    catch
        assert(false,'Missing Hermite RBF coefficients. Please run interp_hermite(P) first.')
    end
    
    warning('off','MATLAB:Axes:NegativeDataInLogAxis')
    

    dx = zeros(P.pdim,P.NX,P.N);
    if(P.kernel_aniso > 1)
        RR = sqrt(sqdistance((bsxfun(@minus,P.XX,P.Xmean)/P.M)',P.Tp'));
        for j = 1 : P.pdim
            Xm = (bsxfun(@minus,P.XX,P.Xmean)/P.M);
            dx(j,:,:) = diffm(Xm(:,j),P.Tp(:,j));
        end
    else
        RR = sqrt(sqdistance(P.XX',P.Xp'));
        for j = 1 : P.pdim
            dx(j,:,:) = diffm(P.XX(:,j),P.Xp(:,j));
        end
    end
    
    disp(['# Interpolating on MCMC Samples'])
    
    
    
    Finterp = rbf_hermite_eval(RR,P.eps,dx)*P.c_herm;

    
    P.inferror = max(abs(P.Ftrue-Finterp)/P.fmax);
    P.l1error = 1/P.NX*sum(abs(1-P.Ftrue./Finterp));

    A = rbf_hermite(P.R,P.eps,P.DM);
    invA = pinv(A);
    EF = (invA*[P.F;P.DF(:)])./diag(invA);

    %         figure(23)
    %         clf
    %
    %         subplot(2,4,1)
    %         plot(log(P.Ftrue)/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10),'r*')
    %         hold on
    %         error_ellipse(cov([log(P.Ftrue)/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10)])+eye(P.pdim)*1e-16,mean([log(P.Ftrue)/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10)]))
    %         xlabel('log function value')
    %         ylabel('log rel MCMC error')
    %
    %         subplot(2,4,5)
    %         plot(log(P.F)/log(10),log(abs(EF(1:P.N))/P.fmax)/log(10),'r*')
    %         hold on
    %         error_ellipse(cov([log(P.F)/log(10),log(abs(EF(1:P.N))/P.fmax)/log(10)])+eye(P.pdim)*1e-16,mean([log(P.F)/log(10),log(abs(EF(1:P.N))/P.fmax)/log(10)]))
    %         xlabel('log function value')
    %         ylabel('log rel particle error')
    %
    %         subplot(2,4,2)
    %         plot(log(sqrt(sum(P.Fgradtrue.^2,2)))/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10),'r*')
    %         hold on
    %         error_ellipse(cov([log(sqrt(sum(P.Fgradtrue.^2,2)))/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10)])+eye(P.pdim)*1e-16,mean([log(sqrt(sum(P.Fgradtrue.^2,2)))/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10)]))
    %         xlabel('log norm of gradient')
    %         ylabel('log rel MCMC error')
    %
    %         subplot(2,4,6)
    %         plot(log(sqrt(sum(P.DF.^2,2)))/log(10),log(abs(EF(1:P.N))/P.fmax)/log(10),'r*')
    %         hold on
    %         error_ellipse(cov([log(sqrt(sum(P.DF.^2,2)))/log(10),log(abs(EF(1:P.N))/P.fmax)/log(10)])+eye(P.pdim)*1e-16,mean([log(sqrt(sum(P.DF.^2,2)))/log(10),log(abs(EF(1:P.N))/P.fmax)/log(10)]))
    %         xlabel('log norm of gradient')
    %         ylabel('log rel particle error')
    %
    %         subplot(2,4,3)
    %         plot(log(min(RR,[],2))/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10),'r*')
    %         hold on
    %         error_ellipse(cov([log(min(RR,[],2))/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10)])+eye(2)*1e-16,mean([log(min(RR,[],2))/log(10),log(abs(P.Ftrue-Finterp)/P.fmax)/log(10)]))
    %         xlabel('log min distance to grid')
    %         ylabel('log rel MCMC error')
    %
    %         subplot(2,4,7)
    %         plot(log(min(P.R+max(max(P.R))*eye(P.N),[],2))/log(10),log(abs(EF(1:P.N))/P.fmax)/log(10),'r*')
    %         hold on
    %         error_ellipse(cov([log(min(P.R+max(max(P.R))*eye(P.N),[],2))/log(10),log(abs(EF(1:P.N))/P.fmax)])/log(10)+eye(2)*1e-16,mean([log(min(P.R+max(max(P.R))*eye(P.N),[],2))/log(10),log(abs(EF(1:P.N))/P.fmax)/log(10)]))
    %         xlabel('log min distance to grid')
    %         ylabel('log rel particle error')
    %
    %
    %
    %         try
    %             P.Nlist;
    %         catch
    %             P.Nlist = (P.R<min(repmat(P.rcp,1,P.N),repmat(P.rcp',P.N,1)))-logical(eye(P.N));
    %         end
    %
    %         subplot(2,4,4)
    %         semilogy(sum(RR<P.D0*P.adap_rstar,2),log(abs(P.Ftrue-Finterp)/P.fmax),'r*')
    %         hold on
    %         error_ellipse(cov([sum(RR<P.D0*P.adap_rstar,2),log(abs(P.Ftrue-Finterp)/P.fmax)])+eye(2)*1e-16,mean([sum(RR<P.D0*P.adap_rstar,2),log(abs(P.Ftrue-Finterp)/P.fmax)]))
    %         xlabel('Neighborhood size')
    %         ylabel('MCMC error')
    %
    %         subplot(2,4,8)
    %         semilogy(sum(P.Nlist,2),log(abs(EF(1:P.N))/P.fmax),'r*')
    %         hold on
    %         error_ellipse(cov([sum(P.Nlist,2),log(abs(EF(1:P.N))/P.fmax)])+eye(2)*1e-16,mean([sum(P.Nlist,2),log(abs(EF(1:P.N))/P.fmax)]))
    %         xlabel('Neighborhood size')
    %         ylabel('rel particle error')
    %
    %
    %         %% error on mcmc samples
    figure(24)
    clf
    
    for j = 1 : P.pdim
        for k = 1 : P.pdim
           subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)  
           if(j==k)
               %% 1D
               semilogy(P.XX(:,j),abs(P.Ftrue-Finterp)/P.fmax,'k*')
               xlim([P.paramspec{j}{3},P.paramspec{j}{4}]);
               xlabel(['log(' P.paramspec{j}{1} ')'])
               ylabel('relative error to f_{max}')
               title('Error on MCMC samples')
           else
               %% 2D
               scatter3(P.XX(:,k),P.XX(:,j),abs(P.Ftrue-Finterp)/P.fmax,log(abs(P.Ftrue-Finterp)),log(abs(P.Ftrue-Finterp)))
               view(0,90)
               set(gca,'ZScale','log')
               xlim([P.paramspec{k}{3},P.paramspec{k}{4}]);
               ylim([P.paramspec{j}{3},P.paramspec{j}{4}]);
               view(0,90)
               xlabel(['log(' P.paramspec{k}{1} ')'])
               ylabel(['log(' P.paramspec{j}{1} ')'])
               title('Error on MCMC samples')
           end
        end
    end
    
    %% error on particles
    figure(25)
    clf
    
    for j = 1 : P.pdim
        for k = 1 : P.pdim
           subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
           
           if(j==k)
               %% 1D
               semilogy(P.Xp(:,j),EF(1:P.N)/P.fmax,'k*')
               xlim([P.paramspec{j}{3},P.paramspec{j}{4}]);
               xlabel(['log(' P.paramspec{j}{1} ')'])
               ylabel('relative error to f_{max}')
               title('Error on particles')
           else
               %% 2D
               scatter3(P.Xp(:,k),P.Xp(:,j),EF(1:P.N)/P.fmax,log(EF(1:P.N)),log(EF(1:P.N)))
               view(0,90)
               set(gca,'ZScale','log')
               xlim([P.paramspec{k}{3},P.paramspec{k}{4}]);
               ylim([P.paramspec{j}{3},P.paramspec{j}{4}]);
               view(0,90)
               xlabel(['log(' P.paramspec{k}{1} ')'])
               ylabel(['log(' P.paramspec{j}{1} ')'])
               title('Error on particles')
           end
        end
    end
    
    
    %% shape parameter analysis
%     figure(26)
%     clf
%     % number of scans
%     Ne = 50;
%     % scan range
%     ee=logspace(-3,3,Ne);
%     
%     % L-\infty error
%     erf = zeros(1,Ne);
%     
%     % L-1 error
%     erf1 = zeros(1,Ne);
% 
%     % Particle error
%     erl = zeros(1,Ne);
%     
%     % Condition number
%     ercond = zeros(1,Ne);
%     
%     % transfer settings
%     Ps = P;
%     
%     warning('off','MATLAB:nearlySingularMatrix')
%     
%     disp(['# Testing different shape parameters'])
%     textprogressbar('Progress: ');
%     for j=1:Ne;
%         textprogressbar(j/Ne*100)
%         
%         % set shape parameter
%         if(Ps.kernel_shape == 2)
%             Ps.eps = ee(j)./(Ps.rcp);
%         else
%             Ps.eps = ee(j)/mean(Ps.rcp);
%         end
%         
%         % compute interpolation matrix and evaluation matrix
%         Ps.RBF_herm = rbf_hermite(Ps.R,Ps.eps,P.DM);
%         R_eval = rbf_hermite_eval(RR,Ps.eps,dx);
%         
%         % interpolate
%         Ps.c_herm = Ps.RBF_herm\[Ps.F;Ps.DF(:)];
%         Finterp = R_eval*Ps.c_herm;
%         
%         % compute errors
%         erf(j)=max(abs(P.Ftrue-Finterp)/Ps.fmax);
%         Ps.error_estim = 1;
%         erl(j)=CostEps_hermite(ee(j),Ps)/Ps.fmax;
%         erf1(j)=norm(abs(P.Ftrue-Finterp),1)/Ps.fmax;
%         ercond(j)=rcond(Ps.RBF_herm);
%         
%         % visualisation
%         loglog(ee/mean(Ps.rcp),erf,'.-k')
%         hold on
%         loglog(ee/mean(Ps.rcp),erf1,'--k')
%         loglog(ee/mean(Ps.rcp),erl,'.-r')
%         loglog(ee/mean(Ps.rcp),ercond,'.-b')
%         ylim([1e-5,1e2])
%         title(['Shape Parameter Analysis'])
%         legend('rel. max error on MCMC','rel. l1 error on MCMC','rel. max error with Cross Validation','RCOND of Interpolation Matrix','Location','SouthOutside')
%         xlabel(' Shape Parameter ')
%         ylabel(' Error ' )
%         
%     end
%     hline([],P.eps)
%     plot(P.eps,CostEps_hermite(P.eps*mean(P.rcp),P)/P.fmax,'r*')
%     textprogressbar('done')
%     
%     warning('on','MATLAB:nearlySingularMatrix')
%     
%     warning('on','MATLAB:Axes:NegativeDataInLogAxis')

end