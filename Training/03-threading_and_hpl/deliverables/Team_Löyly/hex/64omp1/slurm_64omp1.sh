#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=hpl_64omp1_hex
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=64
#SBATCH --cpus-per-task=2
#SBATCH --partition=medium

export OMP_NUM_THREADS=1
srun xhpl
