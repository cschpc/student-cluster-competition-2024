# Exercises

## Process and thread affinity

In this exercise you can investigate how processes and threads are bind to CPU cores and
how various Slurm and OpenMP settings can affect that.

1. Download a simple affinity test code with `git clone` under your personal scratch space:
```
git clone https://github.com/cschpc/affinity.git
```
2. Build the code along the instructions in the main `README.md` in the repositoty.
3. Run the code with different combinations of `--ntasks-per-node` and `--cpus-per-task` Slurm settings, as well with different settings of `OMP_NUM_THREADS` and `OMP_PLACES` environment variables


**Note**: It is highly recommended that when ever you start to work on a new HPC system
you investigate how process and thread binding work there.

## Installing and running HPL

Next, we want to install HPL to our own working environment and run it.  
This exercise will be done in pairs.  

1. Download the HPL source code to Mahti
    - Go into our working directory `/scratch/project_2009905/$USER`
    - Download the code there with: `wget https://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz`
2. Unzip the tar file
    - `tar xvzf hpl-2.3.tar.gz`
3. Create a config file for your environment
    - ```
      cd hpl/setup
      sh make_generic
      cp Make.UNKNOWN ../Make.mahti
      cd ../
      ```
4. Modify the following lines in the file `Make.mahti` to correspond to our environment
    - ```
      ARCH         = mahti
      TOPdir       = /scratch/project_2009905/$USER/hpl-2.3
      MPinc        = /appl/spack/v017/install-tree/gcc-11.2.0/openmpi-4.1.2-h6c3ze/include      
      MPlib        = /appl/spack/v017/install-tree/gcc-11.2.0/openmpi-4.1.2-h6c3ze/lib/libmpi.so
      LAinc        = /appl/spack/v017/install-tree/gcc-11.2.0/openblas-0.3.18-eb6g7n/include
      LAlib        = -lopenblas
      LINKFLAGS    = -fopenmp
      ```
5. Compile the code
    - `make arch=mahti -j 4`
6. Modify `HPL.dat`
    - Executable can be found under `/bin/mahti`
    - An example [HPL.dat](./HPL.dat) file can be found in the exercise directory
7. Create a Slurm script and run HPL
    - An example sh script can be found from last week's exercise folder [example_slurm_job.sh](../../02-compiling_and_parallelism/exercises/example_slurm_cpu_job.sh)
    - Modify the total `ntasks` to be equal to `P * Q` in your HPL.dat file
