MATLAB="/Applications/MATLAB_R2012b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/schaluck/.matlab/R2012b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for distm" > distm_mex.mki
echo "CC=$CC" >> distm_mex.mki
echo "CFLAGS=$CFLAGS" >> distm_mex.mki
echo "CLIBS=$CLIBS" >> distm_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> distm_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> distm_mex.mki
echo "CXX=$CXX" >> distm_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> distm_mex.mki
echo "CXXLIBS=$CXXLIBS" >> distm_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> distm_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> distm_mex.mki
echo "LD=$LD" >> distm_mex.mki
echo "LDFLAGS=$LDFLAGS" >> distm_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> distm_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> distm_mex.mki
echo "Arch=$Arch" >> distm_mex.mki
echo OMPFLAGS= >> distm_mex.mki
echo OMPLINKFLAGS= >> distm_mex.mki
echo "EMC_COMPILER=" >> distm_mex.mki
echo "EMC_CONFIG=optim" >> distm_mex.mki
"/Applications/MATLAB_R2012b.app/bin/maci64/gmake" -B -f distm_mex.mk
