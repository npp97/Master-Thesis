function P = exactDp(P)
    if(P.adap_method == 1)
        MF=monitor_function(sqrt(((P.D0/P.d0)^2-1))*P.F/P.fmax,P.D0);
        
        if(P.kernel_aniso > 1)
            P.R = distm_mex(P.Tp,P.Tp);
        else
            P.R = distm_mex(P.Xp,P.Xp);
        end
        
        Dp = ones(size(MF));
        
        for j=1:P.N
            Dp_old = -inf;
            Dp(j) = MF(j);
            k=0;
            while((((abs(Dp_old-Dp(j)))/Dp(j))>1e-2) && k < 15)
                Dp_old = Dp(j);
                ind = (P.R(:,j)<=P.adap_rstar*Dp(j));
                if(sum(ind)>0)
                    Dp(j) = min(MF(ind));
                    k=k+1;
                else
                    Dp(j) = MF(j);
                    break;
                end
            end
        end
    else
        Dp = (P.D0 + P.d0)/2 * ones(size(P.F));
    end
    if(size(Dp,2)>size(Dp,1))
        Dp = Dp';
    end
    P.Dp=Dp;
    P.rcp=P.adap_rstar*P.Dp;
end