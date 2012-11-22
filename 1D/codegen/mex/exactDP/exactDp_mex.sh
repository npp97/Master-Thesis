MATLAB="/Applications/MATLAB_R2012b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/schaluck/.matlab/R2012b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for exactDp" > exactDp_mex.mki
echo "CC=$CC" >> exactDp_mex.mki
echo "CFLAGS=$CFLAGS" >> exactDp_mex.mki
echo "CLIBS=$CLIBS" >> exactDp_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> exactDp_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> exactDp_mex.mki
echo "CXX=$CXX" >> exactDp_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> exactDp_mex.mki
echo "CXXLIBS=$CXXLIBS" >> exactDp_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> exactDp_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> exactDp_mex.mki
echo "LD=$LD" >> exactDp_mex.mki
echo "LDFLAGS=$LDFLAGS" >> exactDp_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> exactDp_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> exactDp_mex.mki
echo "Arch=$Arch" >> exactDp_mex.mki
echo OMPFLAGS= >> exactDp_mex.mki
echo OMPLINKFLAGS= >> exactDp_mex.mki
echo "EMC_COMPILER=" >> exactDp_mex.mki
echo "EMC_CONFIG=optim" >> exactDp_mex.mki
"/Applications/MATLAB_R2012b.app/bin/maci64/gmake" -B -f exactDp_mex.mk
