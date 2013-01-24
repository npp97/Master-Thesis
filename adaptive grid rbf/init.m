function [ P ] = init( P )
    %INIT Initialises the algorithm with an initial particle distribution
    % and an approximation to the anisotropy transformation
    
    % compute target neighborhood size
    P = find_Nsize( P );    

    P.D0 = P.init_D0;
    P.d0 = P.init_d0;
    
    % initialise initial point
    P.Xp = P.logscale.*log(P.k)+(1-P.logscale).*P.k;
    
    P.N = size(P.Xp,1);
    
    if(P.init_trans == 3)
        % compute hessian for initial point
        P = lapllh(P);
    elseif(P.adap_method == 2 || P.init_trans == 2 )
        % compute gradient for initial point
        P = gradllh(P);
    else
        % compute function value for initial point
        P = llh(P);
    end
    
    % initialise maximum function value
    P.fmax = max(P.F);

    if(P.kernel_aniso > 1)
        % generate first transformed point
        P.Tp = zeros(1,P.pdim);
        % set mean as initial pint
        P.Xmean = P.Xp;
        % initialise transformation
        switch(P.init_trans)
            case 1
                % initialise transform with initial point
                P.M = eye(P.pdim);
            case 2
                % initialise transform with fisher matrix of initial point
                try
                    P.M = chol(P.S'*P.S);
                catch
                    P.M = chol(P.S'*P.S + 1e-10*diag(P.pdim));
                end
                
            case 3
                % initialise with hessian
                try
                    P.M = chol(-squeeze(P.D2F(1,:,:)));
                catch
                    % this might fail if we are not positive definite so add regularization term
                    P.M = chol(-squeeze(P.D2F(1,:,:))/P.fmax + 1e-10*diag(P.pdim));
                end
        end
        
    end
    
    % initialise particle ages
    P.Lp = ones(size(P.Xp,1),1);

    %% 2.3 Initial particle distribution
    
    % number of iterations for initialisation
    P.Iiter = 1;
    P.Init_rad = P.D0;
    
    switch(P.init_method)
        case 1
            % nothing to do, we already have the modes!
    end
    
    % compute number of points
    P.N = size(P.Xp,1);
    
    if(P.adap_method == 1 || P.adap_method == 2 || P.adap_method == 3)
        % initialise neighborhood sizes
        P = exactDp(P);
    end
    
    % approximate with markov chain, this will be used for error calculation later on
    P = mcmc(P);
    
end

