#!/bin/bash
#SBATCH --job=namd-apoa1-cpu
#SBATCH --error=%x.%J.err
#SBATCH --output=%x.%J.out
#SBATCH --account=project_462000565
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=8
#SBATCH --partition=debug

module use /appl/local/csc/modulefiles
module load namd/3.0

# leave one core per process for communication
(( namd_threads = SLURM_CPUS_PER_TASK - 1))

run_dir=test-cpu-N${SLURM_NNODES}-n${SLURM_NTASKS_PER_NODE}-c${SLURM_CPUS_PER_TASK}-job-${SLURM_JOB_ID}

input_files="apoa1.namd apoa1.psf par_all22_popc.xplor apoa1.pdb par_all22_prot_lipid.xplor"

mkdir $run_dir
cd $run_dir

# Make symbolic links to input files
for f in $input_files
do
  ln -s ../${f} .
done

# Save exact job script and environment
cp $0 slurm_script_$SLURM_JOBID
env | grep SLURM > slurm_env_${SLURM_JOBID}.txt
env | grep OMP > omp_env_${SLURM_JOBID}.txt

srun namd3 +ppn ${namd_threads} apoa1.namd > apoa1.out
