function [ M ] = rbf_hermite_marginal1D( R , eps , dx, j )
    %RBF_HERMITE_3D Summary of this function goes here
    %   Detailed explanation goes here
    
    ne = size(R,1);
    nx = size(R,2);
    
    %initialise
    M = zeros(ne,3*nx);
    
    % interpolation matrix
    M(1:ne,1:nx) = rbf(R,eps);
    
    % interpolation matrix
    M(1:ne,1:nx) = rbf(R,eps);
    M(1:ne,j*nx+1:(j+1)*nx) = -drbf(R,eps,dx);
    M(1:ne,(mod(j,2)+1)*nx+1:(mod(j,2)+2)*nx) = -rbf(R,eps);
    
end


