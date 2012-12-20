function [f,Df,D2f] = eval_lapllh(p,P)
    xdim = size(dxdt(0,P.y0,P.Xp(1,:)),1);
    pdim = size(P.Xp,2);
    
    [~,yy] = ode15s(@(t,x) dxdpdp(t,x,exp(p)),P.tdata,[P.y0;zeros(xdim*pdim,1);zeros(xdim*pdim*pdim,1)]);
    %f = sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))); logarithmic version
    f = exp(sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))));
    Df = zeros(1,length(p));
    D2f = zeros(length(p),length(p));
    
    for tk=1:length(P.tdata)
        dxdp = reshape(yy(tk,xdim+1:xdim+xdim*pdim),xdim,pdim);
        dxdpdp = reshape(yy(tk,xdim+xdim*pdim+1:end),xdim,pdim,pdim);
        jspec = 1;
        for s=P.species
            %Df = Df + 2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma^2*dxdp(s,:).*exp(p); logarithmic version
            Df = Df - f*2*(yy(tk,P.species)-P.ydata(tk,jspec))/P.sigma^2*dxdp(s,:).*exp(p);
            
            T1 = 4*((yy(tk,P.species)-P.ydata(tk,jspec))/P.sigma^2)^2-2/P.sigma^2;
            T2 = 2*(yy(tk,P.species)-P.ydata(tk,jspec))/P.sigma^2;
            
            D2f = D2f + f*(T1*(dxdp(s,:)'*(dxdp(s,:)))-T2*squeeze(dxdpdp(s,:,:))).*exp(bsxfun(@plus,dxdp(s,:)',dxdp(s,:)));
            jspec=jspec+1;
        end
    end
    
end