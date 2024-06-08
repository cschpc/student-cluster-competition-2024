#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=hpl_128_hex
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --partition=medium

srun xhpl
