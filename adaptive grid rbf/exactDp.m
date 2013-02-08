function P = exactDp(P)
    if(P.adap_method == 1)
        MF=monitor_function(sqrt(((P.D0/P.d0)^2-1))*P.F/P.fmax,P.D0);
        
        if(size(MF,1)>size(MF,2))
            MF = MF';
        end
        
        Dp = min(repmat(MF,P.N,1) + (P.R>P.adap_rstar*repmat(MF,P.N,1))*max(P.adap_D0,P.adap_d0)*100,[],2);
        
    else
        Dp = (P.D0 + P.d0)/2 * ones(size(P.F));
    end
    if(size(Dp,2)>size(Dp,1))
        Dp = Dp';
    end
    P.Dp=Dp;
    P.rcp=P.adap_rstar*P.Dp;
end