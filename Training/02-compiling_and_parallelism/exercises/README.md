# Exercises 25.3.

Folder for the exercises during SCC training 25.3.

Example slurm script:

```
#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=myjob
#SBATCH --time=0:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --partition=test
#SBATCH --reservation=scc-cpu

srun my_exe
```

1. Compiling exercise: [compiling](./compiling)  
2. Linking exercises: [linking](./linking)
3. Makefiles: [using_make](./using_make)
