MATLAB="/Applications/MATLAB_R2012b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/schaluck/.matlab/R2012b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for calcDp" > calcDp_mex.mki
echo "CC=$CC" >> calcDp_mex.mki
echo "CFLAGS=$CFLAGS" >> calcDp_mex.mki
echo "CLIBS=$CLIBS" >> calcDp_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> calcDp_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> calcDp_mex.mki
echo "CXX=$CXX" >> calcDp_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> calcDp_mex.mki
echo "CXXLIBS=$CXXLIBS" >> calcDp_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> calcDp_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> calcDp_mex.mki
echo "LD=$LD" >> calcDp_mex.mki
echo "LDFLAGS=$LDFLAGS" >> calcDp_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> calcDp_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> calcDp_mex.mki
echo "Arch=$Arch" >> calcDp_mex.mki
echo OMPFLAGS= >> calcDp_mex.mki
echo OMPLINKFLAGS= >> calcDp_mex.mki
echo "EMC_COMPILER=" >> calcDp_mex.mki
echo "EMC_CONFIG=optim" >> calcDp_mex.mki
"/Applications/MATLAB_R2012b.app/bin/maci64/gmake" -B -f calcDp_mex.mk
