function D = rbf(r,eps)
%% Gaussian RBF

if size(eps,1) == 1;
    eps=repmat(eps,size(r,1),size(r,2));
else 
    eps=repmat(eps,1,size(r,2));
end

D = exp(-(eps.*r).^2);

%% MQ RBF

%D = sqrt( 1 + (eps*r).^2);

end