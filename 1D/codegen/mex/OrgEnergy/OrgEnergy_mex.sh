MATLAB="/Applications/MATLAB_R2012b.app"
Arch=maci64
ENTRYPOINT=mexFunction
MAPFILE=$ENTRYPOINT'.map'
PREFDIR="/Users/schaluck/.matlab/R2012b"
OPTSFILE_NAME="./mexopts.sh"
. $OPTSFILE_NAME
COMPILER=$CC
. $OPTSFILE_NAME
echo "# Make settings for OrgEnergy" > OrgEnergy_mex.mki
echo "CC=$CC" >> OrgEnergy_mex.mki
echo "CFLAGS=$CFLAGS" >> OrgEnergy_mex.mki
echo "CLIBS=$CLIBS" >> OrgEnergy_mex.mki
echo "COPTIMFLAGS=$COPTIMFLAGS" >> OrgEnergy_mex.mki
echo "CDEBUGFLAGS=$CDEBUGFLAGS" >> OrgEnergy_mex.mki
echo "CXX=$CXX" >> OrgEnergy_mex.mki
echo "CXXFLAGS=$CXXFLAGS" >> OrgEnergy_mex.mki
echo "CXXLIBS=$CXXLIBS" >> OrgEnergy_mex.mki
echo "CXXOPTIMFLAGS=$CXXOPTIMFLAGS" >> OrgEnergy_mex.mki
echo "CXXDEBUGFLAGS=$CXXDEBUGFLAGS" >> OrgEnergy_mex.mki
echo "LD=$LD" >> OrgEnergy_mex.mki
echo "LDFLAGS=$LDFLAGS" >> OrgEnergy_mex.mki
echo "LDOPTIMFLAGS=$LDOPTIMFLAGS" >> OrgEnergy_mex.mki
echo "LDDEBUGFLAGS=$LDDEBUGFLAGS" >> OrgEnergy_mex.mki
echo "Arch=$Arch" >> OrgEnergy_mex.mki
echo OMPFLAGS= >> OrgEnergy_mex.mki
echo OMPLINKFLAGS= >> OrgEnergy_mex.mki
echo "EMC_COMPILER=" >> OrgEnergy_mex.mki
echo "EMC_CONFIG=optim" >> OrgEnergy_mex.mki
"/Applications/MATLAB_R2012b.app/bin/maci64/gmake" -B -f OrgEnergy_mex.mk
