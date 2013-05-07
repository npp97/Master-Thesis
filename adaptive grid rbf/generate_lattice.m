function [ P ] = generate_lattice( P )
    %GENERATE_LATTICE Summary of this function goes here
    %   Detailed explanation goes here
    
    % total number of particles in the previous iteration
    lspawn = 0;
    
    % total number of particles
    tspawn = 1;
    
    % integer coordinats
    P.idim = size(P.Generator,2);
    P.L = zeros(1,P.idim);
    
    % Function value
    LF = P.fmax;
    
    % neighbor flags;
    nbor = zeros(1,2*P.idim);
    % 1:pdim neighbor in negative direction already exists
    % pdim+1:2pdim neighbor in positve direction already exists
    
    XX = P.Xp(1,:);
    
    % stop until we add no further particles
    while(tspawn - lspawn > 0)
        for j = lspawn+1 : tspawn 
            if(LF(j,1)>P.fmax*P.thresh)
                for k = 1 : P.idim
                    if(nbor(j,P.pdim+k) == 0)
                        add = zeros(1,P.idim);
                        nb = zeros(1,2*P.idim);
                        add(k) = 1;
                        nb(k) = 1;
                        P.L(end+1,:) = P.L(j,:)+add;
                        nbor(end+1,:) = nb;
                    end
                    if(nbor(j,k) == 0)
                        add = zeros(1,P.idim);
                        nb = zeros(1,2*P.idim);
                        add(k) = -1;
                        nb(P.idim+k) = 1;
                        P.L(end+1,:) = P.L(j,:)+add;            
                        nbor(end+1,:) = nb;
                    end
                end
            end
        end
        lspawn = tspawn;
        P.Xp = bsxfun(@plus,XX,P.L*P.Generator');
        [~,ind] = unique(P.Xp,'rows','first');
        ii = sort(ind);
        P.L=P.L(ii,:);
        P.Xp=P.Xp(ii,:);
        nbor=nbor(ii,:);
        tspawn = size(P.L,1);
        for j = lspawn + 1 : tspawn
            LF(j,1) = eval_llh(P.Xp(j,:),P);
            P.feval_latt = P.feval_latt + 1;
        end
        P.F = LF;
        P.N = length(P.F);
        %plot_points(P,1);

    end
end

