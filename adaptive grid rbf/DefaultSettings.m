%% 1 Parameters

%% 1.0 CVODE settings

% integration tolerances
P.ode_reltol = 1e-6;
P.ode_abstol = 1e-8;

%% 1.1 Data

P.model = 1;

switch(P.model)
    
    case 1
        P.ode=@dxdt_M1_mex;
        structdxdt_M1
        P.mStructdxdt = mStructdxdt;
        P.k=[0.6 0.4];
        P.y0=[1;0]; 
        P.tN=60;
        P.species=1;
        P.sigma=0.1;
        P.logscale = [0 1];
        P.pdim = 2;
        P.xdim = 2;
        
        P.paramspec = {
            {'k+1', P.k(1), 0}
            {'k-1', log(P.k(2)), 0}
            };
    case 2
        P.ode=@dxdt_M2_mex;
        structdxdt_M2
        P.mStructdxdt = mStructdxdt;
        P.k=[0.6 0.4 0.1];
        P.y0=[1;0;4;0];
        P.tN=60;
        P.species=[1 4];
        P.sigma = 0.1;
        P.logscale = [1 1 1];
        P.pdim = 3;
        P.xdim = 4;
        
        P.paramspec = {
            {'k+1', P.k(1), 0}
            {'k-1', P.k(2), 0}
            {'k2', P.k(3), 0}
            };
end

% true parameters



P.tdata=linspace(0,10,P.tN);

[~,yy] = P.ode(P.tdata,[P.y0],P.k,[],[P.ode_reltol,P.ode_abstol,P.tdata(end)]);
figure(2)
plot(P.tdata,yy(P.species,:),'.-')
P.ydata = yy(P.species,:)'; 
drawnow

%% 1.2 Interpolation area

P.method_thresh = 1;
% 1: hard cutoff relative to maximum

% hard cutoff value
P.thresh = 1e-4;
P.rem_thresh = 1e-20;

%% 1.3 Initial Particle Guess

% method for spawning particles
P.init_method = 3;
% 1: equidistant euclidean
% 2: equidistant radial
% 3: single point at modes

% initial grid spacing
P.init_d0 = 0.3;
P.init_D0 = 0.5;

%% 1.4 Adaptive Grid

% method for adapting the grid
P.adap_method = 1;
% 1: local monitor function with function value
% 2: local monitor function with gradient
% 3: global neighborhood size
% 5: residual subsampling

% spawning method
P.adap_spawn_method = 1;
% 1: randomly in too small neighborhood
% 2: based on mean at edges

% fusion method
P.adap_fusion_method = 1;
% 1: where particles are too close to each other
% 2: no fusion

% after how many iterations to start cohesive gradient?
P.adap_gradient_start = 1;

% settings for linesearch
P.opts=optimset('TolFun',1e-4,'TolX',1e-4);


% potential function

% lower mesh bound
P.adap_d0 = 0.5;

% upper mesh bound
P.adap_D0 = 1;

% target Neighborhood size
switch(P.pdim)
    case 2
        P.adap_Nstar = 6;
    case 3
        P.adap_Nstar = 18;
end

% relative optimal distance tolerance
P.adap_dc = 2.5;

% relative neighborhood size
P.adap_rstar = sqrt(2);

% relative gradient influence radius
P.adap_gradr = sqrt(2);

% number of gradient steps
P.adap_ngradstep = 1;

%% 1.5 Kernel

% kernel
P.kernel = 1;
% 1: gaussian

% anisotropic transformation
P.kernel_aniso = 2;
% 1: isotropic
% 2: global anisotropic
% 3: local anisotropic

P.kernel_aniso_method = 1;
% 1: covariance
% 2: covariance with function value

% steps until update of covariance matrix
P.cov_iter = 1;

% shape parameter
P.kernel_shape = 1;
% 1: global;
% 2: local;


% method for matrix invers
P.kernel_inverse = 1;
% 1: pinv
% 2: riley
P.riley_mu = 1e-11;


% minimum value for shape parameter
P.kernel_eps_min = 0;
% maximum value for shape parameter
P.kernel_eps_max = 5;

%% 1.6 Visualisation
P.vsx = 2;
P.vsy = 2;
P.vsT = 3.5;
P.vsN = 30;

[P.VX,P.VY] = meshgrid(linspace(-P.vsx,P.vsx,P.vsN),linspace(-P.vsy,P.vsy,P.vsN));
P.Xv = [P.VX(:),P.VY(:)];

% number of iterations between plots
P.plotinter = 1;

% whether to plot
P.plotflag = false;

