function D = ddrbf(r,eps,dx,dy)
%% Gaussian RBF

if numel(eps) == 1;
    eps=eps;
else 
    if size(eps,1)>size(eps,2)
        eps=eps';
    end
    eps=repmat(eps,size(r,1),1);
end

D = exp(-(eps.*r).^2).*(4*eps.^4.*dx.*dy-4*eps.^2);

%% MQ

%D = -eps.^4.*dx.*dy./(1+(eps.*r).^2).^(3/2);


end
