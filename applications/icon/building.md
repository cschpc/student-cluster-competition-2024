# Building and running ICON

Clone the fork with Cray compiler workarounds

`git clone https://github.com/cschpc/icon-scc24.git`
cd icon-scc24

## Building CPU version

```
mkdir build-cpu
cd build-cpu
../config/csc/scc24.cpu.cce-18.0.0 2>&1 | tee loki.conf
make -j8 2>&1 | tee loki.make
```

## Building GPU version

Due to serious bugs in CCE 18.0.0, GPU version needs to be build
within a singularity container that has CCE 17.0.1 installed.

Note: the container is not included in the repo, so the container wrapper
`exec.lumi.container.cce` might need to be modified (the `container` variable).

```
mkdir build-gpu
cd build-gpu
# Start a shell inside the container and proceed then normallu
../config/csc/exec.lumi.container.cce bash
../config/csc/scc24.gpu.cce-17.0.1 2>&1 | tee loki.conf
# As there is no rsync in container, config ends with a warning
# See below for rsyncing outside the container
make -j8 2>&1 | tee loki.make
```
Once the build is finished, exit the container with `exit` and run `rsync`s as follows:
```
icon_dir='..'
echo "Copying runscript input files from the source directory..."
rsync -uavz ${icon_dir}/run . --exclude='*.in' --exclude='.*' --exclude='standard_*'
ln -sf -t run/ ${icon_dir}/run/standard_*
rsync -uavz ${icon_dir}/externals . --exclude='.git' --exclude='*.f90' --exclude='*.F90' --exclude='*.c' --exclude='*.h' --exclude='*.Po' --exclude='tests' --exclude='*.mod' --exclude='*.o'
rsync -uavz ${icon_dir}/make_runscripts .
ln -sf ${icon_dir}/data
ln -sf ${icon_dir}/vertical_coord_tables
```

## Running

Create a runscript under corresponding build directory. `name_of_exp` is the part of the filename after `exp.` i.e. `nh_dcmip_tc_52_r2b4`
```
./make_runscript name_of_exp
```
The resulting runscript will reside in the `run` directory.

As the input files are not in standard locations, runscript may need to be modified.
Look for anything with `icon_data` in the name of location.

The GPU version needs to be run under the container, but runscript creation mechanism
(defined in `icon_scc24/run/create_target_header`) should take care of that, i.e. the `START` in runscript should ne something like:
```
export START="srun /home/jenkovaa/icon-scc24/config/csc/exec.lumi.container.cce /home/jenkovaa/icon-scc24/run/run_wrapper/lumi_gpu.sh -n ${SLURM_NTASKS} -o $((SLURM_NTASKS - SLURM_NNODES * 2)) -e"
```
The `lumi_gpu.sh` wrapper is needed so that each MPI process will use different GPU, and it is needed also for I/O processes, see [icon-io.md](icon-io.md) for more details.


Note: some `ihadv_tracer` options seem to be unstable on GPUs, at least `ihadv_tracer = 52` is known to cause problems. If you get runtime error, try to change that to 20 (it should not affect the physics, just a algorithm, so it is probably allowed to change it):
```
&transport_nml
 tracer_names     = 'hus','clw','cli','qr','qs','qg'
 ivadv_tracer     =    3 ,   3 ,   3 ,  3 ,  3 ,  3
 itype_hlimit     =    3 ,   4 ,   4 ,  4 ,  4 ,  4
 ihadv_tracer     =   20 ,   2 ,   2 ,  2 ,  2 ,  2
/
```

Once all the data paths are correct, runscript can be submitted to Slurm:
```
sbatch exp.name_of_exp.run
```
Not that the submission needs to be done under `build_xxx/run`.

The LOG output will be under the `run` directory, the actual output files reside under `build_xxx/experiments/name_of_exp`  

## Tuning possibilities

Most important performance tuning parameters are the general blocking size for the
horizontal grid, `nproma`, and the blocking size for radiation, `nproma_sub`. Normally,
they should be kept the same (which the default is `nproma_sub` is not specified), but  
GPU calculations with large `nproma` may run out of memory if `nproma_sub` is not reduced.
In order to optimize `nproma`, one can look in the LOG output for number of cells:
```
 # cells up to halo level 1: max/min/avg   10432  10432  10432.00
```
Here, 10432 would be the optimal `nproma`

Make sure to check `parallel_nml` section in the runscripts, some experiments may
use hard coded (non-optimal settings).

For CPU runs, optimal `nproma` is typically in the range of 24-48, 32 is good starting guess. For CPU runs, one can try to optimize also the MPI task / OpenMP thread ratio with 1, 2, 4 or OpenMP threads, and MPI tasks per node accordingly (64, 32, 16).

See [icon-io.md](icon-md.io) for tips on I/O tuning.






