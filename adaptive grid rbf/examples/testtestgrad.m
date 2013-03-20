eps = 1e-3;
i = 3;

% Initialization model
data_sim.params = theta;
data_sim.params(i) = data_sim.params(i) + eps;
options = IDASetOptions('RelTol',1e-10,...
                        'AbsTol',1e-10,...
                        'VariableTypes',ones(n_y_index*(1+n_z+n_C),1),...
                        'MaxNumSteps', 10^4);

IDAInit(@(t,x,dx) MCM_res(t,x,dx,data_sim),0,x0,dx0,options);

% Simulation
[status,tx,xd] = IDASolve(t(2:end),'Normal');
cMd = [x0';xd'];

sfd = (cMd - cM)/eps;

figure;
for j = 1:length(x0)
    subplot(3,4,j);
    plot(t',sfd(:,j),'r-'); hold on;
    plot(t,squeeze(scM(j,i,:)),'b--'); hold on;
end

