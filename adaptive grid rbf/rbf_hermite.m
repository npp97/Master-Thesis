function [ M ] = rbf_hermite( R , eps , DX )
    %RBF_HERMITE_3D Summary of this function goes here
    %   Detailed explanation goes here
    
    nx = size(R,1);
    np = size(DX,1);
    
    %initialise
    M = zeros((np+1)*nx,(np+1)*nx);
    
    % interpolation matrix
    M(1:nx,1:nx) = rbf(R,eps);

    for j = 1 : np
        
        % 1 : j*nx  
        % M - - M -D 
        % | \   | S
        % |   \ | |
        % M - - M S
        % D S - S H
        % M previous
        % D gradient
        % S negative mixed 2nd order derivative
        % H negative double 2nd order derivative
        
        D = drbf(R,eps,squeeze(DX(j,:,:)));
        
        M(1:nx,j*nx+1:(j+1)*nx) = -D;
        M(j*nx+1:(j+1)*nx,1:nx) = D;

        for k = 2 : j
            S = ddrbf(R,eps,squeeze(DX(j,:,:)),squeeze(DX(k,:,:)));
            M((k-1)*nx+1:(k)*nx,j*nx+1:(j+1)*nx) = -S;
            M(j*nx+1:(j+1)*nx,(k-1)*nx+1:k*nx) = -S;
        end
        
        H = ddrbf(R,eps,squeeze(DX(j,:,:)),squeeze(DX(j,:,:)));
       
        M(j*nx+1:(j+1)*nx,j*nx+1:(j+1)*nx) = -H;
        
    end
    
end


