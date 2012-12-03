function P = exactDp(P)

    
    Dp=zeros(P.N,1);
    
    MF=monitor_function(P.DF,P.D0);
   
    P.R = distm_mex(P.Xp,P.Xp);
    
    for j=1:P.N
        Dp_old = -inf;
        Dp(j) = MF(j);
        k=0;
        while((((abs(Dp_old-Dp(j)))/Dp(j))>1e-2) && k < 15)
            Dp_old = Dp(j);
            ind = (P.R(:,j)<=P.rstar*Dp(j));
            if(sum(ind)>0)
                Dp(j) = min(MF(ind));
                k=k+1;
            else
                Dp(j) = MF(j);
                break;
            end
        end
    end
    P.Dp=Dp;
    P.rcp=P.rstar*P.Dp;
end