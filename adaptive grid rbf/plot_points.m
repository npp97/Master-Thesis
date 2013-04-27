function plot_points( P, fig )
    figure(fig)
    
    mode = 1;
    
    X = P.Xp;
    %X = P.Tp;
    
    switch(mode)
        case 1
            for j = 1:P.pdim
                for k = 1:P.pdim
                    if(j == k)
                        % 1D case
                        subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
                        
                        scatter(X(:,j),P.F,ones(P.N,1)*16,log(P.F)/log(10))
                        set(gca,'YScale','log')
                        xlim([min(P.Tp(:,k))-1e-6,max(P.Xp(:,k))+1e-6]);
                        xlabel(['log(' P.paramspec{j}{1} ')'])
                        
                    elseif(k > j)
                        % 2D case
                        subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
                        
                        scatter(X(:,k),X(:,j),ones(P.N,1)*16,log(P.F)/log(10))
                        
                        xlim([min(X(:,k))-1e-6,max(X(:,k))+1e-6]);
                        ylim([min(X(:,j))-1e-6,max(X(:,j))+1e-6]);
                        xlabel(['log(' P.paramspec{k}{1} ')'])
                        ylabel(['log(' P.paramspec{j}{1} ')'])
                        
                    end
                end
            end
        case 2
            for j = 1:P.pdim
                for k = 1:P.pdim
                    if(j == k)
                        % 1D case
                        subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
                        
                        smoothhist2D([P.Xp(:,j),log(P.F)/log(10)],10,[100,100])
                        %scatter(P.Xp(:,j),P.F,ones(P.N,1)*16,log(P.F)/log(10))
                        %set(gca,'YScale','log')
                        %xlim([min(P.Xp(:,k))-1e-6,max(P.Xp(:,k))+1e-6]);
                        xlabel(['log(' P.paramspec{j}{1} ')'])
                        
                    elseif(k > j)
                        % 2D case
                        subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
                        
                        smoothhist2D([P.Xp(:,k),P.Xp(:,j)],10,[100,100])
                        
                        xlabel(['log(' P.paramspec{k}{1} ')'])
                        ylabel(['log(' P.paramspec{j}{1} ')'])
                        
                    end
                end
            end
    end
end