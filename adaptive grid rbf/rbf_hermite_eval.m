function [ M ] = rbf_hermite_eval( R , eps , DX )
    %RBF_HERMITE_3D Summary of this function goes here
    %   Detailed explanation goes here
    
    ne = size(R,1);
    nx = size(R,2);
    np = size(DX,1);
    
    %initialise
    M = zeros(ne,(np+1)*nx);
    
    % interpolation matrix
    M(1:ne,1:nx) = rbf(R,eps);

    for j = 1 : np
        
        % 1 : j*nx  
        % M - - M -D 
        % M previous
        % D gradient
        
        D = drbf(R,eps,squeeze(DX(j,:,:)));
        
        M(1:ne,j*nx+1:(j+1)*nx) = -D;

        
    end
    
end


