function [ P ] = interp( P )
    %INTERP standard RBF Interpolation
    
    disp(['------- RBF Interpolation -------'])
    
    % compute distances
    if(P.kernel_aniso > 1)
        P.R = sqrt(sqdistance(P.Tp'));
    else
        P.R = sqrt(sqdistance(P.Xp'));
    end
    
    % get function values
    disp(['# Evaluating Function '])
%     P = llh(P);

    % choose inversion method
    switch(P.kernel_inverse)
        case 1
            % estimate optimal eps
            disp(['# Optimizing Shape Parameter '])
            P.eps = fminbnd(@(ep) CostEps(ep,P),1e-3/mean(P.rcp),1e1/mean(P.rcp),optimset('Display','iter'));
             
            % normalize eps
            if(P.kernel_shape == 2)
                P.eps = P.eps./P.rcp;
            else
                P.eps = P.eps/mean(P.rcp);
            end
            
            % compute interpolation matrix 
            P.RBF = rbf(P.R,P.eps);
            
            % check for positivity constraint
            if(P.error_estim < 4)
                P.c = P.RBF\P.F;
            else
                A = P.RBF;
                b = P.F;
                
                c = lsqlin(A,b,[],[],[],[],zeros(P.N,1),[],[],optimset('Display','iter'));

                P.c = c;
                
            end
                
        case 2
            % estimate optimal eps
            P.eps = fminbnd(@(ep) CostEpsRiley(ep,P),1e-3/mean(P.rcp),1e1/mean(P.rcp));
            
            % normalize eps
            if(P.kernel_shape == 2)
                P.eps = P.eps./P.rcp;
            else
                P.eps = P.eps/mean(P.rcp);
            end
            
            % compute interpolation matrix 
            P.RBF = rbf(P.R,P.eps);
            
            % invert
            P.c = Riley_mex(P.RBF,P.F,P.riley_mu);
    end
    
            
    
end

