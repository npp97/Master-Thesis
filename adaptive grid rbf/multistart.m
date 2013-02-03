function [ mode, val, XX ] = multistart( P )
    %MULTISTART Summary of this function goes here
    %   Detailed explanation goes here
    
    P.multi_init_mode = 1;
    % 1: uniform
    % 2: log-uniform
    
    P.multi_init_N = 50;
    
    switch(P.multi_init_mode)
        case 1
            XX = rand(P.multi_init_N,2)*(1e1-1e-3)+1e-3;
            P.logscale = zeros(1,P.pdim);
        case 2
            XX = rand(P.multi_init_N,2)*(1+3)-3;
            P.logscale = ones(1,P.pdim);
    end
    
    mode = zeros(P.multi_init_N,P.pdim);
    val = zeros(P.multi_init_N,1);
    for j = 1:P.multi_init_N;
        mode(j,:) = XX(j,:);
        [mode(j,:), val(j)] = fmincon(@(x) objective(x,P),mode(j,:),[],[],[],[],[1e-3 1e-3],[1e1 1e1]);
    end
    
end

function [ f, gradf ] = objective(x,P)
    [ff,~,~,gradf] = eval_gradllh(x,P);
    
    f = -log(ff);
    
    
end
