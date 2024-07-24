# Example for installing rocHPL on LUMI

## Step 1: Installing rocHPL

1. Load the correct modules and export the compiler wrappers
    - `module load LUMI/23.09 partition/G rocm`
    - `export CXX=CC`, `export HIPCXX=CC`
2. Download rocHPL
    - `git clone https://github.com/ROCm/rocHPL.git`
3. Installation
    - ```
       cd rocHPL
       ./install.sh --with-mpi=$MPICH_DIR
      ```

## Step 2. Running rocHPL

1. Running with the "run_rochpl" wrapper
    - ```
      cd build
      MPICH_GPU_SUPPORT_ENABLED=1 srun --exclusive -N1 --ntasks-per-node=8 --cpus-per-task=7 --gpus-per-node=8 --partition=dev-g --account=project_462000565 --time=00:10:00 --mem=0 --cpu-bind=none ./run_rochpl -P 2 -Q 4 -N 256000 --NB 512
      ```
2. Running with just the rochpl binary
    - ```
      cd build/bin
      MPICH_GPU_SUPPORT_ENABLED=1 srun --exclusive -N1 --ntasks-per-node=8 --cpus-per-task=7 --gpus-per-node=8 --partition=dev-g --account=project_462000565 --time=00:10:00 --mem=0 ./rochpl -P 2 -Q 4 -p 2 -q 4 -N 256000 --NB 512
      ```
## Results

Results for both runs are included in this folder.  

## Optional steps

You can run rocHPL through a Slurm script too, which is provided in this folder.  
The "run_rochpl" wrapper doesn't seem to work when ran through a slurm script, due to the `cpu-bind=none` option not registering. I will look into this.


