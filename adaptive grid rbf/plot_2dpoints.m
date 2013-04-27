function plot_2dpoints( P, fig )
    figure(fig)
    clf

    X = P.Xp;

    scatter3(X(:,1),X(:,2),log(P.F)/log(10),ones(P.N,1)*16,log(P.F)/log(10),'fill')
    
    xlabel([ P.paramspec{1}{1} ])
    ylabel([ P.paramspec{2}{1} ])
    axis square
    box on
    set(gcf, 'Color', 'w')
    view(0,90)
    colorbar
    
    figure(fig+1)
    clf

    hold on
    X = P.Tp;

    scatter3(X(:,1),X(:,2),log(P.F)/log(10),ones(P.N,1)*16,log(P.F)/log(10),'fill')
    
    xlabel([ P.paramspec{1}{1} ])
    ylabel([ P.paramspec{2}{1} ])
    axis square
    box on
    set(gcf, 'Color', 'w')
    view(0,90)
    colorbar

end