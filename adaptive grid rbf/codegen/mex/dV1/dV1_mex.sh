MATLAB="/Applications/MATLAB_R2012b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/schaluck/.matlab/R2012b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for dV1" > dV1_mex.mki
echo "CC=$CC" >> dV1_mex.mki
echo "CFLAGS=$CFLAGS" >> dV1_mex.mki
echo "CLIBS=$CLIBS" >> dV1_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> dV1_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> dV1_mex.mki
echo "CXX=$CXX" >> dV1_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> dV1_mex.mki
echo "CXXLIBS=$CXXLIBS" >> dV1_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> dV1_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> dV1_mex.mki
echo "LD=$LD" >> dV1_mex.mki
echo "LDFLAGS=$LDFLAGS" >> dV1_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> dV1_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> dV1_mex.mki
echo "Arch=$Arch" >> dV1_mex.mki
echo OMPFLAGS= >> dV1_mex.mki
echo OMPLINKFLAGS= >> dV1_mex.mki
echo "EMC_COMPILER=" >> dV1_mex.mki
echo "EMC_CONFIG=optim" >> dV1_mex.mki
"/Applications/MATLAB_R2012b.app/bin/maci64/gmake" -B -f dV1_mex.mk
