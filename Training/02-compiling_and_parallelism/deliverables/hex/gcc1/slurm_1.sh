#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=heat_mpi_1_hex
#SBATCH --time=0:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --partition=medium

srun heat_mpi
