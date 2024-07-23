#!/bin/bash
#SBATCH --account=project_462000565
#SBATCH --job-name=rocHPCG_team2_pinned
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-gpu=7
#SBATCH --gpus-per-node=8
#SBATCH --partition=small-g
#SBATCH --exclusive
#SBATCH --mem-per-gpu=60g

cat << EOF > select_gpu
#!/bin/bash

export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
exec \$*
EOF

chmod +x ./select_gpu

CPU_BIND="map_cpu:49,57,17,25,1,9,33,41"

export MPICH_GPU_SUPPORT_ENABLED=1

srun --cpu-bind=${CPU_BIND} ./select_gpu ./rochpcg-0.8.3
rm -rf ./select_gpu
