function [f,Df] = eval_gradllh(p,P)
    % get number of states
    xdim = P.xdim;
    % get number of parameters
    pdim = P.pdim;
    % solve ode with sensitivities
    [~,yy] = ode15s(@(t,x) P.dxdp(t,x,p,[],P.mStructdxdt),P.tdata,[P.y0;zeros(xdim*pdim,1)]);
    
    % compute likelihood
    f = exp(sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))));
    
    % compute gradient
    Df = zeros(1,length(p));
    for tk=1:length(P.tdata)
        DXDP = reshape(yy(tk,xdim+1:end),xdim,pdim);
        jspec = 1;
        for s=P.species
            Df = f*2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma^2*DXDP(s,:).*exp(p);
            jspec=jspec+1;
        end
    end
end