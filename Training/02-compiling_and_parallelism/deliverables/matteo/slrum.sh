#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=heat_equation
#SBATCH --time=0:01:00
#SBATCH --nodes=n
#SBATCH --ntasks-per-node=128
#SBATCH --partition=medium heat_mpi

srun heat_mpi
