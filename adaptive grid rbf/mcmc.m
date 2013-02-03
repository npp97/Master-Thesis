function [ P ] = mcmc( P )
    %MCMC Summary of this function goes here
    %   Detailed explanation goes here
    
    % specify the sum of squares function
    model.ssfun = @(k,data) -2*log(eval_llh(k,P));
    % speficy the sigma
    model.sigma2 = P.sigma;
    
    % number of simulations
    options.nsimu = 50000;
    % flag whether to update simulations
    options.updatesigma = 0;
    
    % load parameter initialisation
    params = P.paramspec;
    
    % initial date specification
    data.y0 = P.y0;
    % time resolved data specification
    data.ydata = [P.tdata',P.ydata];
    
    % mcmc run
    [P.mcresults,P.mcchain,P.mcs2chain] = mcmcrun(model,data,params,options);
    
    % autocorrelation length
    P.tau = max(iact(P.mcchain));
    % thin samples
    P.XX = P.mcchain(1:P.tau:end,:);
    P.NX = size(P.XX,1);
    
end

