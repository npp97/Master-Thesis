function [ P ] = diff_mat( P )
    D = zeros(P.pdim,P.N,P.N);
    
    for j = 1 : P.pdim;
        if(P.kernel_aniso > 1)
            D(j,:,:) = diffm(P.Tp(:,j),P.Tp(:,j));
        else
            D(j,:,:) = diffm(P.Xp(:,j),P.Xp(:,j));
        end
    end
            
    P.DM = D;
    
end