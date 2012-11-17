function D = drbf(r,eps,dx)
%% Gaussian RBF

if size(eps,1) == 1;
    eps=repmat(eps,size(r,1),size(r,2));
else 
    if size(eps,1)>size(eps,2)
        eps=eps';
    end
    eps=repmat(eps,size(r,1),1);
end

D = bsxfun(@times,exp(-(eps.*r).^2).*(-2*(eps).^2),dx);

%% MQ RBF

%D = bsxfun(@times,eps^2./(2*sqrt(1+(eps*r).^2)),dx);

end