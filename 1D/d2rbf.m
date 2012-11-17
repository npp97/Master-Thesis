function D = d2rbf(r,eps)
%% Gaussian RBF

if size(eps,1) == 1;
    eps=repmat(eps,size(r,1),size(r,2));
else 
    eps=repmat(eps,1,size(r,2));
end

D = exp(-(eps.*r).^2).*(4*eps.^4.*r.^2 - 2*eps.^2);

%% MQ RBF

%D = (r.^2+2*eps^2)./(((1+(eps.*r).^2).^(3/2)));

end