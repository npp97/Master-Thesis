function plot_dens2D( xx )
    %PLOT_DENS Summary of this function goes here
    %   Detailed explanation goes here
    
    if ( size(xx,2) ~= 2)
        error('wrong sample dimensions')
    end
    N = size(xx,1);
    
    a = min(xx);
    b = max(xx);
    
    NV = 100;
    
    X = linspace(a(1),b(1),NV);
    Y = linspace(a(2),b(2),NV);
    
    [XX,YY] = meshgrid(X,Y);
    
    eval = [XX(:),YY(:)];
    
    KDest = kde_simple(xx',eval');
    
    surf(XX,YY,reshape(KDest,size(XX)));
    shading interp
    view(0,90)
    xlim([a(1),b(1)]);
    ylim([a(2),b(2)]);
    
    
end

