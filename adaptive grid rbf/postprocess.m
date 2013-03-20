function [ P ] = postprocess( P )
    %POSTPROCESS Summary of this function goes here
    %   Detailed explanation goes here
    
    disp(['------- Post Processing -------'])
    
    P = gradllh(P);
    
    disp(['# Computing Gradients on MCMC Samples'])
    textprogressbar('Progress: ');
    for j = 1 : P.NX
        textprogressbar(j/P.NX*100)
        [P.Ftrue(j,1),P.Fgradtrue(j,:)] = eval_gradllh(P.XX(j,:),P);
    end
    textprogressbar('done');
%     textprogressbar('Progress: ');
%     for j = 1 : P.NX
%         textprogressbar(j/P.NX*100)
%         [P.Ftrue(j,1)] = eval_llh(P.XX(j,:),P);
%     end
%     textprogressbar('done');    
    
    %% remove particles with function value zero
    
    ind = (P.F > 0);
    P.Xp = P.Xp(ind,:);
    P.Tp = P.Tp(ind,:);
    P.Dp = P.Dp(ind,:);
    P.rcp = P.rcp(ind,:);
    P.F = P.F(ind,:);
%    P.DF = P.DF(ind,:);
    P.R = P.R(ind,ind);
    
    P.N = sum(ind);
    
    
end

