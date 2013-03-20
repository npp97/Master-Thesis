function system = completeSystem(system)

%% STOICHIOMETRY
% Loop: reactions
for k = 1:length(system.reaction)
    % Educt
    Se = zeros(length(system.state.variable),1);
    for j = 1:length(system.reaction(k).educt)
        ind = find(system.state.variable == system.reaction(k).educt(j));
        Se(ind) = Se(ind) + 1;
    end

    % Product
    Sp = zeros(length(system.state.variable),1);
    for j = 1:length(system.reaction(k).product)
        ind = find(system.state.variable == system.reaction(k).product(j));
        Sp(ind) = Sp(ind) + 1;
    end

    % Stoichiometry
    system.reaction(k).stoichiometry = Sp-Se;
    
end
