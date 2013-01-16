%% Model 1
clear mStructdxdt
structdxdt_M1
odeInput = 'dxdt_M1.m';
dependencies = {};

%% M1 Without Sensitivities

options = cParserSet( 'blockSize', 5000);
convertToC( mStructdxdt, odeInput, dependencies, options );
compileC( 'dxdt_M1_mex' )

% M1 With Sensitivities

options = cParserSet( 'blockSize', 5000, 'aJac', 1);
convertToC( mStructdxdt, odeInput, dependencies, options );
compileC( 'dxdt_M1S_mex' )

%% Model 2
clear mStructdxdt
structdxdt_M2
odeInput = 'dxdt_M2.m';
dependencies = {};

%% M2 Without Sensitivities

options = cParserSet( 'blockSize', 5000);
convertToC( mStructdxdt, odeInput, dependencies, options );
compileC( 'dxdt_M2_mex' )

%% M2 With Sensitivities

options = cParserSet( 'blockSize', 5000, 'aJac', 1);
convertToC( mStructdxdt, odeInput, dependencies, options );
compileC( 'dxdt_M2S_mex' )

