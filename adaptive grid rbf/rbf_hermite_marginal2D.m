function [ M ] = rbf_hermite_marginal2D( R , eps , dx , dy )
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
    M(1:ne,nx+1:2*nx) = -drbf(R,eps,dx);
    M(1:ne,2*nx+1:3*nx) = -drbf(R,eps,dy);
    
    
end


