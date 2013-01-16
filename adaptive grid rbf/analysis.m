% clear all;
% clf

DefaultSettings

P.kernel_aniso = 2;

P = init(P);


Ns = 10;
Nsamples = 15;
ss = linspace(0,0.4,Ns);

vTp = zeros(Nsamples,Ns);
vTig = zeros(Nsamples,Ns);
vTil = zeros(Nsamples,Ns);
vIg = zeros(Nsamples,Ns);
vIl = zeros(Nsamples,Ns);
vN = zeros(Nsamples,Ns);
vR = zeros(Nsamples,Ns);
vEg = zeros(Nsamples,Ns);
vEl = zeros(Nsamples,Ns);


h = waitbar(0,'');

for s=1:Ns
    for l = 1:Nsamples;
        waitbar(((s-1)*Nsamples+l)/(Ns*Nsamples),h,['Generating: Sample ' num2str(l) '/' num2str(Nsamples) ' for step ' num2str(s) '/' num2str(Ns) ]);
        
%         Ps = P;
%         Ps.adap_d0 = P.adap_d0 - ss(s);
%         Ps.adap_D0 = P.adap_D0 - ss(s);
%         
%         finished = false;
%         while(not(finished))   
%             try
%                 tic;
%                 Ps = refine_particles( Ps );
%                 vP(l,s) = Ps;
%                 finished = true;
%                 vTp(l,s)=toc;
%             catch
%             end
%         end

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


str = cellfun(@(x) num2str(x,2),num2cell(0.5-ss),'UniformOutput',false);

figure(10)
subplot(3,3,1)
boxplot(vTp,str)
xlabel('density')
ylabel('seconds')
title('particle generation time')
subplot(3,3,2)
boxplot(vN,str)
xlabel('density')
ylabel('#')
title('Number of points')
subplot(3,3,3)
boxplot(vR,str)
xlabel('density')
ylabel('#')
title('Number of Iterations')
subplot(3,3,4)
boxplot(vTig,str)
xlabel('density')
ylabel('seconds')
title('interpolation time global kernel')
subplot(3,3,5)
boxplot(abs(vIg),str)
set(gca,'YScale','log')
xlabel('density')
ylabel('Integral')
title('integral approximation global kernel size')
subplot(3,3,6)
boxplot(abs(vEg),str)
set(gca,'YScale','log')
xlabel('density')
ylabel('relative error')
title('Max Error with global kernel size')
subplot(3,3,7)
boxplot(vTil,str)
xlabel('density')
ylabel('seconds')
title('interpolation time local kernel size')
subplot(3,3,8)
boxplot(abs(vIl),str)
set(gca,'YScale','log')
xlabel('density')
ylabel('Integral')
title('integral approximation local kernel size')
subplot(3,3,9)
boxplot(abs(vEl),str)
set(gca,'YScale','log')
xlabel('density')
ylabel('relative error')
title('Max Error with local kernel size')

save([datestr(clock) '_density_analysis'])