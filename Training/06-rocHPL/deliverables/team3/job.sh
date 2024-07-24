#!/bin/bash
#SBATCH --job-name=exampleJob
#SBATCH --account=project_462000565
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=7 
#SBATCH --gpus-per-node=8
#SBATCH --mem=480G
#SBATCH --partition=dev-g
#SBATCH --exclusive

export CXX=CC
export HIPCXX=CC
export MPICH_GPU_SUPPORT_ENABLED=1
module load LUMI/23.09
module load partition/G
module load rocm


srun --cpu-bind=none /scratch/project_462000565/team3ROC/rocHPL/build/run_rochpl -P 8 -Q 1 -p 8 -q 1 -N 253440 --NB 512

