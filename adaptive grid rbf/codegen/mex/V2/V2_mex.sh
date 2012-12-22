MATLAB="/Applications/MATLAB_R2012b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/schaluck/.matlab/R2012b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for V2" > V2_mex.mki
echo "CC=$CC" >> V2_mex.mki
echo "CFLAGS=$CFLAGS" >> V2_mex.mki
echo "CLIBS=$CLIBS" >> V2_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> V2_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> V2_mex.mki
echo "CXX=$CXX" >> V2_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> V2_mex.mki
echo "CXXLIBS=$CXXLIBS" >> V2_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> V2_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> V2_mex.mki
echo "LD=$LD" >> V2_mex.mki
echo "LDFLAGS=$LDFLAGS" >> V2_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> V2_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> V2_mex.mki
echo "Arch=$Arch" >> V2_mex.mki
echo OMPFLAGS= >> V2_mex.mki
echo OMPLINKFLAGS= >> V2_mex.mki
echo "EMC_COMPILER=" >> V2_mex.mki
echo "EMC_CONFIG=optim" >> V2_mex.mki
"/Applications/MATLAB_R2012b.app/bin/maci64/gmake" -B -f V2_mex.mk
