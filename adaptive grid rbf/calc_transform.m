function [ P ] = calc_transform( P )
    %CALC_TRANSFORM Summary of this function goes here
    %   Detailed explanation goes here

    switch(P.kernel_aniso)
        case 2
            ind = P.F>P.fmax*P.thresh;
            X = P.Xp(ind,:);
            if(size(X,1)>2)
                P.Xmean = mean(X);
                Xm = bsxfun(@minus,X,P.Xmean);
                if(P.kernel_aniso_method == 2)
                    Xf = Xm.*repmat(qrt(P.F(ind)/P.fmax),1,P.pdim);
                else
                    Xf = Xm;
                end
                try
                    P.M = chol(cov(Xf));
                catch
                    P.M = chol(cov(Xf)+diag(P.pdim)*1e-10);
                end
            end

        case 3
            if(P.N>2)
                P.Xmean = mean(P.Xp);
                
                Xm = bsxfun(@minus,P.Xp,P.Xmean);
                
                if(P.kernel_aniso_method == 2)
                    Xf = repmat(sqrt(P.F/P.fmax),1,P.pdim);
                else
                    Xf = 1;
                end;
                c=sqrt(abs(det(cov(Xm))));
                P.M = zeros(P.pdim,P.pdim,P.N);
                
                figure(3)
                clf
                hold on
                for j = 1:P.N
                    try
                        M = chol(loccov(Xm,Xm(j,:),Xf));
                    catch 
                        M = chol(loccov(Xm,Xm(j,:),Xf)+diag(P.pdim)*1e-10);
                    end
                    
                    P.M(:,:,j) = M/sqrt(abs(det(M)));
                    
                    [V,E] = eig(P.M(:,:,j)'*P.M(:,:,j));
                    quiver(Xm(j,1),Xm(j,2),0.1*E(1,1)*V(1,1),0.1*E(1,1)*V(2,1))
                    quiver(Xm(j,1),Xm(j,2),0.1*E(2,2)*V(1,2),0.1*E(2,2)*V(2,2))
                    scatter(P.Xp(:,1)-P.Xmean(1),P.Xp(:,2)-P.Xmean(2),ones(size(P.rcp))*40,log(P.F)/log(10));
                end
                
                
            end
    end
    
    P.D0 = P.adap_D0;
    P.d0 = P.adap_d0;
end


