#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=heat_mpi_kim2
#SBATCH --time=0:01:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=128
#SBATCH --partition=test

srun /scratch/project_2009905/kitakita/heat-equation/3d/mpi/heat_mpi
