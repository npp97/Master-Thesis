clear all;
clf

DefaultSettings

P = init(P);


Ns = 5;
Nsamples = 5;
ss = linspace(0,0.45,Ns);

vTp = zeros(Nsamples,Ns);
vTi = zeros(Nsamples,Ns);
vI = zeros(Nsamples,Ns);
vN = zeros(Nsamples,Ns);
vR = zeros(Nsamples,Ns);
vE = zeros(Nsamples,Ns);

for s=1:Ns
    for l = 1:Nsamples;
        Ps = P;
        Ps.adap_d0 = P.adap_d0 - ss(s);
        Ps.adap_D0 = P.adap_D0 - ss(s);
        tic;
        Ps = refine_particles( Ps );
        
        vTp(l,s)=toc;
        %% 2.5 Interpolation
        
        tic;
        Ps = interp(Ps);
        vTi(l,s)=toc;
        
        Ps = error_estim(Ps);
        
        
        vI(l,s) = sum(Ps.c)/abs(det(Ps.M*Ps.M'));
        vN(l,s) = Ps.N;
        vR(l,s) = Ps.Riter;
        vE(l,s) = Ps.inferror;
        
        vP(l,s) = Ps;
    end
end

%% Visualisation

figure(10)
subplot(2,3,1)
boxplot(vTp,'plotstyle','compact')
subplot(2,3,2)
boxplot(vTi,'plotstyle','compact')
subplot(2,3,3)
boxplot(vI,'plotstyle','compact')
subplot(2,3,4)
boxplot(vN,'plotstyle','compact')
subplot(2,3,5)
boxplot(vR,'plotstyle','compact')
subplot(2,3,6)
boxplot(vE,'plotstyle','compact')


    