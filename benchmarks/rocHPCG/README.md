# rocHPCG benchmark

## Building

The CMake setup needs a small tinkering in Cray programming environment, a patch [CMakeLists.patch](CMakeLists.patch) is included here.
RocHPCG can be build either with or without GPU-aware MPI, the build script [build.sh](build.sh) has both variants but the other one 
commented out. Generally, GPU-aware MPI is expected to give a little bit better performance.

How to build:
```
git clone https://github.com/ROCm/rocHPCG.git
cd rocHPCG
# copy the patch and build script here
#apply patch
git apply CMakeLists.patch
. build.sh
```

## Running

Basic example (probably a larger grid than 256x256x256 should be used)
```
MPICH_GPU_SUPPORT_ENABLED=1 srun -N 1 --ntasks-per-node=2 ./build/release/bin/rochpcg 256 256 256 60
```
See README.md in rocHPCG repo for additional guidelines
