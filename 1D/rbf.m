function D = rbf(r,eps)
%% Gaussian RBF

%D = exp(-(eps*r).^2);

%% MQ RBF

D = sqrt( 1 + (eps*r).^2);

end