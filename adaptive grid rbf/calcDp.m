function Dp = calcDp( P )
    %CALCDP Summary of this function goes here
    %   Detailed explanation goes here
    
    % first order
%     if(P.kernel_aniso > 1)
%         Dp = P.cDp(P.Tp);
%         if (any(isnan(Dp)) || numel(Dp)==0)
%             Dp(isnan(Dp)) = P.cDpNN(P.Tp(isnan(Dp),:));
%         elseif(numel(Dp)==0)
%             Dp = P.cDpNN(P.Tp);
%         end
%     else
%         Dp = P.cDp(P.Xp);
%         if (any(isnan(Dp)))
%             Dp(isnan(Dp)) = P.cDpNN(P.Xp(isnan(Dp),:));
%         elseif(numel(Dp)==0)
%             Dp = P.cDpNN(P.Xp);
%         end
%     end 

     % mls 
      
     if(P.kernel_aniso > 1)
         R = sqrt(sqdistance(P.Tp',P.X_mls'));
     else     
         R = sqrt(sqdistance(P.Xp',P.X_mls'));
     end

     
    
     
      
     
     if(P.adap_method == 1)
        % fval version
        %F = P.alpha_mls*rbf(R,P.eps_mls)*P.F_mls;
        %MF=monitor_function(sqrt(((P.D0/P.d0)^2-1))*F/P.fmax,P.D0);
        % norm grad version
        DF = P.alpha_mls*rbf(R,P.eps_mls)*P.gradDF_mls;
        MF=monitor_function(sqrt(((P.D0/P.d0)^2-1))*DF/P.fmax,P.D0);
        
        if(size(MF,1)>size(MF,2))
            MF = MF';
        end
        
        Dp = min(repmat(MF,P.N,1) + (P.R>P.adap_rstar*repmat(MF,P.N,1))*max(P.adap_D0,P.adap_d0)*100,[],2);
        
    else
        Dp = (P.D0 + P.d0)/2 * ones(size(P.F));
    end
    if(size(Dp,2)>size(Dp,1))
        Dp = Dp';
    end
    P.Dp=Dp;
    P.rcp=P.adap_rstar*P.Dp;
     
end

