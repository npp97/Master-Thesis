function [f,Df] = eval_llh(p,P)
    
    if(P.withgrad)
        [~,yy] = ode15s(@(t,x) ode(t,x,exp(p)),P.tdata,[P.y0;zeros(xdim*pdim,1)]);
        f = sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma))));
        Df = zeros(1,length(p));
        for tk=1:length(P.tdata)
            dxdp = reshape(yy(tk,xdim+1:end),xdim,pdim);
            jspec = 1;
            for s=P.species
                Df = Df + 2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma*dxdp(s,:).*exp(p);
                jspec=jspec+1;
            end
        end
    else
        [~,yy] = ode15s(@(t,x) ode(t,x,exp(p)),P.tdata,[P.y0]);
        f = sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma))));
    end
end

function xdot = ode(t,x,p)
   xdim = size(dxdt(t,x,p),1);
   pdim = length(p);
   DXDP = reshape(x(xdim+1:end),xdim,pdim);
   DFDP = dxdotdp(t,x,p);
   DFDX = dxdotdx(t,x,p);
   A = DFDX*DXDP + DFDP;
   
   xdot=[
       dxdt(t,x,p);
       A(:)
       ];
end

function xdot = dxdt(~,x,p)
   xdot = [
       -p(1)*x(1) + p(2)*x(2);
       -p(2)*x(2) + p(1)*x(1)
       ];
end

function xdot = dxdotdp(~,x,~)
    xdot = [
        -x(1), x(2);
        x(1), -x(2)
        ];
end

function xdot = dxdotdx(~,~,p)
    xdot = [
        -p(1), p(2);
        p(1), -p(2)
        ];
end