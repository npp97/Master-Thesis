function P = marginals_mls( P )
    %MARGINALS Takes problem P and plots the marginals for the rbf approximate
    warning( 'off' , 'MATLAB:legend:IgnoringExtraEntries')
    disp(['------- Computing Marginals -------'])
    
    figure(42)
    clf
    
    if(P.kernel_aniso > 1)
        Integral = sum(P.c.*sqrt(pi./P.eps.^4).^P.pdim)/sqrt(abs(det(P.M)));
    else
        Integral = sum(P.c.*sqrt(pi./P.eps.^2).^P.pdim);
    end
    
    NV = 256;
    
    SIGMA=P.M*P.M;
    
%     if(P.pdim==2)
%         xx = linspace(min(P.Xp(:,1)),max(P.Xp(:,1)),NV);
%         yy = linspace(min(P.Xp(:,2)),max(P.Xp(:,2)),NV);
%         [XX,YY] = meshgrid(xx,yy);   
%         X = [XX(:),YY(:)];
%         F = arrayfun(@(x,y) eval_llh([x y],P),X(:,1),X(:,2));
%         FF = reshape(F,size(XX));
%         nummargin(1,:) = 1/(xx(2)-xx(1))*trapz(FF,1)/Integral;
%         nummargin(2,:) = 1/(yy(2)-yy(1))*trapz(FF,2)/Integral;
%     end
    P.marg_mls = zeros(P.pdim,NV);
    P.mean_mls = zeros(P.pdim);
    
    for j=1:P.pdim
        for k=1:P.pdim
            figure(42+((j-1)*P.pdim)+k-1)
            clf
%             subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
            if(j==k)
                % 1D
                
                % evaluation points
                xx = linspace(P.paramspec{j}{3},P.paramspec{j}{4},NV)';
                % distances
                rr = sqrt(sqdistance(xx',P.Xp(:,j)'));
                % sigma
                sigma = sqrt(SIGMA(j,j));
                % mean
                mean_mcmc = mean(P.XX(:,j));
                mean_rbf = sum(P.Xp(:,j).*P.c/sum(P.c));
                mean_true = log(P.k(j));
                
                % evaluate rbf
                yy = 1/(sigma/P.eps.*sqrt(pi)).*rbf(rr,P.eps/sigma)*P.c/abs(sum(P.c));
                if( P.model == 5)
                    plot(xx,P.marg_ref(j,:),'k-','LineWidth',5)
                    hold on
                    plot(xx,yy,'r--','LineWidth',5)
                    legend('True Marginal','MLS on Lattice')
                else
                    plot(xx,P.marg_kde(j,:),'b--','LineWidth',5)
                    hold on
                    plot(xx,yy,'r--','LineWidth',5)
                    legend('KDE Marginal','MLS on Lattice')
                end

                % numerical integration
%                 scatter(P.Xp(:,j),0.1*P.c/max(abs(P.c))-1)
                
%                 vline(mean_mcmc,'k')
%                 vline(mean_rbf,'r')
%                 vline(mean_true,'c','True Parameter')
                
%                 if(P.pdim==2)
%                     plot(xx,nummargin(j,:),'b-')
%                 end
                
                xlim([P.paramspec{j}{3},P.paramspec{j}{4}]);
                xlabel(['log(' P.paramspec{j}{1} ')'])
                P.marg_mls(j,:) = yy;
                P.mean_mls(j) = mean_rbf;
            elseif(j>k)
                % 2D 
                
                % evaluation points
                xx = linspace(P.paramspec{k}{3},P.paramspec{k}{4},100);
                yy = linspace(P.paramspec{j}{3},P.paramspec{j}{4},100);
                
                [XX,YY] = meshgrid(xx,yy);
                
                X = [XX(:),YY(:)];

                SIS = pinv(sqrtm(SIGMA([k j],[k j])));
                for l = 1:length(X)
                    if(P.kernel_aniso > 1)
                        rr = sqrt(sqdistance((bsxfun(@minus,X(l,:),P.Xmean([k j]))*SIS)',(bsxfun(@minus,P.Xp(:,[k j]),P.Xmean([k j]))*SIS)'));
                    else
                        rr = sqrt(sqdistance((X(l,:))',(P.Xp(:,[k j]))'));
                    end
                    %Z(l) = 1/(sqrt(det(SIGMA([k j],[k j]))/P.eps^2*pi))*rbf(rr,P.eps)*P.c/abs(sum(P.c));
                    Z(l) = rbf(rr,P.eps)*P.c;
                end
                
                surf(XX,YY,reshape(Z,size(XX)));
                xlim([P.paramspec{k}{3},P.paramspec{k}{4}]);
                ylim([P.paramspec{j}{3},P.paramspec{j}{4}]);
                view(0,90)
                shading interp
                xlabel(['log(' P.paramspec{k}{1} ')'])
                ylabel(['log(' P.paramspec{j}{1} ')'])
            end
            axis square
            box on
            set(gcf, 'Color', 'w')
        end
    end
    
end

