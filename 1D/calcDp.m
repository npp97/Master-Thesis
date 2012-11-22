function Dp = calcDp(Xp,Xp_old,rstar,Dzero,rcp_old,f)
    assert( isa(Xp,'double'))
    assert( isa(Xp_old,'double'))
    assert( isa(rstar,'double'))
    assert( isa(Dzero,'double'))
    Dp = Dzero*ones(size(Xp,1),1);
    DF = zeros(size(Xp,1),1);
    for d=1:size(Xp_old,2)
        DF = DF +(DiffOp(Xp,Xp_old,rcp_old,d)*f).^2;
    end
    DF=sqrt(DF);
    MF=monitor_function(DF,Dzero);
    
    
    for j=1:size(Xp,1)
        Dp_old = -inf;
        Dp(j) = MF(j);
        k=0;
        while((((abs(Dp_old-Dp(j)))/Dp(j))>1e-2) && k < 15)
            Dp_old = Dp(j);
            ind = (distm_mex(Xp(j,:),Xp)<=rstar*Dp(j,:));
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
end