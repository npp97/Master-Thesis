clear all;
clf

DefaultSettings

P = init(P);


Ns = 10;
Nsamples = 15;
ss = linspace(0,0.4,Ns);

vTp = zeros(Nsamples,Ns);
vTig = zeros(Nsamples,Ns);
vTil = zeros(Nsamples,Ns);
vI = zeros(Nsamples,Ns);
vN = zeros(Nsamples,Ns);
vR = zeros(Nsamples,Ns);
vEg = zeros(Nsamples,Ns);
vEl = zeros(Nsamples,Ns);


h = waitbar(0,'');
for s=1:Ns
    for l = 1:Nsamples;
        
        Ps = P;
        Ps.adap_d0 = P.adap_d0 - ss(s);
        Ps.adap_D0 = P.adap_D0 - ss(s);
        tic;
        finished = false;
        while(not(finished))   
            try
                Ps = refine_particles( Ps );
                vP(l,s) = Ps;
                finished = true;
            catch
            end
        end

        
        vTp(l,s)=toc;
        %% 2.5 Interpolation
        
        tic;
        Ps = interp(Ps);
        vTig(l,s)=toc;
        Ps = error_estim(Ps);
        vEg(l,s) = Ps.inferror;
        
        tic;
        Ps = interp(Ps);
        vTil(l,s) = toc;
        Ps = error_estim(Ps);
        vEl(l,s) = Ps.inferror;
        
        vI(l,s) = sum(Ps.c)/abs(det(Ps.M*Ps.M'));
        vN(l,s) = Ps.N;
        vR(l,s) = Ps.Riter;
        
        waitbar(numel(vP)/(Ns*Nsamples),h,['Sample ' num2str(l) '/' num2str(Nsamples) ' for step ' num2str(s) '/' num2str(Ns) ]);
 
    end
end
close(h)

%% Visualisation


str = cellfun(@(x) num2str(x,2),num2cell(ss),'UniformOutput',false);

figure(10)
subplot(3,3,1)
boxplot(vTp,str)
title('particle time')
subplot(3,3,2)
boxplot(vTig,str)
title('interpolation time global kernel')
subplot(3,3,3)
boxplot(vTil,str)
title('interpolation time local kernel size')
subplot(3,3,4)
boxplot(vI,str)
title('integral approximation')
subplot(3,3,5)
boxplot(vN,str)
title('Number of points')
subplot(3,3,6)
boxplot(vR,str)
title('Number of Iterations')
subplot(3,3,7)
boxplot(vEg,str)
set(gca,'YScale','log')
title('Max Error with global kernel size')
subplot(3,3,8)
boxplot(vEl,str)
set(gca,'YScale','log')
title('Max Error with local kernel size')


    