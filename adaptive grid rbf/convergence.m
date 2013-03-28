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

ND = 40;
NI = 100;

densvec = logspace(-0.5,1,ND);


% 
% textprogressbar('Progress: ');
% for j = 1 : P.NX
%     textprogressbar(j/P.NX*100)
%     [P.Ftrue(j,1)] = eval_llh(P.XX(j,:),P);
% end
% textprogressbar('done');

NV = 2^8;

kdedens = zeros(NV,P.pdim);

for n = 1 : P.pdim
    xx = linspace(P.paramspec{n}{3},P.paramspec{n}{4},NV);
    kdedens(:,n) = kde_simple(P.XX(:,n)',xx);
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
    
    Ps = interp_mls(Ps);
    
    %% 2.7 Marginal
    
    NV = 256;
    Ps.marg_mls = zeros(Ps.pdim,NV);
    SIGMA=Ps.M*Ps.M;
    
    for j = 1 : P.pdim
        xx = linspace(Ps.paramspec{j}{3},Ps.paramspec{j}{4},NV)';
        % distances
        rr = sqrt(sqdistance(xx',Ps.Xp(:,j)'));
        % sigma
        sigma = sqrt(SIGMA(j,j));
        Ps.marg_mls(j,:) = 1/(sigma/Ps.eps.*sqrt(pi)).*rbf(rr,Ps.eps/sigma)*Ps.c/abs(sum(Ps.c));
    end
        
    
    vP{k} = Ps;
end



clear vP_adap
for k = 21
    Ps = vP{k};
        
    Ps.adap_d0 = Ps.init_latt_d;
    Ps.adap_D0 = 4*Ps.init_latt_d;
    
    Ps.init_d0 = Ps.init_latt_d;
    Ps.init_D0 = 4*Ps.init_latt_d;
    
    Ps.d0 = Ps.init_d0;
    Ps.D0 = Ps.init_D0;
    
    for l = 1:NI

        %% 2.2 Particle Refinement
        
        Ps.max_iter = (l-1);
        
        Ps = refine_particles( Ps );
        
        %% 2.5 Interpolation
        
        Ps = interp(Ps);
        
        %% 2.7 Stochastic Analysis
        
        NV = 256;
        Ps.marg_mls = zeros(Ps.pdim,NV);
        SIGMA=Ps.M*Ps.M;
        
        for j = 1 : Ps.pdim
            xx = linspace(Ps.paramspec{j}{3},Ps.paramspec{j}{4},NV)';
            % distances
            rr = sqrt(sqdistance(xx',Ps.Xp(:,j)'));
            % sigma
            sigma = sqrt(SIGMA(j,j));
            Ps.marg_rbf(j,:) = 1/(sigma/Ps.eps.*sqrt(pi)).*rbf(rr,Ps.eps/sigma)*Ps.c/abs(sum(Ps.c));
        end
        
        %% 2.5 Interpolation
        
        vP_adap{l} = Ps;
        
    end
end

NN = cellfun(@(x) x.feval_latt, vP);
NN_adap = cellfun(@(x) x.feval_adap, vP_adap);


NK = 50;

NN_kde = logspace(log(min(min(NN)))/log(10),log(max(max(NN_adap)))/log(10),NK);

for k = 21
    for l = 1:NK
        kded = zeros(NV,P.pdim);
        
        for n = 1 : P.pdim
            xx = linspace(P.paramspec{n}{3},P.paramspec{n}{4},NV);
            kded(:,n) = kde_simple(P.XX(1:ceil(NN_kde(l)),n)',xx);
        end
        vKDE{l} = kded;
    end
end

ref = kdedens;
Ndens = numel(ref);


clear l1rbf linfrbf l1rbf_adap linfrbf_adap l1mls linfmls l1mls_adap linfmls_adap l1kde linfkde

l1rbf_adap = cellfun(@(x) 1/Ndens*norm(x.marg_rbf' - ref,1),vP_adap);
linfrbf_adap = cellfun(@(x) 1*norm(x.marg_rbf' - ref,inf),vP_adap);

l1mls = cellfun(@(x) 1/Ndens*norm(x.marg_mls' - ref,1),vP);
linfmls = cellfun(@(x) 1*norm(x.marg_mls' - ref,inf),vP);

l1kde = cellfun(@(x) 1/Ndens*norm(x - ref,1),vKDE);
linfkde = cellfun(@(x) 1*norm(x - ref,inf),vKDE);


figure(6)
clf

loglog(NN,l1mls,'b.-','LineWidth',5)

hold on

loglog(NN_adap,l1rbf_adap(1,:),'r.-','LineWidth',5)

loglog(NN_kde*1/(1-P.mcresults.rejected),l1kde(1,:),'k.-','LineWidth',5)

% for l = [10 20]
%     loglog(NN_adap(l,:),l1rbf_adap(l,:),'r--')
% end
% 
% for l = [10 20]
%     loglog(NN_adap(l,:),l1kde(l,:),'k--')
% end

legend('avg. l_1 error MLS','avg. l_1 error RBF','avg. l_1 error KDE')
xlabel('Function Evaluations')
ylabel('Error')
xlim([min([NN,NN_adap,NN_kde]),max([NN,NN_adap,NN_kde])])
ylim([min([l1mls,l1rbf_adap,l1kde]),max([l1mls,l1rbf_adap,l1kde])])