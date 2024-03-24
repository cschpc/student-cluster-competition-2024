#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=myjob
#SBATCH --time=0:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --partition=test
#SBATCH --reservation=scc-cpu

srun my_exe
