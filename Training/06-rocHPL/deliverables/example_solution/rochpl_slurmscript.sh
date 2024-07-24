#!/bin/bash -l
#SBATCH --job-name=rochpl
#SBATCH --partition=dev-g
#SBATCH --time=00:10:00
#SBATCH --account=project_462000565
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --gpus-per-node=8
#SBATCH --cpus-per-task=7
#SBATCH --exclusive
#SBATCH --mem=0

export MPICH_GPU_SUPPORT_ENABLED=1
srun ./rochpl -P 2 -Q 4 -p 2 -q 4 -N 256000 --NB 512
