function P = calcDp(P)

    
    Dp = P.D0*ones(P.N,1);
    DF = zeros(P.N,1);
    for d=1:P.dim
        DF = DF +(DiffOp(P.Xp_adv,P.Xp,P.rcp,d)*P.f).^2;
    end
    P.DF=sqrt(DF);
    MF=monitor_function(P.DF,P.D0);
    
    
    for j=1:P.N
        Dp_old = -inf;
        Dp(j) = MF(j);
        k=0;
        while((((abs(Dp_old-Dp(j)))/Dp(j))>1e-2) && k < 15)
            Dp_old = Dp(j);
            ind = (distm_mex(P.Xp(j,:),P.Xp)<=P.rstar*Dp(j,:));
            if(sum(ind)>0)
                Dp(j) = min(MF(ind));
                k=k+1;
            else
                Dp(j) = MF(j);
                break;
            end
        end
    end
    if(size(Dp,2)>size(Dp,1))
        Dp=Dp';
    end
    P.Dp = Dp;
    P.rcp = P.rstar*P.Dp;
end