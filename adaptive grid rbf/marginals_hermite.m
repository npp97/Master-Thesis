function marginals_hermite( P )
    %MARGINALS Takes problem P and plots the marginals for the rbf approximate
    warning( 'off' , 'MATLAB:legend:IgnoringExtraEntries')
    disp(['------- Computing Marginals -------'])
    
    figure(22)
    clf
    
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
    
    
    for j=1:P.pdim
        for k=1:P.pdim
            figure(22+(j-1)*P.pdim+k)
%             subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
            if(j==k)
                % 1D
                
                % evaluation points
                xx = linspace(P.paramspec{j}{3},P.paramspec{j}{4},NV)';
                % distances
                rr = sqrt(sqdistance(xx',P.Xp(:,j)'));

                dm = -1/2*diffm(xx,P.Xp(:,j));
                % sigma
                sigma = sqrt(SIGMA(j,j));
                % evaluate rbf
                E_eval = rbf_hermite_marginal1D(rr,P.eps/sigma,dm,j);
                yy = 1/(sigma/P.eps*sqrt(pi))*E_eval*P.c_herm/abs(sum(P.c_herm([1:P.N,P.N*j+1:P.N*(j+1)])));
                if( P.model == 5)
                    plot(xx,P.marg_ref(j,:),'k-','LineWidth',5)
                    hold on
                    plot(xx,yy,'r--','LineWidth',5)
                    legend('True Marginal','GHI Marginal')
                else
                    plot(xx,P.marg_kde(j,:),'b--','LineWidth',5)
                    hold on
                    plot(xx,yy,'r--','LineWidth',5)
                    legend('KDE Marginal','GHI Marginal')
                end
                
                xlim([P.paramspec{j}{3},P.paramspec{j}{4}]);
                xlabel(['log(' P.paramspec{j}{1} ')'])
            else
                % 2D
                % evaluation points
                xx = linspace(P.paramspec{k}{3},P.paramspec{k}{4},NV);
                yy = linspace(P.paramspec{j}{3},P.paramspec{j}{4},NV);
                
                [XX,YY] = meshgrid(xx,yy);
                
                X = [XX(:),YY(:)];
                
                SIS = pinv(sqrtm(SIGMA([k j],[k j])));
                
                if(P.kernel_aniso > 1)
                    TX = bsxfun(@minus,X,P.Xmean([k j]))*SIS;
                    Tp = bsxfun(@minus,P.Xp(:,[k j]),P.Xmean([k j]))*SIS;
                    rr = sqrt(sqdistance(TX',Tp'));
                    dmk = diffm(TX(:,k),Tp(:,k));
                    dmj = diffm(TX(:,j),Tp(:,j));
                else
                    rr = sqrt(sqdistance((X)',(P.Xp(:,[k j]))'));
                    dmk = diffm(xx(:,k),P.Xp(:,k));
                    dmj = diffm(xx(:,j),P.Xp(:,j));
                end
                E_eval = rbf_hermite_marginal2D(rr,P.eps,dmk,dmj);
                %Z = 1/(sqrt(det(SIGMA([k j],[k j]))/P.eps^2*pi^2))*E_eval*P.c_herm([1:P.N,P.N*min(j,k)+1:P.N*(min(j,k)+1),P.N*max(j,k)+1:P.N*(max(j,k)+1)])/abs(sum(P.c_herm([1:P.N,P.N*k+1:P.N*(k+1),P.N*j+1:P.N*(j+1)])));
                Z = E_eval*P.c_herm([1:P.N,P.N*min(j,k)+1:P.N*(min(j,k)+1),P.N*max(j,k)+1:P.N*(max(j,k)+1)]);
                
                surf(XX,YY,reshape(Z,size(XX)));
                xlim([P.paramspec{k}{3},P.paramspec{k}{4}]);
                ylim([P.paramspec{j}{3},P.paramspec{j}{4}]);
                view(0,90)
                shading interp
                xlabel(['log(' P.paramspec{k}{1} ')'])
                ylabel(['log(' P.paramspec{j}{1} ')'])
                
            end
        end
    end

end

