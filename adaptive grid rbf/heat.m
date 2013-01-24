clear all;
clf

DefaultSettings


P.init_d0 = 0.1;
P.init_D0 = 0.3;
P.adap_d0 = 0.3;
P.adap_D0 = 1;
%P.vsT = 15;

P.kernel_aniso = 2;
% P.kernel_aniso_method = 1;
% P.init_trans = 2;
% P.adap_fusion_method = 2;
% P.pot = @(r,rstar) V3(r,rstar);
% P.dpot = @(r,rstar) dV3(r,rstar);
% P.cov_iter = 10;
% P.grad_iter = 10;
% P.adap_dc = 1.5;

P.plotflag=true;

%% 2 Implementation

%% 2.1 MCMC run

%P = mcmc(P);

%figure(4)
%mcmcplot(P.mcchain(1:10:end,:),[],{P.paramspec{1}{1}, P.paramspec{2}{1}},'hist');

%% 2.2 Initialization

P = init(P);

%% 2.4 Particle Refinement

P.inferror = Inf;

P = refine_particles( P );

%% 2.5 Interpolation

P = interp(P);

%% 2.6 Error Estimation

P = error_estim(P);

plot_points2(P,1)

P.inferror
P.l1error







