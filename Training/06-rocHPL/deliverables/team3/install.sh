module load LUMI/23.09 partition/G rocm
export CXX=CC
export HIPCXX=CC
cd rocHPL && sh ./install.sh --with-mpi=$MPICH_DIR
