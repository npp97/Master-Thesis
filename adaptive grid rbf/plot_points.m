function plot_points( P, fig )
    figure(fig)
    
    for j = 1:P.pdim
        for k = 1:P.pdim
            if(j == k)
                % 1D case
                subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
                
                scatter(P.Xp(:,j),P.F,ones(P.N,1)*16,log(P.F)/log(10))
                set(gca,'YScale','log')
                xlim([min(P.Xp(:,k))-1e-6,max(P.Xp(:,k))+1e-6]);
                xlabel(['log(' P.paramspec{j}{1} ')'])
                
            elseif(k > j)
                % 2D case
                subplot(P.pdim,P.pdim,(j-1)*P.pdim+k)
                
                scatter(P.Xp(:,k),P.Xp(:,j),ones(P.N,1)*16,log(P.F)/log(10))
                
                xlim([min(P.Xp(:,k))-1e-6,max(P.Xp(:,k))+1e-6]);
                ylim([min(P.Xp(:,j))-1e-6,max(P.Xp(:,j))+1e-6]);
                xlabel(['log(' P.paramspec{k}{1} ')'])
                ylabel(['log(' P.paramspec{j}{1} ')'])
                
            end
        end
    end
end