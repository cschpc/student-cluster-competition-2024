#!/bin/bash
#SBATCH --account=project_462000565
#SBATCH --job-name=rocHPCG_team2
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-gpu=8
#SBATCH --gpus-per-node=1
#SBATCH --partition=small-g

export MPICH_GPU_SUPPORT_ENABLED=1
srun rochpcg-0.8.3
