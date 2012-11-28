% EX5_MQR
% This puts together convergence order pictures for SineQR
% We consider two choices:
%     General functions with arbitrary "BC" embedded in [0,L]
%     Functions which are homogeneous on [0,L]
% These tests will fix L, ep and beta and consider an increase in N
% Points will be evenly spaced at first, althought we could consider other
%   choices of point distributions
% For the embedded setting, the embedding cushion will be fixed.  The
%   effect of the embedding cushion still needs to be considered.
% I guess we will need to consider both the kernel version and the RBF-QR
%   version of the solve.  Need to think about that because one may be
%   better/faster than the other in different conditions
rbfsetup
global GAUSSQR_PARAMETERS
symavail = GAUSSQR_PARAMETERS.SYMBOLIC_TOOLBOX_AVAILABLE;

close all
% The range of N values to consider
Nvec = 10:5:100;
% The orders (smoothness) of the kernel to consider
betavec = 1:8;
% The kernel shape parameter
ep = 1;
% The length of the domain
L = 1;
% The embedding width for nonhomogeneous functions
embed_cushion = .1;
% The number of evenly spaced points at which to sample error
NN = 397;

% This determines how many extra basis functions should be added to the
% RBF-QR evaluation to get the necessary accuracy: M = Mfactor*N
% Actually picking a good value for this may be difficult
% I guess the minimum should be something like 1.1
Mfactor = 4.5;

% Define the eigenfunctions and eigenvalues
sinfunc = @(n,L,x) sqrt(2/L)*sin(pi*x*n/L);
lamfunc = @(n,L,ep,beta) ((pi*n/L).^2+ep^2).^(-beta);

% This is the function we are interested in considering
% Depending on which function consider, it will choose embedding
fopt = 8;
%potential optimal beta examples: 3, 5, 8, 12, 15, 16
switch fopt
    case 1
        yf = @(x) sin(2*pi*x/L) + 1;
        fstr = 'u(x) = sin(2\pi{x}/L)+1';
        embed = embed_cushion;
    case 2
        yf = @(x) sin(2*pi*x/L);
        fstr = 'u(x) = sin(2\pi{x}/L)';
        embed = 0;
    case 3     %optimal beta = 4?
        yf = @(x) 30*x.^2.*(L-x).^2.*sin(2*pi*x/L).^4;
        fstr = 'u(x) = 30x^2(L-x)^2sin(2\pi{x}/L)^4';
        embed = 0;
    case 4
        yf = @(x) 1./(1+(x/L).^2);
        fstr = 'u(x) = 1/(1+(x/L)^2)';
        embed = embed_cushion;
    case 5 %optimal beta = 3?
        yf = @(x) 1./(1+(x/L).^2)-(1-.5*(x/L));
        fstr = 'u(x) = 1/(1+(x/L)^2)+.5(x/L)-1';
        embed = 0;
    case 6
        yf = @(x) sinh(3/L*x)./(1+cosh(3/L*x));
        fstr = 'u(x) = sinh(3x/L)./(1+cosh(3x/L))';
        embed = embed_cushion;
    case 7
        fstr = 'y(x)=cos(x)+e^{-(x-1)^2}-e^{-(x+1)^2}';
        yf = @(x) cos(x)+exp(-(x-1).^2)-exp(-(x+1).^2);
        embed = embed_cushion;
 %--------------------------------------------------------------
 % Casey and Will's test functions
    case 8 % this family is from the Hubbert-Muller paper on thin plate spline interpolation
        % meant to be used on the unit interval
        %which beta is optimal?
        testfuncN = 14;
        yf = @(x) 10^(testfuncN+1).*(max(0,x-(1/4))).^testfuncN.*(max(0,(3/4)-x)).^testfuncN;
        fstr = ['y(x) = 10^{',num2str(testfuncN+1),'} (max(0,x-(1/4)))^{',num2str(testfuncN),'}(max(0,(3/4)-x)^{',num2str(testfuncN),'}'];
        embed = 0;
    case 9 % ADDITIVE boundary condition forcing
        if symavail % requires Symbolic Math Toolbox :(
            bSatTestFunc = sym(franke(sym('x'),0.5)); % this must be a symbolic expression
            
            % the test function will satisfy boundary conditions for all *even*
            % derivatives up to the (2*bSatDegree)th derivative:
            leftbSatDegree = 5;  % a value of -1 here doesn't force any conditions to be satisfied
            rightbSatDegree = 5; % a value of -1 here doesn't force any conditions to be satisfied
            % specify desired boundary values here:
            lbval = 0;
            ubval = 0;
            
            symyf = forceBCsatADD(bSatTestFunc,leftbSatDegree,rightbSatDegree,0,L,lbval,ubval);
            symyf = symyf / 10^(leftbSatDegree+rightbSatDegree); % we're adding polynomials on the order of 2*bSatDegree, so we should normalize by that much
            yf = matlabFunction(symyf);
            fstr = char(simplify(symyf));
            embed = 0;
        else
            error('Cannot call this function without the symbolic toolkit available')
        end
    case 10 % MULTIPLICATIVE boundary condition forcing
        bSatTestFunc = @(x) x; % this must be a symbolic expression
        
        % the test function will satisfy boundary conditions for all *even*
            % derivatives up to the (2*bSatDegree)th derivative:
            leftbSatDegree = 5;  % a value of -1 here doesn't force any conditions to be satisfied
            rightbSatDegree = 5; % a value of -1 here doesn't force any conditions to be satisfied
        
        yf = forceBCsatMULT(bSatTestFunc,leftbSatDegree,rightbSatDegree,0,L);
        fstr = char(yf);
        embed = 0;
    case 11
        yf = @(x) x.^(26.*sin(2*pi*x));
        fstr = char(yf);
        embed = 0;
    case 12
        yf = @(x) exp(x);
        fstr = char(yf);
        embed = 0;
    case 13
        % satisfies left BC u(0) = 0
        yf = @(x) exp(x)-1;
        fstr = char(yf);
        embed = 0;
    case 14
        % satisfies right BC u(1) = 0
        yf = @(x) exp(x) - exp(1);
        fstr = char(yf);
        embed = 0;
    case 15
        % second order boundary conditions satisfied but no others
        %increasing beta increases error
        yf = @(x) (1/2).*(2.*exp(x) - x.^2 + (x.^3).*((1-exp(1))/3));
        fstr = char(yf);
        embed = 0;
    case 16
        % satisfies all left BCs up to 5th derivative
        % and all right BCs up to 6th derivative
        yf = @(x) (x.^5).*(x-1).^6;
        fstr = char(yf);
        embed = 0;
    case 17
        % satisfies left and right BCs u(0) = u(1) = 0
        yf = @(x) exp(x) - (1-x) - x*exp(1);
        fstr = char(yf);
        embed = 0;
    case 18
        % satisfies the left and right BCs for the 0th and 2nd derivative
        %   u(0) = u''(0) = u(1) = u''(1) = 0
        yf = @(x) exp(x) - 1 + (1/6).*(x.^3 - 3.*x.^2 + 8.*x - exp(1).*(x.^3+5.*x));
        fstr = char(yf);
        embed = 0;
    case 19
        % satisfies left and right BCS for all even derivatives up to and
        % including the fourth, i.e.
        % u(0) = u''(0) = u''''(0) = u(1) = u''(1) = u''''(1) = 0
        yf = @(x) (1/360).*(3.*x.^5-15.*x.^4+80.*x.^3-180.*x.^2-exp(1).*(3.*x.^4+50*x.^2+307).*x+472.*x+360.*exp(x)-360);
        fstr = char(yf);
        embed = 0;

 %--------------------------------------------------------------
 % Functions that satisfy BCs but violate smoothness assumptions
 % at a point in the interior
    case 20 
    % This is a slice of our 2-D kernel for beta=2,epsilon>0.
    % It has a jump in the third derivative.
    % Edit testkernel to set where this jump occurs 
    % (change y to another value in [0,1]).
        yf = @(x) testkernel(x);
        fstr = char(yf);
        embed = 0;         
    case 21
        yf = @(x) min(abs(x-pi/6)-.25,0);
        fstr = char(yf);
        embed = 0;
    case 22
        yf = @(x) testfunction1(x);
        fstr = char(yf);
        embed = 0;
    case 23 
        yf = @(x) testfunction3(x);
        fstr = char(yf);
        embed=0;
    case 24 %sines pasted together
        yf = @(x) testfunction4(x);
        fstr = char(yf);
        embed = 0;
        
    case 25 %satisfies boundary conditions for 0th and 1st derivative and has a discontinuity in the 2nd derivative at .5
        yf= @(x) testfunction5(x);
        fstr = char(yf);
        embed = 0;
   %--------------------------------------------------------------
    case 26 % piecewise polynomial spline kernel as test function
        ppsz = pi/6; % center z for piecewise polynomial spline kernel
        ppsL = 1; % length of interval
        ppsbeta = 5; % beta for piecewise polynomial spline kernel
        yf = @(x) ppsplinekernel(x,ppsz,ppsL,ppsbeta);
        fstr = char(yf);
        embed = 0;
        
    otherwise
        error('This function does not exist')
end

errorForBetas = zeros(length(betavec),NN);

% At some point I'll move the solves into a separate function and consider
% warnings there.  For now I'm tired of seeing the warnings pop up.
warning off

errvec = zeros(length(betavec),length(Nvec));
k = 1;
j = 1;

% interior vs boundary stuff
% define "left boundary" as first quarter of interval,
%        "right boundary" as last quarter of interval,
%        "interior" the half left in the middle
LboundaryRegionEnd = floor((NN/4));
RboundaryRegionStart= floor((3*NN/4));
interiorStart = LboundaryRegionEnd;
interiorEnd = RboundaryRegionStart;
intVsBoundErr = zeros(3*length(betavec),length(Nvec));

for N=Nvec
    if embed==0
    % Don't consider the homogeneous end points because they are fixed
        [x,spacestr] = pickpoints(0,L,N+2);
        x = x(2:end-1);
    else
        [x,spacestr] = pickpoints(embed*L,(1-embed)*L,N);
    end
    y = yf(x);
    xx = pickpoints(embed*L,(1-embed)*L,NN);
    yy = yf(xx);
    
    j = 1;
    for beta=betavec
        if beta==1 || beta==2 % Work with the kernel form
            K_solve = zeros(N);
            K_eval = zeros(NN,N);
            for n=1:N
                K_solve(:,n) = cmatern(x,x(n),L,ep,beta);
                K_eval(:,n) = cmatern(xx,x(n),L,ep,beta);
            end
            b = K_solve\y;
            yp = K_eval*b;
        else % Work with the series form
            MQR = mqr_solve(x,y,L,ep,beta);
            yp = mqr_eval(MQR,xx);
        end

        errvec(j,k) = errcompute(yp,yy);
        
        %-----------------------------------------------------
        % interior vs boundary error stuff:
        
        Lyp = yp(1:LboundaryRegionEnd);
        Ryp = yp(RboundaryRegionStart:end);
        interioryp = yp(interiorStart:interiorEnd);
        Lyy = yy(1:LboundaryRegionEnd);
        Ryy = yy(RboundaryRegionStart:end);
        interioryy = yy(interiorStart:interiorEnd);
        
        intVsBoundErr(3*j-2,k) = errcompute(Lyp,Lyy);
        intVsBoundErr((3*j)-1,k) = errcompute(Ryp,Ryy);
        intVsBoundErr(3*j,k) = errcompute(interioryp,interioryy);
        %-------------------------------------------------------
        
        % For error profile plots
        errorForBetas(beta,:) = yy-yp;
        errorForBetasAndN(beta+(k-1)*length(betavec),:) = yy-yp;
        j = j + 1;
    end
    
    k = k + 1;
end
warning on

%--------------------------------------------
% Interior vs. Boundary Error Curves
% look at that beautiful dip

highNintVsBoundaryErr = zeros(length(betavec),3);
for i = betavec
    highNintVsBoundaryErr(i,1:3) = intVsBoundErr(3*i-2:3*i,length(Nvec));
end
semilogy(betavec,highNintVsBoundaryErr);
set(gca,'XTick',[1:length(betavec)])

%--------------------------------------------
% Boundary vs. Interior individual error plots:
interiorVsBoundaryPlots = figure;
title('Interior vs Boundary Error as Beta Varies');
for i = betavec
thisFig = subplot(length(betavec)/2,2,i);
loglog(Nvec,intVsBoundErr(3*i-2:3*i,:));
titleStr = ['\beta = ',num2str(i)];
ylabel('error');
title(titleStr);
end
% ylim(10e-20,0);
%--------------------------------------------
% Convergence data

% Finds a convergence "score" for each beta
% (the slope of a best-fit line for error vs N)
a1betaVals = zeros(length(betavec),1);
convergenceExponentData = zeros(length(betavec),2);
for beta = betavec
    p = polyfit(log(Nvec),log(errvec(beta,:)),1);
    a1betaVals(beta) = p(1);
end
a1Vals = a1betaVals./betavec';
convergenceExponentData(:,1) = a1betaVals.*-1;
convergenceExponentData(:,2) = a1Vals;

% Display a1 and a1beta values:
disp('a_1 values:')
disp(a1Vals);
disp('(a_1 * beta) values:')
disp(a1betaVals);
%---------------------------------------------
% Plot a1 and a1*beta:
a1plot = figure('NumberTitle','off','Name',[num2str(fopt),'scores']);
plot(betavec,convergenceExponentData,'Marker','square','LineWidth',2);
xlabel('\beta')
legend('a_1 \cdot \beta','a_1','location','best')
%---------------------------------------------
% Plot function:
figure;
plot(xx,yy);
title('Test function');
%---------------------------------------------
% Plot individual error:
individualerror = figure;
title('Error as \beta varies');
for i = betavec;
errorFig = subplot(length(betavec)/2,2,i);
%plot(xx,errorForBetas(i,:));
semilogy(xx,abs(errorForBetas(i,:)));
ylim([1e-18 1e-3]);  % or whatever values are appropriate, the main thing is to get the same limits on all subplots
set(gca,'YTick',[1e-15 1e-10 1e-5])
titleStr = ['\beta = ',num2str(i)];
ylabel('error');
title(titleStr);
end
%---------------------------------------------
% % Plot error surfaces:
% for i = betavec
%     figure;
%     surf(xx,Nvec,log10(abs(errorForBetasAndN(i:length(betavec):end,:))))
%     titleStr = ['\beta = ',num2str(i)];
%     xlabel('x');
%     ylabel('N');
%     zlabel('error');
%     title(titleStr);
% end
%---------------------------------------------
% Plot RMS error as beta and N vary:
errorplot = figure('NumberTitle','off','Name',num2str(fopt));
loglog(Nvec,errvec,'linewidth',2);
% semilogy(Nvec,errvec,'linewidth',2)
xlabel('input points N');
ylabel('RMS relative error');
title(strcat(sprintf('x \\in [%g,%g] ',embed*L,(1-embed)*L),sprintf('     \\epsilon = %g',ep)));
legend('\beta = 1','\beta = 2','\beta = 3','\beta = 4','\beta = 5','\beta = 6','\beta = 7','\beta = 8','location','best');