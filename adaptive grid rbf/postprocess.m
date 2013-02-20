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
    
end

