function [f] = eval_llh(p,P)
    %[~,yy] = ode15s(@(t,x) dxdt(t,x,exp(p),0),P.tdata,[P.y0]);
    
    inbound = true;
    for k=1:P.pdim
        if(p(k)<P.paramspec{k}{3}||p(k)>P.paramspec{k}{4})
            inbound = false;
            break
        end
    end
    
    if((1-P.logscale).*p<0)
        f = 0;
    elseif(not(inbound))
        f = 0;
    else
        if(P.model == 4)
            % pre specified likelihood
            f = exp(P.loglikelihood(p)+9.0498e5);%with added normalization
            %f = exp(P.loglikelihood(p)+1.0715941e6);
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
    
end
