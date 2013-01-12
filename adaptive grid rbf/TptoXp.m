function [ P ] = TptoXp( P )
    %TPTOXP Summary of this function goes here
    %   Detailed explanation goes here
    switch(P.kernel_aniso)
       
        case 2
            P.Xp = bsxfun(@plus,P.Tp*P.M,P.Xmean);
        
        case 3
            for j = 1:P.N
                    P.Xp(j,:) = P.Tp(j,:)*P.M(:,:,j)+P.Xmean;

            end
    end
    
end

