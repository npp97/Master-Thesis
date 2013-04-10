function [ P ] = calc_transform( P )
    %CALC_TRANSFORM Summary of this function goes here
    %   Detailed explanation goes here

    switch(P.kernel_aniso)
        case 2
            % 2: global anisotropic
            % select particles in \Omega
            %ind = P.F>P.fmax*P.thresh;
            ind = P.F>0;
            X = P.Xp(ind,:);
            
            % tranform only if we have more than pdim points, otherwise the covariance will alway be degenerated
            if(size(X,1)>P.pdim)
                if(P.kernel_aniso_method == 2)
                    % 2: covariance with function value
                    if(size(P.F(ind),2)>size(P.F(ind),1))
                        P.F = P.F';
                    end
                    % weighted locations
                    Xf = X.*repmat(P.Dp(ind).*P.F(ind)/P.fmax,1,P.pdim);
                    % weighted mean
                    P.Xmean = sum(Xf,1)/(sum(P.Dp(ind).*P.F(ind)/P.fmax));     
                    % substract mean
                    Xm = bsxfun(@minus,X,P.Xmean);
                    % weighted zero mean points
                    Xmf = Xm.*repmat(sqrt(P.Dp(ind).*P.F(ind)/P.fmax),1,P.pdim);
                    try
                        % take chol decomposition of weighted covariance as transformation
                        P.Mnew = sqrtm((Xmf'*Xmf)/(sum(P.Dp(ind))));
                    catch
                        % regularise if chol is not possible
                        P.Mnew = sqrtm((Xmf'*Xmf)/(sum(P.Dp(ind))+diag(P.pdim)*1e-10));
                    end
                else
                    % 1: covariance
                    
%                     P.Xmean = mean(X);
%                     Xm = bsxfun(@minus,X,P.Xmean);
                    try
                        P.Mnew = sqrtm(cov(Xm));
                    catch
                        P.Mnew = sqrtm(cov(Xm)+diag(P.pdim)*1e-10);
                    end
                    
                end
                
                %P.Mnew = P.Mnew/((abs(det(P.Mnew/P.M)))^(1/P.pdim));
                
                %s = fminsearch(@(t) norm(diag(P.M)-diag(t*P.Mnew),2),1);
                %s = min(diag(P.M))/min(diag(P.Mnew));
                %s = fminsearch(@(t) norm(P.M-t*P.Mnew,2),1);
                %s = fminsearch(@(t) norm(P.M*P.M-t^2*P.Mnew*P.Mnew),1);
                %s = norm(P.M,2)/norm(P.Mnew,2);
                s = 1/norm(P.M\P.Mnew,2);
                
                P.Mnew = s*P.Mnew;
                
                
                try
                P.Mdiffinf(P.Riter) = norm(P.M-P.Mnew,inf);
                P.Mdifffish(P.Riter) = norm(P.Minit-P.Mnew,inf);
                catch
                end
                
                P.M = P.Mnew;
                
            end

        case 3
            % 3: local anisotropic
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
                        M = sqrtm(loccov(Xm,Xm(j,:),Xf));
                    catch 
                        M = sqrtm(loccov(Xm,Xm(j,:),Xf)+diag(P.pdim)*1e-10);
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
    P.M = real(P.M);
end


