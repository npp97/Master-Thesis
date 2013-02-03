function [f] = eval_llh(p,P)
    %[~,yy] = ode15s(@(t,x) dxdt(t,x,exp(p),0),P.tdata,[P.y0]);
    
    if((1-P.logscale).*p<0)
        f = 0;
    else
        try
            pt = P.logscale.*exp(p) + (1-P.logscale).*p;
            [~,yy] = P.ode(P.tdata,[P.y0],pt,[],[P.ode_reltol,P.ode_abstol,P.tdata(end)]);
            yy = yy';
            f = exp(sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))));
        catch
            f=0;
        end
    end
end
















