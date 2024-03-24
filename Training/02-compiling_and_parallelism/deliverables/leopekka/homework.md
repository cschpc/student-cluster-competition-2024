# Example deliverable

1. When I ran the program it printed out:

```
Hello world!
```

2. My Slurm job script was the following:

```
#!/bin/bash
#SBATCH --account=project_2009905
#SBATCH --job-name=leopekkas_job
#SBATCH --time=0:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=X
#SBATCH --partition=test

srun my_exe
```
