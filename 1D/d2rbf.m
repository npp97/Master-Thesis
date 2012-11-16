function D = d2rbf(r,eps)
%% Gaussian RBF

%D = 2*exp(-(eps.*r).^2).*(2*eps^4*r.^2 - eps^2);

%% MQ RBF

D = eps^2./((1+(eps*r).^2).^3/2);

end