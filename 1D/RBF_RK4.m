function f_new = RBF_RK4( Lsym, Lasym, Easym , f , dt)
%% RK4
    
k1 = dt*Lasym;
k2 = dt*Lsym*(Easym + 1/2*k1);
k3 = dt*Lsym*(Easym + 1/2*k2);
k4 = dt*Lsym*(Easym + k3);
    
L = Easym + 1/6*(k1 + 2*k2 + 2*k3 + k4);
f_new = L*f;

plot(eig(L))
    
end