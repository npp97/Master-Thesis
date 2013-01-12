function [ P ] = init( P )
    %INIT Summary of this function goes here
    %   Detailed explanation goes here
    % initialise positions

    P.D0 = P.init_D0;
    P.d0 = P.init_d0;
    
    P.Xp = P.logscale.*log(P.k)+(1-P.logscale).*P.k;
    if(P.kernel_aniso > 1)
        P.Tp = zeros(1,P.pdim);
        P.Xmean = P.Xp;
        P.M = eye(P.pdim);
    end
    
    P.N = size(P.Xp,1);
    P.Lp = ones(size(P.Xp,1),1);
    P.fmax = 1;
    
    if(P.adap_method == 2)
        P = gradllh(P);
    else
        P = llh(P);
    end
    
    if(P.adap_method == 1 || P.adap_method == 2 || P.adap_method == 3)
        P = exactDp(P);
    end
    
    
    P.fmax = P.F(1);
    
    %% 2.3 Initial particle distribution
    
    P.Iiter = 1;
    
    P.Nprev = 0;
    
    try
        load Xp_init
    catch
        switch(P.init_method)
            case 1
                % still need to think of something smart
            case 2
                % still need to think of something smart
            case 3
                % nothing to do, we already have the initial point
        end
        
    end
    
end

