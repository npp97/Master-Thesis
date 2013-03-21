clear all;
clf

DefaultSettings

P.adap_d0 = 1;
P.adap_D0 = 4;

P.init_d0 = 1;
P.init_D0 = 4;

%P.vsT = 15;

P.kernel_aniso = 2;

P.init_method = 2;
P.init_lattice = 2;
P.init_latt_d = 1;

P.switch_fusion_off = true;
P.kernel_aniso_method = 2;
P.init_trans = 2;
% P.adap_fusion_method = 2;
% P.pot = @(r,rstar) V3(r,rstar);
% P.dpot = @(r,rstar) dV3(r,rstar);
P.cov_iter = 151;
P.grad_iter = 1;
P.max_iter = 150;
% P.adap_dc = 1.5;

P.plotflag=true;
P.plotinter = 1;
%% 2 Implementation

%% 2.1 Initialization

P = init(P);

%% 2.2 Particle Refinement

P = refine_particles( P );

%% 2.3 Post Process

P = postprocess(P);

%% 2.5 Interpolation

P = interp(P);

%% 2.6 Error Estimation

P = error_estim(P);

%% 2.7 Stochastic Analysis

marginals(P);

P = interp_mls(P);

P = error_estim_mls(P);

marginals_mls(P);







