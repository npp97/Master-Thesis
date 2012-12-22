function [f,Df] = eval_gradllh(p,P)
    xdim = size(dxdt(0,P.y0,P.Xp(1,:)),1);
    pdim = size(P.Xp,2);
    [~,yy] = ode15s(@(t,x) dxdp(t,x,exp(p),0,mStructdxdt),P.tdata,[P.y0;zeros(xdim*pdim,1)]);
    %f = sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))); logarithmic version
    f = exp(sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))));
    Df = zeros(1,length(p));
    for tk=1:length(P.tdata)
        DXDP = reshape(yy(tk,xdim+1:end),xdim,pdim);
        jspec = 1;
        for s=P.species
            %Df = Df + 2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma^2*dxdp(s,:).*exp(p); logarithmic version
            Df = f*2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma^2*DXDP(s,:).*exp(p);
            jspec=jspec+1;
        end
    end
end