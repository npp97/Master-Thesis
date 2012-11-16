function Dp = calcDp(X,Xp,rstar,Dzero)
    assert( isa(X,'double'))
    assert( isa(Xp,'double'))
    assert( isa(rstar,'double'))
    assert( isa(Dzero,'double'))
    Dp = Dzero*ones(size(X,1),1);
    for j=1:size(X,1)
        Dp_old = -inf;
        k=0;
        while((((abs(Dp_old-Dp(j)))/Dp(j))>1e-2) && k < 15)
            Dp_old = Dp(j);
            ind = (distm(X(j,:),Xp)<=rstar*Dp(j,:));
            if(sum(ind)>0)
                Dp(j) = min(monitor_function(Xp(ind,:),Dzero));
                k=k+1;
            else
                Dp(j) = monitor_function(X(j,:),Dzero);
                break;
            end
        end
    end
end