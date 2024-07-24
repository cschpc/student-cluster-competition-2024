#!/bin/bash
#SBATCH --account=project_462000565
#SBATCH --job-name=rocHPL_team2b
#SBATCH --time=10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-gpu=7
#SBATCH --gpus-per-node=8
#SBATCH --partition=dev-g
#SBATCH --mem=0
#SBATCH --exclusive

export MPICH_GPU_SUPPORT_ENABLED=1
srun rochpl -P 8 -Q 1 -p 8 -q 1 -N 128000 --NB 512
