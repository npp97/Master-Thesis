function D = drbf(r,eps,dx)
%% Gaussian RBF

if numel(eps) == 1;
    eps=eps;
else 
    if size(eps,1)>size(eps,2)
        eps=eps';
    end
    eps=repmat(eps,size(r,1),1);
end

D = exp(-(eps.*r).^2).*(-2*(eps).^2).*dx;

%% MQ

%D = dx.*eps.^2./sqrt(1+(eps.*r).^2);


end