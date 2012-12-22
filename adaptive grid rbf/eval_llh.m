function [f] = eval_llh(p,P)
    %[~,yy] = ode15s(@(t,x) dxdt(t,x,exp(p),0),P.tdata,[P.y0]);
    
    [~,yy] = dxdt_mex(P.tdata,[P.y0],exp(p),[],[P.ode_reltol,P.ode_abstol,P.tdata(end)]);
    yy = yy';
    f = exp(sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))));
end
















