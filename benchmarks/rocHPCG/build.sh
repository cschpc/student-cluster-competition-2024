#!/bin/bash

# Build inside subshell:
(
        module load cce
	module load PrgEnv-cray
	module load craype-x86-rome
	module load cray-mpich
        module load craype-accel-amd-gfx90a

        mpi_root=$CRAY_MPICH_DIR

        # Use cray wrapper:
        export CXX=CC
        export HIPCXX=CC

       ./install.sh --with-mpi=$mpi_root --gpu-aware-mpi
       #./install.sh --with-mpi=$mpi_root 
)
