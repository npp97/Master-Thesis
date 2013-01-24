clear all;
clf

DefaultSettings

P.adap_d0 = 0.3;
P.adap_D0 = 1;
P.kernel_aniso = 2;
P.plotflag=false;

P = init(P);


Ns = 6;
Nsamples = 15;
ss = 5:10;

vTp = zeros(Nsamples,Ns);
vTig = zeros(Nsamples,Ns);
vTil = zeros(Nsamples,Ns);
vIter = zeros(Nsamples,Ns);
vIg = zeros(Nsamples,Ns);
vIl = zeros(Nsamples,Ns);
vN = zeros(Nsamples,Ns);
vR = zeros(Nsamples,Ns);
vEg = zeros(Nsamples,Ns);
vEg1 = zeros(Nsamples,Ns);
vEl = zeros(Nsamples,Ns);
vEl1 = zeros(Nsamples,Ns);


h = waitbar(0,'');
P.switch_fusion_off = true;

for s=1:Ns
    for l = 1:Nsamples;
        waitbar(((s-1)*Nsamples+l)/(Ns*Nsamples),h,['Generating: Sample ' num2str(l) '/' num2str(Nsamples) ' for step ' num2str(s) '/' num2str(Ns) ]);
        
        Ps = P;
        Ps.adap_Nstar = ss(s);
        finished = false;
        while(not(finished))   
            try
                tic;
                Ps = refine_particles( Ps );
                vP(l,s) = Ps;
                finished = true;
                vTp(l,s)=toc;
            catch err
                pause
            end
        end

        Ps = vP(l,s);
        waitbar(((s-1)*Nsamples+l)/(Ns*Nsamples),h,['Interpolating: Sample ' num2str(l) '/' num2str(Nsamples) ' for step ' num2str(s) '/' num2str(Ns) ]);
        %% 2.5 Interpolation
        
        Ps.kernel_eps_max = 1e2;
        Ps.error_estim = 1;
        tic;
        Ps.kernel_shape = 1;
        Ps = interp(Ps);
        vTig(l,s)=toc;
        Ps = error_estim(Ps);
        vEg(l,s) = Ps.inferror;
        vEg1(l,s) = Ps.l1error;
        
        if(P.kernel_aniso > 2)
            vIg(l,s) = sum(Ps.c.*sqrt(2*pi./Ps.eps.^4).^Ps.pdim)/abs(det(Ps.M));
        else
            vIg(l,s) = sum(Ps.c.*sqrt(2*pi./Ps.eps.^4).^Ps.pdim);
        end
        
        tic;
        Ps.kernel_shape = 2;
        Ps = interp(Ps);
        vTil(l,s) = toc;
        Ps = error_estim(Ps);
        vEl(l,s) = Ps.inferror;
        vEl1(l,s) = Ps.l1error;
        
        if(P.kernel_aniso > 2)
            vIl(l,s) = sum(Ps.c.*sqrt(2*pi./Ps.eps.^4).^Ps.pdim)/abs(det(Ps.M));
        else
            vIl(l,s) = sum(Ps.c.*sqrt(2*pi./Ps.eps.^4).^Ps.pdim);
        end
        vN(l,s) = Ps.N;
        vR(l,s) = Ps.Riter;
        

    end
end
close(h)

%% Visualisation

publish('pubgraph.m')

save([datestr(clock) '_density_analysis'])