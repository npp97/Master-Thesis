clear all;
clf

DefaultSettings


P.adap_d0 = 1.5;
P.adap_D0 = 3;

P.init_d0 = 1.5;
P.init_D0 = 3;

%P.vsT = 15;

P.kernel_aniso = 2;

P.init_method = 2;
P.init_lattice = 3;
P.init_latt_d = 2.5;


P.switch_fusion_off = false;
P.kernel_aniso_method = 2;
P.init_trans = 2;
% P.adap_fusion_method = 2;
% P.pot = @(r,rstar) V3(r,rstar);
% P.dpot = @(r,rstar) dV3(r,rstar);
P.cov_iter = 1;
P.grad_iter = 1;
P.max_iter = 0;
% P.adap_dc = 1.5;

P.plotflag=true;
P.plotinter = 1;
%% 2 Implementation

%% 2.1 MCMC run

%P = mcmc(P);

%figure(4)
%mcmcplot(P.mcchain(1:10:end,:),[],{P.paramspec{1}{1}, P.paramspec{2}{1}},'hist');

%% 2.2 Initialization

P = init(P);


%% 2.4 Particle Refinement

P = refine_particles( P );

%% 2.5 Interpolation

P = interp_hermite(P);

%% 2.6 Error Estimation

P = error_estim_hermite(P);

%% 2.7 Stochastic Analysis

marginals_hermite(P);






