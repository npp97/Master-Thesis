function [ P ] = XptoTp( P )
    %GLOBAL_COV Summary of this function goes here
    %   Detailed explanation goes here 
    switch(P.kernel_aniso)
        
        case 2
            P.Tp = bsxfun(@minus,P.Xp,P.Xmean)/P.M;
            
        case 3
            for j = 1:P.N
                P.Tp(j,:) = (P.Xp(j,:)-P.Xmean)/P.M(:,:,j);
            end
    end 
    
    
end

