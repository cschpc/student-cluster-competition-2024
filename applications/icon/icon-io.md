# I/O in ICON

ICON performs in principle two different types of output:
- Relevant model fields for analysis
- Checkpoint/restart data

## Checkpoint/restart

Restart/checkpoint data contains all the model fields, and allows one to continue 
the simulation from the model state written to the disk. Checkpoint and restart mechanism write the same data, but serve different purposes: checkpoint is for resuming if job fails in the middle of the simulation e.g. due to hardware failure. Restarting allows one to perform the simulation in pieces. Often batch job system allows single job run to only e.g. 48 hours, but decade long climate simulation might require much longer time. ICON and ICON runscripts implement a mechanism where a job is submitted again when `restart_interval` is reached, and model starts from the state written to the disk. 

Example settings in a runscript:
```
# start and end date+time
start_date=${start_date:="2020-01-20T00:00:00Z"}
    end_date=${end_date:="2020-02-19T00:00:00Z"}

# restart intervals
checkpoint_interval="P5D"
restart_interval="P10D"
```
Here, the whole model duration is 30 simulated days. Checkpoint data is written after
every 5 simulated days, and model would be restarted after every 10 simulated days, i.e. the whole model run would be done in three steps. 

## Model output

Model output is defined in one or more `output_nml` namelists. Each `output_nml` definition corresponds to a single output file, and specify different fields (normally in `ml_varlist` variable). Single file can contain data from multiple time steps. Number of time steps in a file can be defined in two ways: 
```
&output_nml
...
 steps_per_file   = ${steps_per_file}  ! Each file will contain steps_per_file time steps
```
```
...
output_interval="PT4M"
file_interval="PT8M"
...
&output_nml
...
 output_interval  = "${output_interval}"
 file_interval    = "${file_interval}" 
...
```
Here, output is written after every 4 simulated minutes, and a new file created after every 8 simulated minutes, i.e. each file would contain two time steps.

## Asynchronous parallel I/O

ICON can use subset of processes for I/O, and have these to perform the writing to disk while the "worker" processes are computing, *i.e.* overlapping computation and I/O. Worker processes still need to communicate the data to I/O processes, but as writing the disk is typically much slower than communication, asynchronous parallel I/O can be improve performance a lot especially in very large scale simulations.

Number of I/O and restart processes are specified in `parallel_nml` namelist:
```
&parallel_nml
...
 num_io_procs = 1
 num_restart_procs = 1
/
```
The division into worker and I/O processes is shown in the LOG output. As an example,
with above settings a batch job like 
```
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=32
#SBATCH --cpus-per-task=2
```
would show in the LOG output following:
...
ICON runs on 64 mpi processes.
...
 set_mpi_work_communicators: Number of procs for test: 0, work: 62, I/O: 1, Restart: 1, Prefetching: 0
 set_mpi_work_communicators:  0 <=  0  test procs <  0  <=  62  work procs <  62  <=  1  io procs <  63  <=  1  restart procs <  64  <=  0  pref procs <  64  <=  0  radario procs <  64

```

Slurm places by default the processes to the nodes in blocks, i.e. in the above example processes 0-31 would be in the first node, and processes 32-63 in the second node. Thus, there would be 32 workers in the first node, but only 30 workers in the second node. 

In order to better balance worker, I/O, and restart processes, one can specify different process distribution for Slurm with `-m` option for `srun`. Here, "cyclic" would be most appropriate, i.e. placing the consecutive processes to consecutive nodes in round-robin fashion. In the above example, process 0 would be in the first node, process 1 in the second node, etc. In the context of ICON runscript, the option would go to `START` variable, i.e.

```
...
# how to start the icon model
# ---------------------------
export START="srun  -m cyclic" 
...
```

Benefit of asynchronous I/O, and whether it is useful only for model output, only for 
restart/checkpointing, or for both should always be investigated. Runscripts might have varying settings for the amount of timing information, and restart writes
(`write_restart`) is not shown by default. One can increase timing information by adding/modifying `timers_level` variable in `&run_nml` namelist:
```
&run_nml
 num_lev          = 47          ! number of full levels
...
 output           = 'nml'
 timers_level        = 10   
 msg_level        = 15          ! level of details report during integration 
...
```

