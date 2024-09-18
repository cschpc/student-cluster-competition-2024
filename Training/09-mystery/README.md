# Mystery application: GPAW

Your task here is to install and run GPAW in LUMI-C.

## Description

GPAW is a density-functional theory (DFT) code based on the projector-augmented wave (PAW) method and various basis sets. The wave functions can be described with:

    - Uniform real-space grids
    - Plane waves
    - Localized atomic orbitals

GPAW is implemented in Python and C programming languages and it relies on high performance libraries for linear algebra operations, FFTs, etc.

Parallelization is primarily with MPI, complementary OpenMP parallelization can improve the performance in some cases.

A more detailed description can be found in [GPAW documentation](https://gpaw.readthedocs.io/index.html).

## Installation

Look for the general installation instructions in GPAW documentation.

Here are few more detailed tips:

### Installing LibXC

Libxc can be installed as follows:
```
wget https://gitlab.com/libxc/libxc/-/archive/6.2.2/libxc-6.2.2.tar.bz2
tar -xf libxc-6.2.2.tar.bz2
cd libxc-6.2.2
./configure --enable-shared --disable-fortran --prefix=some_install_base/libxc-6.2.2
make
make install
export CPATH=$CPATH:some_install_base/libxc-6.2.2/include
export LIBRARY_PATH=$LIBRARY_PATH:some_install_base/libxc-6.2.2/lib
```

### Installing GPAW

Use the latest stable release that can be cloned as:
```
git clone -b 24.6.0 https://gitlab.com/gpaw/gpaw.git
cd gpaw
```

For building GPAW, use GNU compilers (`PrgEnv-gnu`). Cray provides a Python environment
which has most of the requirements included in the module `cray-python`.

By default GPAW looks for BLAS library libblas in the default locations, and if it is available installation can be done at simplest with:
```
export PYTHONUSERBASE=some_installation_root
pip3 install --user --verbose .
```

For some testing one should install also the optional pytest package:
```
pip3 install --user pytest
```

By default, the same compiler and compiler options as when building the Python interpreter are used. In HPC systems it is, however, often recommended to  customize the installation in order to use other libraries, compilers or compiler options. This can accomplished via siteconfig.py file, sample file is provided in siteconfig_example.py. As an example, in order to use icc compiler with extra optimization flags and MKL BLAS library one should add into siteconfig.py:
```
# compiler
mpi =True
compiler = 'mpiicc'
extra_compile_args = ['-O2', '-xHost', '-qopenmp']
extra_link_args = ['-qopenmp']

# MKL
libraries += ['mkl_rt']
```

One should also set the GPAW_CONFIG corresponding to this siteconfig.py file:
```
export GPAW_CONFIG=$PWD/siteconfig.py
```
and proceed then with pip3 install …. (Note: `siteconfig.py` can be also named
differently when playing with different installation options, i.e.
`siteconfig_intel.py`, `siteconfig_gcc.py` … )

More information about customizing the installation can be found in GPAW documentation

Once the installation is complete, the PATH variable needs to be set for GPAW binaries:
```
export PATH=$PATH:$PYTHONUSERBASE/bin
```
Finally, one needs to install the PAW datasets
```
gpaw install-data $HOME/gpaw-setups
```

## Testing the installation

Once installation is complete and PYTHONUSERBASE and PATH are set, one can check the installation information as:
```
gpaw info
 ------------------------------------------------------------------------------------------------------------------------------------------------
| python-3.11.7     /opt/cray/pe/python/3.11.7/bin/python
...
```
Next, one should make short serial test calculation
```
gpaw test
```
followed by short parallel calculation
```
srun -n 4 ...  gpaw test
```
GPAW contains also an extensive test set which should be run when developing the code, more details in GPAW documentation.

## Running GPAW

GPAW input files are Python scripts, and once `PYTHONUSERBASE` and `PATH` are set,
calculations can be run as
```
mpirun -np <# proc> gpaw python <input>.py
```

## Tasks

Download input files:
```
git clone https://github.com/jussienko/gpaw-isc-2021.git
```

### 1. Building and running GPAW

Build the code and run the provided input `copper.py` on one, two, and
four nodes using pure MPI parallelization. The text output is in the file output_M_xxx.txt (xxx = number of MPI tasks). Input file has check for the correctness, so there is an error message if the results are wrong. Runtime should be less than 10 minutes with a single node.
Discuss the performance and scalability. No modifications to the input file and source code are allowed.

### 2. Visualization

Run the provided input nanoribbon.py (it is recommended to use one node, running time should be max. few minutes). As a result you will obtain a file named elf_ribbon.cube which contains electron localization function of the simulated system. Make a visualization (picture or animation) of the electron localization function. See e.g.
https://wiki.fysik.dtu.dk/gpaw/tutorialsexercises/wavefunctions/plotting/plot_wave_functions.html
for hints for visualizing .cube files
