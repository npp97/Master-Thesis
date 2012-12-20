function [f,Df,D2f] = eval_llh(p,P)
    xdim = size(dxdt(0,P.y0,P.Xp(1,:)),1);
    pdim = size(P.Xp,2);
    
    [~,yy] = ode15s(@(t,x) dxdt(t,x,exp(p)),P.tdata,[P.y0]);
    f = prod(prod(normpdf(yy(:,P.species),P.ydata,P.sigma)));

end
















