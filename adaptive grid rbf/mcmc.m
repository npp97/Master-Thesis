function [ P ] = mcmc( P )
    %MCMC Summary of this function goes here
    %   Detailed explanation goes here
    
    model.ssfun = @(k,data) eval_llh(k,P);
    model.sigma2 = P.sigma;
    
    options.nsimu = 10000;
    options.updatesigma = 0;
    
    params = P.paramspec;
    
    data.y0 = P.y0;
    data.ydata = [P.tdata';P.ydata];
    
    [P.mcresults,P.mcchain,P.mcs2chain] = mcmcrun(model,data,params,options);
    
end

