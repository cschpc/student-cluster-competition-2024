#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=hpl_16omp1_hex
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=8
#SBATCH --partition=medium

export OMP_NUM_THREADS=1
srun xhpl
