#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=hpl_4_hex
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=32
#SBATCH --partition=medium

srun xhpl
