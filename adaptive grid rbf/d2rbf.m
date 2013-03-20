function D = d2rbf(r,eps,dx)
%% Gaussian RBF

if numel(eps) == 1;
    eps=eps;
else 
    if size(eps,1)>size(eps,2)
        eps=eps';
    end
    eps=repmat(eps,size(r,1),1);
end

D = (4*eps.^4.*dx.^2-2*eps.^2).*exp(-(eps.*r).^2);

%% MQ

%D = eps.^2*(1+(eps.*r).^2-(eps.*dx).^2)./(1 + (eps.*r).^2).^(3/2);


end
