MATLAB="/Applications/MATLAB_R2012b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/schaluck/.matlab/R2012b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for Riley" > Riley_mex.mki
echo "CC=$CC" >> Riley_mex.mki
echo "CFLAGS=$CFLAGS" >> Riley_mex.mki
echo "CLIBS=$CLIBS" >> Riley_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> Riley_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> Riley_mex.mki
echo "CXX=$CXX" >> Riley_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> Riley_mex.mki
echo "CXXLIBS=$CXXLIBS" >> Riley_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> Riley_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> Riley_mex.mki
echo "LD=$LD" >> Riley_mex.mki
echo "LDFLAGS=$LDFLAGS" >> Riley_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> Riley_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> Riley_mex.mki
echo "Arch=$Arch" >> Riley_mex.mki
echo OMPFLAGS= >> Riley_mex.mki
echo OMPLINKFLAGS= >> Riley_mex.mki
echo "EMC_COMPILER=" >> Riley_mex.mki
echo "EMC_CONFIG=optim" >> Riley_mex.mki
"/Applications/MATLAB_R2012b.app/bin/maci64/gmake" -B -f Riley_mex.mk
