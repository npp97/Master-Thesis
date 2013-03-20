
%% OPTIONS
% Moment equation
options_MM_c.moment_order = 2;
options_MM_c.moment_closure = 'low-dispersion';
% Conditional moment equation
options_cMM_c.moment_order = 2;
options_cMM_c.moment_closure = 'low-dispersion';

% Simulation
options_MM_ode = odeset('RelTol',1e-7,'AbsTol',1e-7);

% Colors
col1 = [0.0,0.0,1.0;...
        0.6,0.6,1.0;...
        0.4,0.4,1.0;...
        0.2,0.2,1.0];
col2 = [1.0,0.0,0.0;...
        1.0,0.6,0.6;...
        1.0,0.4,0.4;...
        1.0,0.2,0.2];

%% SYSTEM / SETUP
% (R1) DNA_off -> DNA_on  , tau_on*DNA_off
% (R2) DNA_on  -> DNA_off , tau_off*DNA_on
% (R3)       0 -> mRNA    , k_m*DNA_on
% (R4)    mRNA -> 0       , gamma_m*mRNA
% (R5)       0 -> Protein , k_p*mRNA
% (R6) Protein -> 0       , gamma_p*Protein

% Parameter vector
% theta = [1.0;1.0;10;1;4;1]; % MM works (and everything else)
theta = [0.05;0.05;5;1;4;1]; % reduction of transition rates by factor 20
                                    % => MM does not work but cMM (DNA)

% Initial condition
xi = 0.3;
lambdaRoff = 4;
lambdaRon  = 4;
lambdaPoff = 10;
lambdaPon  = 10;

% Time vector
t = linspace(0,5,100);

%% MODEL
% Definition of symbolic variables:
syms DNA_off DNA_on mRNA Protein;
syms tau_on tau_off k_m gamma_m k_p gamma_p tau_on_p;

% Define state vector:
system.state.variable = [ DNA_off    ;  DNA_on    ; mRNA       ; Protein ];
system.state.number   = length(system.state.variable);
system.state.type     = {'stochastic';'stochastic';'moment'    ;'moment' };
system.state.name     = {'DNA_{off}' ; 'DNA_{on}' ;'mRNA'      ;'Protein'};
system.state.xmin     = [      0     ;      0     ;    0       ;    0    ];
system.state.xmax     = [      1     ;      1     ;   40       ;  inf    ];
system.state.constraint = @(X) ((X(1)+X(2)) == 1);
% Define parameter vector:
system.parameter.variable = [ tau_on     ; tau_off     ; k_m ; gamma_m   ; k_p ; gamma_p   ];
system.parameter.name     = {'\\tau_{on}';'\\tau_{off}';'k_m';'\\gamma_m';'k_p';'\\gamma_p'};
% Define propensities:
% (R1)
system.reaction(1).educt      = DNA_off;
system.reaction(1).product    = DNA_on;
system.reaction(1).propensity = tau_on*DNA_off;
system.reaction(1).parameter  = tau_on;
% (R2)
system.reaction(2).educt      = DNA_on;
system.reaction(2).product    = DNA_off;
system.reaction(2).propensity = tau_off*DNA_on;
system.reaction(2).parameter  = tau_off;
% (R3)
system.reaction(3).educt      = DNA_on;
system.reaction(3).product    = [mRNA,DNA_on];
system.reaction(3).propensity = k_m*DNA_on;
system.reaction(3).parameter  = k_m;
% (R4)
system.reaction(4).educt      = mRNA;
system.reaction(4).product    = [];
system.reaction(4).propensity = gamma_m*mRNA;
system.reaction(4).parameter  = gamma_m;
% (R5)
system.reaction(5).educt      = mRNA;
system.reaction(5).product    = [Protein,mRNA];
system.reaction(5).propensity = k_p*mRNA;
system.reaction(5).parameter  = k_p;
% (R6)
system.reaction(6).educt      = Protein;
system.reaction(6).product    = [];
system.reaction(6).propensity = gamma_p*Protein;
system.reaction(6).parameter  = gamma_p;

%% SIMULATION OF FSP
% Construction
system = completeSystem(system);
xmin_FSP = [0;0; 0; 0];
xmax_FSP = [1;1;20;60];
[system] = getFSP(system,xmin_FSP,xmax_FSP);

% Initial condition
model.p0 = zeros(size(system.index,1),1);
for ix = 1:size(system.index,1)
    if system.index(ix,1) == 0
        model.p0(ix) =     xi*poisspdf(system.index(ix,3),lambdaRoff)*poisspdf(system.index(ix,4),lambdaPoff);
    else
        model.p0(ix) = (1-xi)*poisspdf(system.index(ix,3),lambdaRon )*poisspdf(system.index(ix,4),lambdaPon );
    end
end

% Simulation
system.p0 = model.p0;
model.index = system.index;
model.species = system.state.name;
model.A = system.A(theta);
options_ode45 = odeset('RelTol',1e-7,'AbsTol',1e-7);
[simu] = simulateFSP(model,t,options_ode45);

%% PLOT SIMULATION RESULT
options.species = system.state.name;
[fig1] = plotFSP(simu,t,system.index,1,options);
[fig2] = plotFSP(simu,t,system.index,2,options);
[fig3] = plotFSP(simu,t,system.index,3,options);
[fig4] = plotFSP(simu,t,system.index,4,options);

% %% GENERATE MEASUREMENT DATA
% t_meas = 0:1:10;
% options.Nt = 2000;
% 
% measurement = getInsilicoFACSExpFSP(model,t_meas,{'Protein'},options);
% histogram = getHistogramFACSwithNoise(measurement,measurement.index);

%% LOAD DATA
load example2_FACSFSP
histogram = getHistogramFACSwithNoise(measurement,measurement.index);

%% RUN MULTI-START OPTIMIZATION
% Initialization of parameter struct
parameters.number = length(theta);
parameters.guess  = log(theta);
parameters.min    = log(0.01*theta);
parameters.max    = log(100 *theta);
parameters.name   = system.parameter.name;

% Multi-start optimization
options.fmincon = optimset('algorithm','interior-point',...
                           'display','iter',...
                           'GradObj','on',...
                           'MaxIter',3000,...
                           'MaxFunEvals',3000*parameters.number);
options.logPost_options.scale = 'log';
options.n_starts = 3;
% [parameters,fh_MS] = optimizeMultiStart(parameters,...
%     @(xi,op) logLikelihood_FACS_FSP(exp(xi),system,histogram,op),options);
% 
% save MS_result_example2_FACSFSP_4


%% PROFILE LIKELIHOOD ANALYSIS
options.parameter_index = 5:6;
% [parameters,fh] = computeProfiles(parameters,...
%     @(xi,op) logLikelihood_FACS_FSP(exp(xi),system,histogram,op),options);
% 
% save PL_result_example2_FACSFSP_4

%%
% figure(8); hold on;
% subplot(2,2,3:4);
% plot(1:parameters.number,log(theta),'r--o','linewidth',2);
% 
% %% SIMULATION OF MOMENT EQUATION
% % Generation of moments equation
% MM_centered = getMM_centered(system,options_MM_c);
% % Computation of moments (for initial condition)
% [M_FSP] = getMomentsFSP_centered(P,system.index,options_MM_c.moment_order);
% % Simulation
% [~,M] = ode15s(@(t,x) MM_centered.fun.derivative(t,x,theta),t,M_FSP(1,:)',options_MM_ode);
% 
% % Visualization
% figure;
% % DNA state
% subplot(1,3,1);
% plot(t,M_FSP(:,1),'-','linewidth',1.5,'color',col1(1,:)); hold on;
% plot(t,M(:,1),'.','linewidth',1.5,'color',col2(1,:)); hold on;
% plot(t,M_FSP(:,2),'-','linewidth',1.5,'color',col1(2,:)); hold on;
% plot(t,M(:,2),'.','linewidth',1.5,'color',col2(2,:)); hold on;
% xlabel('time');
% ylabel('probability');
% legend('DNA_{off} (FSP)','DNA_{off} (MM)','DNA_{on} (FSP)','DNA_{on} (MM)');
% 
% % mRNA number
% subplot(1,3,2);
% if options_MM_c.moment_order >= 2
%     fill(t([1:end,end:-1:1]),[M_FSP(:,3)-sqrt(M_FSP(:,12));...
%                               M_FSP(end:-1:1,3)+sqrt(M_FSP(end:-1:1,12))],...
%          col1(2,:)); hold on;
%     plot(t,M(:,3)-sqrt(M(:,12)),'.','linewidth',1.5,'color',col2(2,:)); hold on;
%     plot(t,M(:,3)+sqrt(M(:,12)),'.','linewidth',1.5,'color',col2(2,:)); hold on;
% end
% plot(t,M_FSP(:,3),'-','linewidth',1.5,'color',col1(1,:)); hold on;
% plot(t,M(:,3),'.','linewidth',1.5,'color',col2(1,:)); hold on;
% xlim([min(t),max(t)]);
% xlabel('time');
% ylabel('mRNA number');
% 
% % Protein number
% subplot(1,3,3);
% if options_MM_c.moment_order >= 2
%     fill(t([1:end,end:-1:1]),[M_FSP(:,4)-sqrt(M_FSP(:,14));...
%                               M_FSP(end:-1:1,4)+sqrt(M_FSP(end:-1:1,14))],...
%          col1(2,:)); hold on;
%     plot(t,M(:,4)-sqrt(M(:,14)),'.','linewidth',1.5,'color',col2(2,:)); hold on;
%     plot(t,M(:,4)+sqrt(M(:,14)),'.','linewidth',1.5,'color',col2(2,:)); hold on;
% end
% plot(t,M_FSP(:,4),'-','linewidth',1.5,'color',col1(1,:)); hold on;
% plot(t,M(:,4),'.','linewidth',1.5,'color',col2(1,:)); hold on;
% xlim([min(t),max(t)]);
% xlabel('time');
% ylabel('Protein number');
% 
% %% SIMULATION OF CONDITIONAL MOMENT EQUATION
% % Construct of cMFSP
% [cMFSP] = getcMM_centered(system,xmin_FSP,xmax_FSP,[],options_cMM_c);
% 
% % Determine dimension
% n_y_index = size(cMFSP.state.stochatic.FSP_index,1);
% n_z = length(cMFSP.state.expectation.state_index);
% n_C = size(cMFSP.state.expectation.C_index,1);
% 
% % Compute conditional moments from FSP simulation
% [p_FSP,cmu_FSP,cC_FSP] = getMofFSPsol(P',system.index,...
%     cMFSP.state.stochatic.state_index,...
%     cMFSP.state.stochatic.FSP_index,...
%     cMFSP.state.expectation.state_index,...
%     cMFSP.state.expectation.C_index,'central');
% 
% % Construct initial conditions
% cM0 = [];
% for iy = 1:size(p_FSP,2)
%     cM0 = [cM0;p_FSP{iy}(1)];
% end
% for iy = 1:size(p_FSP,2)
%     if options_cMM_c.moment_order >= 2
%         cM0 = [cM0;cmu_FSP{iy}(1,:)';cC_FSP{iy}(1,:)'];
%     elseif options_cMM_c.moment_order == 1
%         cM0 = [cM0;cmu_FSP{iy}(1,:)'];
%     else
%         cM0 = [cM0];
%     end
% end
% 
% % Construct consistent initial condition
% x0 = cM0;
% dx0 = cMFSP.derivatives.fun.VF(0,cM0,theta)./diag(full(cMFSP.derivatives.fun.mass_matrix(0,cM0,theta)));
% 
% % Set solver options
% options = IDASetOptions('RelTol',1e-10,...
%                         'AbsTol',1e-10,...
%                         'VariableTypes',ones(n_y_index*(1+n_z+n_C),1),...
%                         'suppressAlgVars','on',...
%                         'MaxNumSteps', 10^4,...
%                         'LinearSolver','Dense');
% 
% % Initiallize IDAS and solve ODE
% IDAInit(@(t,x,dx) cMM_res(t,x,dx,theta),0,x0,dx0,options);
% [status,ty,y] = IDASolve(t(2:end),'Normal');
% cM = [x0';y'];
% 
% % Free memory
% IDAFree;
% 
% % Reorder result
% for iy = 1:n_y_index
%     p_cMM{iy}   = cM(:,iy);
%     cmu_cMM{iy} = cM(:,(n_z+n_C)*(iy-1)+n_y_index    +[1:n_z]);
%     cC_cMM{iy}  = cM(:,(n_z+n_C)*(iy-1)+n_y_index+n_z+[1:n_C]);
% end
% 
% disp('simulation finished!')
% 
% % %% Sum over substates
% % p_cMM_off = 0;
% % p_cMM_on  = 0;
% % cmu_R_cMM_off = 0;
% % cmu_R_cMM_on  = 0;
% % cmu_P_cMM_off = 0;
% % cmu_P_cMM_on  = 0;
% % cmu_RR_cMM_off = 0;
% % cmu_RR_cMM_on  = 0;
% % cmu_PP_cMM_off = 0;
% % cmu_PP_cMM_on  = 0;
% % 
% % % Marginal probabilities and conditional means
% % for iy = 1:n_y_index
% %     if cMFSP.state.stochatic.FSP_index(iy,1) == 1
% %         p_cMM_off = p_cMM_off + p_cMM{iy};
% %         cmu_R_cMM_off = cmu_R_cMM_off + p_cMM{iy}*cMFSP.state.stochatic.FSP_index(iy,3);
% %         cmu_P_cMM_off = cmu_P_cMM_off + p_cMM{iy}.*cmu_cMM{iy};
% %         cmu_RR_cMM_off = cmu_RR_cMM_off + p_cMM{iy}.*cMFSP.state.stochatic.FSP_index(iy,3)^2;
% %     else
% %         p_cMM_on = p_cMM_on + p_cMM{iy};
% %         cmu_R_cMM_on = cmu_R_cMM_on + p_cMM{iy}*cMFSP.state.stochatic.FSP_index(iy,3);
% %         cmu_P_cMM_on = cmu_P_cMM_on + p_cMM{iy}.*cmu_cMM{iy};
% %         cmu_RR_cMM_on = cmu_RR_cMM_on + p_cMM{iy}.*cMFSP.state.stochatic.FSP_index(iy,3)^2;
% %     end
% % end
% % cmu_R_cMM_off = cmu_R_cMM_off./p_cMM_off;
% % cmu_R_cMM_on  = cmu_R_cMM_on ./p_cMM_on ;
% % cmu_P_cMM_off = cmu_P_cMM_off./p_cMM_off;
% % cmu_P_cMM_on  = cmu_P_cMM_on ./p_cMM_on ;
% % cmu_RR_cMM_off = cmu_RR_cMM_off./p_cMM_off - cmu_R_cMM_off.^2;
% % cmu_RR_cMM_on  = cmu_RR_cMM_on ./p_cMM_on  - cmu_R_cMM_on.^2;
% 
% % % Covariance
% % if n_C >= 1
% %     for iy = 1:n_y_index
% %         if cMFSP.state.stochatic.FSP_index(iy,1) == 1
% %             cmu_PP_cMM_off = cmu_PP_cMM_off + p_cMM{iy}.*(...
% %                                  + 1*(cmu_cMM{iy}-cmu_R_cMM_off).^2 * 1 ...
% %                                  + 2*(cmu_cMM{iy}-cmu_R_cMM_off).^1 * 0 ...
% %                                  + 1*(cmu_cMM{iy}-cmu_R_cMM_off).^0 * cC_cMM{iy});
% %         else
% %             %cmu_PP_cMM_on = cmu_PP_cMM_on + p_cMM{iy}.*(cMFSP.state.stochatic.FSP_index(iy,3)-cmu_R_cMM_on).^2;
% %         end
% %     end
% %     cmu_PP_cMM_off = cmu_PP_cMM_off./p_cMM_off;
% %     cmu_PP_cMM_on  = cmu_PP_cMM_on ./p_cMM_on;
% % end
% 
% 
% 
% % Plot
% figure;
% for iy = 1:n_y_index
%     % State probability
%     subplot(n_y_index,n_z+1,(n_z+1)*(iy-1)+1);
%     hl(1) = plot(t,p_FSP{iy},'-','linewidth',1.5,'color',col1(1,:)); hold on;
%     hl(2) = plot(t,p_cMM{iy},'.','linewidth',1.5,'color',col2(1,:));
%     axis([min(t),max(t),0,1]);
%     xlabel('time');
%     ylabel('probability');
%     legend(hl,{'FSP','cMM'});
% 
%     % Moments
%     for iz = 1:n_z
%         % Open subplot
%         subplot(n_y_index,n_z+1,(n_z+1)*(iy-1)+1+iz);
%         % Determine index
%         ind = getRowInMat(cMFSP.state.expectation.C_index,...
%             [zeros(1,size(cMFSP.state.expectation.C_index,2)-2),iz*ones(1,2)]);
%         if ~isempty(ind)
%             fill(t([1:end,end:-1:1]),[cmu_FSP{iy}(:,iz)-sqrt(cC_FSP{iy}(:,ind));...
%                                       cmu_FSP{iy}(end:-1:1,iz)+sqrt(cC_FSP{iy}(end:-1:1,ind))],...
%                  col1(2,:)); hold on;
%             plot(t,cmu_cMM{iy}(:,iz)-sqrt(cC_cMM{iy}(:,ind)),'.','linewidth',1.5,'color',col2(2,:)); hold on;
%             plot(t,cmu_cMM{iy}(:,iz)+sqrt(cC_cMM{iy}(:,ind)),'.','linewidth',1.5,'color',col2(2,:)); hold on;
%         end
%         plot(t,cmu_FSP{iy}(:,iz),'-','linewidth',1.5,'color',col1(1,:)); hold on;
%         plot(t,cmu_cMM{iy}(:,iz),'.','linewidth',1.5,'color',col2(1,:)); hold on;
%         xlim([min(t),max(t)]);
%         xlabel('time');
%         ylabel('molecule number');
%     end
% end

