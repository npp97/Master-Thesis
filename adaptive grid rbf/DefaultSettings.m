%% 1 Parameters

%% 1.0 CVODE settings

% integration tolerances
P.ode_reltol = 1e-6;
P.ode_abstol = 1e-8;

%% 1.1 Data

P.model = 2;

switch(P.model)
    
    case 1
        P.ode=@dxdt_M1_mex;
        P.dxdp=@dxdp_M1;
        P.dxdpdp=@dxdpdp_M1;
        structdxdt_M1
        P.mStructdxdt = mStructdxdt;
        P.k=[0.6 0.4];
        P.y0=[1;0]; 
        P.tN=15;
        P.species=1;
        P.sigma=0.1;
        P.logscale = [1 1];
        P.pdim = 2;
        P.xdim = 2;
        
        P.paramspec = {
            {'k_{+1}', log(P.k(1)), log(P.k(1))-5,log(P.k(1))+5}
            {'k_{-1}', log(P.k(2)), log(P.k(2))-5,log(P.k(2))+5}
            };
        
        P.tdata=linspace(0,10,P.tN);
        
        [~,yy] = P.ode(P.tdata,[P.y0],P.k,[],[P.ode_reltol,P.ode_abstol,P.tdata(end)]);
        figure(2)
        plot(P.tdata,yy([1 2],:),'.-')
        P.ydata = yy(P.species,:)';
               
    case 2
        P.ode=@dxdt_M2_mex;
        P.dxdp=@dxdp_M2;
        P.gradode = '';
        P.lapode = '';
        structdxdt_M2
        P.mStructdxdt = mStructdxdt;
        P.k=[0.6 0.4 0.1];
        P.y0=[1;0;4;0];
        P.tN=15;
        P.species=[1 4];
        P.sigma = 0.1;
        P.logscale = [1 1 1];
        P.pdim = 3;
        P.xdim = 4;
        
        P.paramspec = {
            {'k_{+1}', log(P.k(1)), log(P.k(1))-5,log(P.k(1))+5}
            {'k_{-1}', log(P.k(2)), log(P.k(2))-5,log(P.k(2))+5}
            {'k_{2}', log(P.k(3)), log(P.k(3))-5,log(P.k(3))+5}
            };
        
        P.tdata=linspace(0,10,P.tN);
        
        [~,yy] = P.ode(P.tdata,[P.y0],P.k,[],[P.ode_reltol,P.ode_abstol,P.tdata(end)]);
        figure(2)
        plot(P.tdata,yy([1 2],:),'.-')
        P.ydata = yy(P.species,:)';
        
    case 3
        P.ode=@dxdt_M1_mex;
        P.dxdp=@dxdp_M1;
        P.dxdpdp=@dxdpdp_M1;
        structdxdt_M1
        P.mStructdxdt = mStructdxdt;
        P.k=[0.6 0.4];
        P.y0=[1;0]; 
        P.tN=11;
        P.species=2;
        P.sigma=0.015;
        P.logscale = [1 1];
        P.pdim = 2;
        P.xdim = 2;
        
        P.paramspec = {
            {'k_{+1}', log(P.k(1)), 1e-3,1e1}
            {'k_{-1}', log(P.k(2)), 1e-3,1e1}
            };
            
        P.tdata=linspace(0,10,P.tN);
        
        P.ydata=[0.0244;
            0.0842;
            0.1208;
            0.1724;
            0.2315;
            0.2634;
            0.2831;
            0.3084;
            0.3079;
            0.3097;
            0.3324;];
end

% true parameters




drawnow

%% 1.2 Interpolation area

P.method_thresh = 1;
% 1: hard cutoff relative to maximum

% confidence level defining spawing cutoff
P.alpha = 0.99;

% hard cutoff value 
P.rem_thresh = 1e-100;

%% 1.3 Initial Particle Guess

% method for spawning particles
P.init_method = 1;
% 1: single point at modes
% 2: lattice

P.init_lattice = 1;
% 1: Zn
% 2: An
% 3: Dn

% lattice scaling
P.init_latt_d = 3;

P.init_trans = 1;
% 1: Identity matrix
% 2: Fisher Matrix based on Gradient
% 2: Fisher Matrix based on Hessian


% initial grid spacing
P.init_d0 = 0.3;
P.init_D0 = 0.5;

%% 1.4 Adaptive Grid

% method for adapting the grid
P.adap_method = 1;
% 1: local monitor function with function value


% spawning method
P.adap_spawn_method = 2;
% 1: randomly in small neighborhood
% 2: randomly in small neighborhood with mean weighting

P.adap_spawn_var = true;
% true: normalize to local radius 1
% false: normalize randomly between local radius 1/2 and rstar

% fusion method
P.adap_fusion_method = 1;
% 1: where particles are too close to each other
% 2: no fusion

% after how many iterations to start cohesive gradient?
P.adap_gradient_start = 1;

% settings for linesearch
P.opts=optimset('TolFun',1e-4,'TolX',1e-4);


% potential function
P.pot = @(r,rstar) V1(r,rstar);
P.dpot = @(r,rstar) dV1(r,rstar);

% lower mesh bound
P.adap_d0 = 0.3;

% upper mesh bound
P.adap_D0 = 1;

% flag for finding Nsize
P.finding_Nsize = false;

% relative neighborhood size
P.adap_rstar = sqrt(2);

% relative gradient influence radius
P.adap_gradr = sqrt(4);

% relative optimal distance tolerance
P.adap_dc = 2.5;

% number of gradient steps
P.adap_ngradstep = 1;

% number of iterations after which to start gradient steps
P.grad_iter = 0;

% whether to switch to on first occasion where no spawning happens
P.switch_fusion_off = true;

% number of consecutive iterations where no spawning happens.
P.switch_hits = 3;

%% 1.5 Kernel

% kernel
P.kernel = 1;
% 1: gaussian

% anisotropic transformation
P.kernel_aniso = 2;
% 1: isotropic
% 2: global anisotropic
% 3: local anisotropic

P.kernel_aniso_method = 2;
% 1: covariance
% 2: covariance with function value

% steps until update of covariance matrix
P.cov_iter = 150;

% shape parameter
P.kernel_shape = 1;
% 1: global;
% 2: local;

% method for matrix invers
P.kernel_inverse = 1;
% 1: ldivide
% 2: riley
P.riley_mu = 1e-11;

% method for error estimation
P.error_estim = 1;
% 1: Rippa's Method
% 2: Error on particles
% 3: Condition of Interpolation

% tolerance how close to get to machine precision
P.cond_tol = 1e1;

% minimum value for shape parameter
P.kernel_eps_min = 0;
% maximum value for shape parameter
P.kernel_eps_max = 1e5;

%% 1.6 Visualisation
P.vsx = 4;
P.vsy = 4;
P.vsT = 15;
P.vsN = 30;

[P.VX,P.VY] = meshgrid(linspace(-P.vsx,P.vsx,P.vsN),linspace(-P.vsy,P.vsy,P.vsN));
P.Xv = [P.VX(:),P.VY(:)];

% number of iterations between plots
P.plotinter = 50;

% whether to plot
P.plotflag = true;

% maximum number of particle refinements
P.max_iter = 150;
