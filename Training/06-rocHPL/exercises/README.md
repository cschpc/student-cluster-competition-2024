# Benchmarking with rocHPL

### Task 1: Install the HPL benchmark  

The following are the basic steps you need to take as a team:

1. Create a folder under the path `/scratch/project_462000565/` where each team member has access
2. Download [rocHPL](https://github.com/ROCm/rocHPL) into the working folder
3. Load the following modules into your session: `LUMI/23.09`, `partition/G`, `rocm`
4. Install HPL
    - Remember to export the cray compiler wrappers into your environment first with `export CXX=CC` and `export HIPCXX=CC`
    - You need to specify the system's MPI installation path again during this  
    - Write down the command you used for installing HPL
5. Let the advisor know when you reach this step and Wait for the next instructions

### Task 2: Run HPL on a single LUMI-G node

1. Navigate into the `build` directory
2. Choose to either use a HPL.dat file, or run HPL via the command line as instructed
3. Run a basic test, at max a few minutes long on just **one GPU**.
    - Run HPL via Slurm. For an example script, find the [https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/](LUMI docs)
    - The executable `run_rochpl` will appear under the `build` path by default
    - Include the environment variable `MPICH_GPU_SUPPORT_ENABLED=1` in your Slurm script/srun command 
    - Use the slurm command `--cpu-bind=none` when working with the `run_rochpl` wrapper
    - Write down your results
4. Include the full 4 GPUs on a LUMI-G node
    - *Note!* Slurm disbatches Lumi's GPU's in halves, so include 8 gpus in the slurm job script
    - Aim for a result that's over 50% of the theoretical peak (191,6 TFLOPS)
    - Write down your results

## Deliverable

Document the following aspects:

1. The command you used for installing HPL?
2. The best result your team got with one GPU in use? (GFLOPS)
3. The best result on the fully utilized LUMI-G node? (GFLOPS)
4. How do the results compare to the "theoretical peak" of 191,6 TFLOPS for the 4 GPUs in the node [(source)](https://www.amd.com/en/products/accelerators/instinct/mi200/mi250x.html)? What is the percentage of the results from the theoretical peak?
5. Collect the results into the `deliverables` folder in GitHub
6. Return the Slurm script you used during your best run into GitHub, under the `deliverables` folder

## Notes and tips

- The paths where specific modules in LUMI are installed can be queried with the `module show [module]` command
- The local matrix size should take up as much memory as possible, without overloading it
    - - An MI250X has a local memory of 128GB (or 64GB in "halves") [source](https://www.amd.com/en/products/accelerators/instinct/mi200/mi250x.html)
- You can check the GPU utilization of the node you're running on with the `rocm-smi` command
    - See [LUMI user guide](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/interactive/#using-srun-to-check-running-jobs) for instructions for logging into a compute node
    - In some systems (e.g. Mahti and Puhti) one can also directly ssh into the compute node shown by `squeue`
