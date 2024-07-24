git clone https://github.com/ROCm/rocHPL.git
cd rocHPL
module load LUMI/23.09 partition/G rocm
export CXX=CC
export HIPCXX=CC
./install.sh --with-mpi=$CRAY_MPICH_DIR
