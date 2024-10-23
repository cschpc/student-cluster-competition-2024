#!/bin/bash

#SBATCH -A project_462000007
#SBATCH --time=0:45:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --gpus-per-node=8
#SBATCH --cpus-per-task=7
#SBATCH --mem=0 
#SBATCH --partition=dev-g

export HPL_PLATFORM=LUMI

export MPICH_GPU_SUPPORT_ENABLED=1

# loop over split fraction parameters
for f in 0.4 0.5 0.6 0.7
do
# run each case 5 times
for i in {1..5}
do
out=hpl_out_${i}_n${SLURM_NNODES}_f_${f}.${SLURM_JOBID}.txt
srun --cpu-bind=none build/bin/run_rochpl -P 4 -Q 2 -p 4 -q 2 -N 256000 --NB 512 -f ${f} > $out 2>&1
cp HPL.out HPL.out_${i}_n${SLURM_NNODES}_f_${f}.${SLURM_JOBID}
done
done
