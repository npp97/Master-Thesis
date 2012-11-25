MATLAB="/Applications/MATLAB_R2012b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/schaluck/.matlab/R2012b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for V1" > V1_mex.mki
echo "CC=$CC" >> V1_mex.mki
echo "CFLAGS=$CFLAGS" >> V1_mex.mki
echo "CLIBS=$CLIBS" >> V1_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> V1_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> V1_mex.mki
echo "CXX=$CXX" >> V1_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> V1_mex.mki
echo "CXXLIBS=$CXXLIBS" >> V1_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> V1_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> V1_mex.mki
echo "LD=$LD" >> V1_mex.mki
echo "LDFLAGS=$LDFLAGS" >> V1_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> V1_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> V1_mex.mki
echo "Arch=$Arch" >> V1_mex.mki
echo OMPFLAGS= >> V1_mex.mki
echo OMPLINKFLAGS= >> V1_mex.mki
echo "EMC_COMPILER=" >> V1_mex.mki
echo "EMC_CONFIG=optim" >> V1_mex.mki
"/Applications/MATLAB_R2012b.app/bin/maci64/gmake" -B -f V1_mex.mk
