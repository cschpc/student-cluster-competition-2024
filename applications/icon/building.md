Clone the latest stable branch/tag, as some external dependencies come as git submodules fetch also them:

`git clone --recurse-submodules -b release-2024.07-public https://gitlab.dkrz.de/icon/icon-model.git`

install eccodes
`pip install eccodes`

building netcdf
`wget -c https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.9.2.tar.gz -O - | tar -xz`
`export FC=gfortran`
`./configure --prefix=/home/kitakita/NETCDF --disable-hdf5`

Copy the config scripts from SCC repo (icon-scc24/config/csc/scc24...) to config/csc under icon-model

Then:

```
cd icon-model
mkdir build-cpu
cd build-cpu
../config/csc/scc24.cpu.cce-18.0.0
make -j3
```
