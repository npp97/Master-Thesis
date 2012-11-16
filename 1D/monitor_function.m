function [ Ddash ] = monitor_function( x , Dzero)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    Ddash = Dzero ./ (sqrt( 1 + sum(gradllh(0,x).^2,2).^2));
    
end

