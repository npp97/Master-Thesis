function [f,Df,D2f] = eval_llh(p,P)
    xdim = size(dxdt(0,P.y0,P.Xp(1,:)),1);
    pdim = size(P.Xp,2);
    switch(P.difforder)
        case 0
            [~,yy] = ode15s(@(t,x) dxdt(t,x,exp(p)),P.tdata,[P.y0]);
            %f = sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))); logarithmic version
            f = prod(prod(normpdf(yy(:,P.species),P.ydata,P.sigma)));
            
        case 1
            [~,yy] = ode15s(@(t,x) dxdp(t,x,exp(p)),P.tdata,[P.y0;zeros(xdim*pdim,1)]);
            %f = sum(sum(log(normpdf(yy(:,P.species),P.ydata,P.sigma)))); logarithmic version
            f = prod(prod(normpdf(yy(:,P.species),P.ydata,P.sigma)));
            Df = zeros(1,length(p));
            for tk=1:length(P.tdata)
                dxdp = reshape(yy(tk,xdim+1:end),xdim,pdim);
                jspec = 1;
                for s=P.species
                    %Df = Df + 2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma^2*dxdp(s,:).*exp(p); logarithmic version
                    Df = f*2*(P.ydata(tk,jspec)-yy(tk,P.species))/P.sigma^2*dxdp(s,:).*exp(p);
                    jspec=jspec+1;
                end
            end
            
        case 2
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
end

function xdot = dxdpdp(t,x,p)
   xdim = size(dxdt(t,x,p),1);
   pdim = length(p);    
   DFDX = dxdotdx(t,x,p);
   DXDP = reshape(x(xdim+1:xdim+xdim*pdim),xdim,pdim);
   DFDPDP = dxdotdpdp(t,x,p);
   DFDPDX = dxdotdpdx(t,x,p);
   DFDXDP = dxdotdxdp(t,x,p);
   DFDXDX = dxdotdxdx(t,x,p);
   DXDPDP = reshape(x(xdim+xdim*pdim+1:end),xdim,pdim,pdim);
   
   
   
   %B1 = DFDPDX*DXDP;
   B1=zeros(xdim,pdim,pdim);
   for j = 1:xdim
       B1(j,:,:) = squeeze(DFDPDX(j,:,:))*DXDP;
   end
   
   %B2 = DFDXDP*DXDP;
   B2=zeros(xdim,pdim,pdim);
   for j = 1:xdim
       B2(j,:,:) = squeeze(DFDXDP(j,:,:))*DXDP;
   end
   
   %B3 = DFDXDX*DXDP*DXDP;
   B3=zeros(xdim,pdim,pdim);
   for j = 1:xdim
       for k=1:pdim
           for l=1:pdim
               B3(j,k,l) = (DXDP(:,k)')*squeeze(DFDXDX(j,:,:))*(DXDP(:,l));
           end
       end
   end
   
   %B4 = DFDX*DXDPDP;
   B4=zeros(xdim,pdim,xdim);
   for j = 1:xdim
       for k = 1:xdim
           B4(j,:,:) = B4(j,:,:) + DFDX(j,k)*DXDPDP(k,:,:);
       end
   end
   
   B = DFDPDP + B1 + B2 + B3 + B4;
    
    xdot = [
        dxdp(t,x(1:xdim+xdim*pdim),p);
        B(:)
        ];
    
end

function xdot = dxdp(t,x,p)
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

function xdot = dxdt(t,x,p)
   xdot = [
       -p(1)*x(1) + p(2)*x(2);
       -p(2)*x(2) + p(1)*x(1)
       ];
end

function xdot = dxdotdp(t,x,p)
    xdot = [
        -x(1), x(2);
        x(1), -x(2)
        ];
end

function xdot = dxdotdx(t,x,p)
    xdot = [
        -p(1), p(2);
        p(1), -p(2)
        ];
end

function xdot = dxdotdpdp(t,x,p)
    xdot(1,:,:) = [
        0, 0;
        0, 0
        ];
    xdot(2,:,:) = [
        0, 0;
        0, 0
        ];
end

function xdot = dxdotdxdp(t,x,p)
    %(df,dx,dp)
    xdot(1,:,:) = [
        -1, 0;
        0, 1
        ];
    xdot(2,:,:) = [
        1, 0;
        0, -1
        ];
end

function xdot = dxdotdpdx(t,x,p)
    %(df,dx,dp)
    xdot(1,:,:) = [
        -1, 0;
        0, 1
        ];
    xdot(2,:,:) = [
        1, 0;
        0, -1
        ];
end

function xdot = dxdotdxdx(t,x,p)
    xdot(1,:,:) = [
        0, 0;
        0, 0
        ];
    xdot(2,:,:) = [
        0, 0;
        0, 0
        ];
end