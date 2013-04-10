function [ P ] = mcmc( P )
    %MCMC Summary of this function goes here
    %   Detailed explanation goes here
    
    % specify the sum of squares function
    model.ssfun = @(k,data) -2*log(eval_llh(k,P));
    % speficy the sigma
    model.sigma2 = 1;
    model.N = 1;
    
    % number of simulations (burn in)
    options.nsimu = 1e3;
    % flag whether to update simulations
    options.updatesigma = 0;
    % flag for waitbar
    options.waitbar = 1;
    % flag for verbosity
    options.verbosity = 0;
    
    % load parameter initialisation
    params = P.paramspec;
    
    % initial data specification
    data.y0 = P.y0;
    % time resolved data specification
    data.ydata = [P.tdata',P.ydata];
    
    % mcmc run
    [P.mcresults,P.mcchain,P.mcs2chain] = mcmcrun(model,data,params,options);
    T = chainstats(P.mcchain,P.mcresults);
    % thin samples

    % number of simulations
    options.nsimu = (10^P.pdim);
    
    nmcmc=1;
    while(any([min(T(:,5))<0.9, nmcmc==1]))
        [P.mcresults,mcchain,P.mcs2chain] = mcmcrun(model,data,params,options,P.mcresults);

        if(nmcmc>1)
            P.mcchain=[P.mcchain;mcchain];
        else
            P.mcchain=mcchain;
        end
        T = chainstats(P.mcchain,P.mcresults);
        % correlation length
        %P.tau = max(iact(P.mcchain));
        P.tau = 1; % no thinning

        nmcmc=nmcmc+1;
    end

    % save thinned chain
    P.XX = P.mcchain(1:P.tau:end,:);
    % count number of samples
    P.NX = size(P.XX,1);
    
    NV = 2^8;

    
    disp(['# Computing KDE Marginals']);
    P.marg_kde = zeros(NV,P.pdim);
    
    textprogressbar('Progress: ');
    for n = 1 : P.pdim
        textprogressbar(n/P.pdim*100)
        xx = linspace(P.paramspec{n}{3},P.paramspec{n}{4},NV);
        P.marg_kde(:,n) = kde_simple(P.XX(:,n)',xx);
    end
    textprogressbar('done');
    
    
end

