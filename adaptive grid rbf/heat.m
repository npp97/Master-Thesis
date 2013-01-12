clear all;
clf

DefaultSettings

%% 2 Implementation

%% 2.1 MCMC run

%P = mcmc(P);

%figure(4)
%mcmcplot(P.mcchain(1:10:end,:),[],{P.paramspec{1,1}, P.paramspec{2,1}},'hist');

%% 2.2 Initialization

P = init(P);

%% 2.4 Particle Refinement

P.Riter = 1;

P = refine_particles( P );

%% 2.5 Interpolation

P = interp(P);





