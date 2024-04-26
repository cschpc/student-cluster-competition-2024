#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=heat_mpi_kim3
#SBATCH --time=0:01:00
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=128
#SBATCH --partition=medium

srun /scratch/project_2009905/kitakita/heat-equation/3d/mpi/heat_mpi
