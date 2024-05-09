#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=HPL_KIM
#SBATCH --time=0:59:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --partition=test

srun xhpl
