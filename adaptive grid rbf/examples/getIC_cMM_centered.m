function M0 = getIC_cMM_centered(cMFSP,p0,index,options)

% Determine dimension
n_y_index = size(cMFSP.state.stochatic.FSP_index,1);
n_z = length(cMFSP.state.expectation.state_index);
n_C = size(cMFSP.state.expectation.C_index,1);

% Compute conditional moments from FSP simulation
[p_FSP,cmu_FSP,cC_FSP] = getMofFSPsol(P',system.index,...
    cMFSP.state.stochatic.state_index,...
    cMFSP.state.stochatic.FSP_index,...
    cMFSP.state.expectation.state_index,...
    cMFSP.state.expectation.C_index,'central');

% Construct initial conditions
cM0 = [];
for iy = 1:n_y_index
    cM0 = [cM0;p_FSP{iy}(1)];
end
for iy = 1:n_y_index
    if options.moment_order >= 2
        cM0 = [cM0;cmu_FSP{iy}(1,:)';cC_FSP{iy}(1,:)'];
    elseif options_cMM_c.moment_order == 1
        cM0 = [cM0;cmu_FSP{iy}(1,:)'];
    else
        cM0 = [cM0];
    end
end

% Initialize conditional moment for nodes which have an ajacent node
% with non-zero probability




