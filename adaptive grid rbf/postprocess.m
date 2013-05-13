function [ P ] = postprocess( P )
    %POSTPROCESS Summary of this function goes here
    %   Detailed explanation goes here
    
    disp(['------- Post Processing -------'])
    
    P = gradllh(P);
    
%     disp(['# Computing Gradients on MCMC Samples'])
%     textprogressbar('Progress: ');
%     for j = 1 : P.NX
%         textprogressbar(j/P.NX*100)
%         [P.Ftrue(j,1),P.Fgradtrue(j,:)] = eval_gradllh(P.XX(j,:),P);
%     end
%     textprogressbar('done');
%     textprogressbar('Progress: ');
%     for j = 1 : P.NX
%         textprogressbar(j/P.NX*100)
%         [P.Ftrue(j,1)] = eval_llh(P.XX(j,:),P);
%     end
%     textprogressbar('done');    
%     
    %% remove particles with function value zero
    ind = (P.F > 0);
    P.Xp = P.Xp(ind,:);
    P.Tp = P.Tp(ind,:);
    P.Dp = P.Dp(ind,:);
    P.rcp = P.rcp(ind,:);
    P.F = P.F(ind,:);
    P.DF = P.DF(ind,:);
    P.R = P.R(ind,ind);
    try
        P.Nlist = P.Nlist(ind,ind);
    end
    
    P.N = sum(ind);
    
    P.gradDF_mls = sqrt(sum(P.DF.^2,2));
    eps = fminbnd(@(par) norm(abs(P.gradDF_mls - (rbf(P.R,exp(par))-rbf(0,par(1))*eye(P.N))*P.gradDF_mls),inf),-1,1);
    alpha = fminbnd(@(par) norm(abs(P.gradDF_mls - par * rbf(P.R,exp(eps))*P.gradDF_mls),inf),0,1);
    
    P.eps_mls_df = exp(eps);
    P.alpha_mls_df = alpha;
    
    P.F_mls = P.F;
    eps = fminbnd(@(par) norm(abs(P.gradDF_mls - (rbf(P.R,exp(par))-rbf(0,par(1))*eye(P.N))*P.F_mls),inf),-1,1);
    alpha = fminbnd(@(par) norm(abs(P.gradDF_mls - par * rbf(P.R,exp(eps))*P.F_mls),inf),0,1);
    P.eps_mls_f = exp(eps);
    P.alpha_mls_f = alpha;
    
    
end

