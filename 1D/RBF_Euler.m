function f_new = RBF_Euler( Lasym, Easym , f , dt)
%% Euler Time Stepping Scheme
    
L = Easym + dt*Lasym;
f_new = L*f;

plot(eig(L))
    
end