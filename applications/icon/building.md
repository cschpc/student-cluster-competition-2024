Clone the latest stable branch/tag, as some external dependencies come as git submodules fetch also them:

`git clone --recurse-submodules https://github.com/cschpc/icon-scc24.git`

install eccodes

`pip install eccodes`

building netcdf
```
wget -c https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.9.2.tar.gz -O - | tar -xz
export FC=gfortran
./configure --prefix=/home/kitakita/NETCDF --disable-hdf5
```

Then:

```
cd icon-scc24
mkdir build-cpu
cd build-cpu
../config/csc/scc24.cpu.cce-18.0.0
make -j3
```
