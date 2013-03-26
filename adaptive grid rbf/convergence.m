clear all
DefaultSettings

P.adap_d0 = 1;
P.adap_D0 = 4;

P.init_d0 = 1;
P.init_D0 = 4;

%P.vsT = 15;

P.kernel_aniso = 2;

P.init_method = 2;
P.init_lattice = 2;
P.init_latt_d = 0.5;

P.switch_fusion_off = true;
P.kernel_aniso_method = 2;
P.init_trans = 2;
% P.adap_fusion_method = 2;
% P.pot = @(r,rstar) V3(r,rstar);
% P.dpot = @(r,rstar) dV3(r,rstar);
P.cov_iter = 151;
P.grad_iter = 1;
P.max_iter = 50;
% P.adap_dc = 1.5;

P.plotflag=false;
P.plotinter = 1;
%% 2 Implementation

%% 2.1 Initialization

P = init(P);

ND = 50;

densvec = logspace(-0.5,0.5,ND);

textprogressbar('Progress: ');
for j = 1 : P.NX
    textprogressbar(j/P.NX*100)
    [P.Ftrue(j,1)] = eval_llh(P.XX(j,:),P);
end
textprogressbar('done');

NV = 2^8;

kdedens = zeros(NV,P.pdim);

for n = 1 : P.pdim
    [~,kdedens(:,n),kdexx]=kde(P.XX(:,n),NV,P.paramspec{n}{3},P.paramspec{n}{4});
end

clear vP
for k = 1:ND
    
    Ps = P;
    
    Ps.init_latt_d = densvec(k);
    
    Ps = regenerate_lattice( Ps ); 
    
    %% 2.2 Particle Refinement
    
    %P = refine_particles( P );
    
    %% 2.3 Post Process
    
    %Ps = postprocess(Ps);
    
    %% 2.5 Interpolation
    
    Ps = interp(Ps);
    
    %% 2.6 Error Estimation
    
    Ps = error_estim(Ps);
    
    %% 2.7 Stochastic Analysis
    
    Ps = marginals(Ps);
    
    %% 2.5 Interpolation
    
    Ps = interp_mls(Ps);
    
    %% 2.6 Error Estimation
    
    Ps = error_estim_mls(Ps);
    
    %% 2.7 Stochastic Analysis
    
    Ps = marginals_mls(Ps);
    
    vP{k} = Ps;
end



clear vP_adap
for k = 1:ND
    
    Ps = vP{k};
    Ps.max_iter = 100;
    
    Ps.adap_d0 = 2*Ps.init_latt_d;
    Ps.adap_D0 = 4*Ps.init_latt_d;
    
    Ps.init_d0 = 2*Ps.init_latt_d;
    Ps.init_D0 = 4*Ps.init_latt_d;
    
    Ps.d0 = Ps.init_d0;
    Ps.D0 = Ps.init_D0;
    
    %% 2.2 Particle Refinement
    
    Ps = refine_particles( Ps );
    
    %% 2.3 Post Process
    
    %Ps = postprocess(Ps);
    
    %% 2.5 Interpolation
    
    Ps = interp(Ps);
    
    %% 2.6 Error Estimation
    
    Ps = error_estim(Ps);
    
    %% 2.7 Stochastic Analysis
    
    Ps = marginals(Ps);
    
    %% 2.5 Interpolation
    
    Ps = interp_mls(Ps);
    
    %% 2.6 Error Estimation
    
    Ps = error_estim_mls(Ps);
    
    %% 2.7 Stochastic Analysis
    
    Ps = marginals_mls(Ps);
    
    vP_adap{k} = Ps;
end

NN = cellfun(@(x) x.N, vP);
NN_adap = cellfun(@(x) x.N, vP_adap);

for k = 1 : ND
    kded = zeros(NV,P.pdim);
    
    for n = 1 : P.pdim
        [~,kded(:,n),kdexx]=kde(P.XX(1:NN(k),n),NV,P.paramspec{n}{3},P.paramspec{n}{4});
    end
    vKDE{k} = kded;
end

ref = vP{1}.marg_rbf';
Ndens = numel(vP{1}.marg_rbf);


clear l1rbf linfrbf l1rbf_adap linfrbf_adap l1mls linfmls l1mls_adap linfmls_adap l1kde linfkde

l1rbf = cellfun(@(x) 1/Ndens*norm(x.marg_rbf' - ref,1),vP);
linfrbf = cellfun(@(x) 1*norm(x.marg_rbf' - ref,inf),vP);

l1rbf_adap = cellfun(@(x) 1/Ndens*norm(x.marg_rbf' - ref,1),vP_adap);
linfrbf_adap = cellfun(@(x) 1*norm(x.marg_rbf' - ref,inf),vP_adap);

l1mls = cellfun(@(x) 1/Ndens*norm(x.marg_mls' - ref,1),vP);
linfmls = cellfun(@(x) 1*norm(x.marg_mls' - ref,inf),vP);

l1mls_adap = cellfun(@(x) 1/Ndens*norm(x.marg_mls' - ref,1),vP_adap);
linfmls_adap = cellfun(@(x) 1*norm(x.marg_mls' - ref,inf),vP_adap);

l1kde = cellfun(@(x) 1/Ndens*norm(x - ref,1),vKDE);
linfkde = cellfun(@(x) 1*norm(x - ref,inf),vKDE);


figure(6)
clf

loglog(NN,l1rbf,'r--')
hold on
loglog(NN,linfrbf,'r.-')

loglog(NN,l1mls,'b--')
loglog(NN,linfmls,'b.-')

loglog(NN,l1kde,'k--')
loglog(NN,linfkde,'k.-')

loglog(NN_adap,l1rbf_adap,'m--')
loglog(NN_adap,linfrbf_adap,'m.-')

loglog(NN_adap,l1mls_adap,'c--')
loglog(NN_adap,linfrbf_adap,'c.-')

legend('avg. l_1 error RBF','l_{inf} error RBF','avg. l_1 error MLS','l_{inf} error MLS','avg. l_1 error KDE','l_{inf} error KDE','avg. l_1 error RBF adaptive','avg. l_{inf} error RBF adaptive','avg. l_1 error MLS adaptive','avg. l_{inf} error MLS adaptive')
