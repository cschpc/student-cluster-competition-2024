# Benchmarking with rocHPL

###Task 1: Install the HPL benchmark on LUMI

The following are the basic steps you need to take as a team:

1. Create a folder under the path `/scratch/project_462000565/` where each team member has access
2. Download [rocHPL](https://github.com/ROCm/rocHPL) into the working folder
3. Load the following modules into your session: `LUMI/23.09`, `partition/G`, `rocm`
4. Install HPL
    - Remember to export the cray compiler wrappers into your environment first with `export CXX=CC` and `export HIPCXX=CC`
    - You need to specify the system's MPI installation path during this step  
    - Write down the command you used for installing HPL
5. Let the advisor know you're finished and wait for the next instructions

###Task 2: Run HPL on a single LUMI-G node

1. Decide whether you want to use a HPL.dat input file or run HPL via the run command
2. Navigate into the build directory and prepare a basic Slurm script for running HPL
    - For an example script, find: [https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/](LUMI docs)
    - Use the wrapper `run_rochpl` for running the program
    - Include the environment variable `MPICH_GPU_SUPPORT_ENABLED=1` in your Slurm script/srun command
    - Include the Slurm flag `--cpu-bind=none` when using the wrapper
3. Run a basic test, at max a few minutes long on just **one GPU**
    - *Note!* Slurm disbatches Lumi's MI250X GPUs in halves, so include 2 gpus in the slurm job script 
    - Write down your results
4. Include the full 4 MI250X GPUs on a LUMI-G node
    - Aim for a result of over 50% of the theoretical peak (191,6 TFLOPS)
    - Write down your results

## Deliverable

Document the following aspects:

1. The command you used for installing HPL?
2. The best result your team got with one GPU in use? (GFLOPS)
3. The best result on the fully utilized LUMI-G node? (GFLOPS)
4. How do the results compare to the "theoretical peak" of 191,6 TFLOPS for the 4 GPUs in the node [(source)](https://www.amd.com/en/products/accelerators/instinct/mi200/mi250x.html)? What is the percentage of the results from the theoretical peak?
5. The Slurm script you used for running your test at step 4
6. Collect the results into the `deliverables` folder in GitHub

## Notes and tips

- The paths where specific modules in LUMI are installed can be queried with the `module show [module]` command
- LUMI's MI250X GPU's have 128GB of local memory (64GBs in halves)
- For the best results in HPL, try to utilize all of the memory you have available, without overloading it
- You can check the GPU utilization of the node you're running on with the `rocm-smi` command
    - See [LUMI user guide](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/interactive/#using-srun-to-check-running-jobs) for instructions for logging into a compute node.
