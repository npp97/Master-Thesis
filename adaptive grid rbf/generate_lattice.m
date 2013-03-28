function [ P ] = generate_lattice( P )
    %GENERATE_LATTICE Summary of this function goes here
    %   Detailed explanation goes here
    
    % total number of particles in the previous iteration
    lspawn = 0;
    
    % total number of particles
    tspawn = 1;
    
    % integer coordinats
    P.L = zeros(1,P.pdim);
    
    % Function value
    LF = P.fmax;
    
    % neighbor flags;
    nbor = zeros(1,2*P.pdim);
    % 1:pdim neighbor in negative direction already exists
    % pdim+1:2pdim neighbor in positve direction already exists
    
    XX = P.Xp(1,:);
    
    % stop until we add no further particles
    while(tspawn - lspawn > 0)
        for j = lspawn+1 : tspawn 
            if(LF(j,1)>P.fmax*P.thresh)
                for k = 1 : P.pdim
                    if(nbor(j,P.pdim+k) == 0)
                        add = zeros(1,P.pdim);
                        nb = zeros(1,2*P.pdim);
                        add(k) = 1;
                        nb(k) = 1;
                        P.L(end+1,:) = P.L(j,:)+add;
                        nbor(end+1,:) = nb;
                    end
                    if(nbor(j,k) == 0)
                        add = zeros(1,P.pdim);
                        nb = zeros(1,2*P.pdim);
                        add(k) = -1;
                        nb(P.pdim+k) = 1;
                        P.L(end+1,:) = P.L(j,:)+add;            
                        nbor(end+1,:) = nb;
                    end
                end
            end
        end
        lspawn = tspawn;
        [~,ind] = unique(P.L,'rows','first');
        ii = sort(ind);
        P.L=P.L(ii,:);
        nbor=nbor(ii,:);
        tspawn = size(P.L,1);
        for j = lspawn + 1 : tspawn
            LF(j,1) = eval_llh(XX+P.L(j,:)*P.Gram,P);
            P.feval_latt = P.feval_latt + 1;
        end

        figure(5)
        
        XL = P.L*P.Gram;
        switch(P.pdim)
            case 1
                semilogy(XL(:,1),LF,'bo')
            case 2
                scatter(XL(:,1),XL(:,2),max(log(LF)/log(10),1e-16)+10,max(log(LF)/log(10),1e-16)+20);
            case 3
                scatter3(XL(:,1),XL(:,2),XL(:,3),max(log(LF)/log(10),1e-16)+10,max(log(LF)/log(10),1e-16)+20);
    end

    P.Xp = bsxfun(@plus,P.Xp(1,:),P.L*P.Gram);
    P.F = LF;
    
end

