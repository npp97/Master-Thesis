function [ Ddash ] = monitor_function( DF , Dzero)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    Ddash = Dzero ./ (sqrt( 1 + DF.^2));
    
end

