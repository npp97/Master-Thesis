function [f,Df,F] = eval_gradllh(p,P)
    % get number of states
    xdim = P.xdim;
    % get number of parameters
    pdim = P.pdim;
    % reparametrise
    pt = P.logscale.*exp(p) + (1-P.logscale).*p;
    % solve ode with sensitivities
    [~,yy] = ode15s(@(t,x) P.dxdp(t,x,pt,[],P.mStructdxdt),P.tdata,[P.y0;zeros(xdim*pdim,1)]);
    
    % compute likelihood
    f = exp(sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))));
    
    MS = zeros(pdim,pdim);
    % compute gradient
    Df = zeros(1,P.pdim);
    F = zeros(P.pdim,P.pdim);
    try
        for tk=1:length(P.tdata)
            DXDP = reshape(yy(tk,xdim+1:end),xdim,pdim);
            jspec = 1;
            for s=P.species
                Df = f*2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma^2*DXDP(s,:).*(P.logscale.*exp(p) + (1-P.logscale));
                Dlogf = 2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma^2*DXDP(s,:).*(P.logscale.*exp(p) + (1-P.logscale));
                jspec=jspec+1;
                F = F + 1/P.sigma^2*(DXDP(s,:)'*DXDP(s,:));
            end
            MS = MS + DXDP;
        end
    catch
        f=0;
    end
    S = sum(MS(P.species,:),1);

end