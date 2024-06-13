# Benchmarking with HPCG

Task: Install and run the HPCG benchmark on a single LUMI-G node  

The following are the basic steps you need to take as a team:

1. Create a folder under the path `/scratch/project_462000565/` where each team member has access
2. Download [rocHPCG](https://github.com/cschpc/rocHPCG) into the working folder
3. Install HPCG
    - Export the cray compiler wrappers into your environment first with `export CXX=CC` and `export HIPCXX=CC`
    - *Do not instruct rocHPCG to install dependencies*
    - You need to specify the system's MPI and ROCm installation paths during this. Check this with the help from the advisor.
    - Include the `--gpu-aware-mpi=true` flag during installation
    - Write down the command for installing it.
4. Run a basic test, at max a few minutes long on just **one GPU**.
    - (Optional) Try to tune the test until you get a result of >200 GFLOPs/process.
    - Write down your results.
5. Include the full 4 GPUs on a LUMI-G node and run a test case at max a few minutes long.
    - *Note!* Slurm disbatches Lumi's GPU's in halves, so include 8 gpus in the slurm job script.
    - (Optional) Aim for a result of >1500 GFLOPs.
    - Write down your results.

## Deliverable

Answer the following questions:

1. What command did you use for installing HPCG?
2. What was the best result your team got with one GPU in use? (GFLOPS)
3. What was the best result on the fully utilized LUMI-G node? (GFLOPS)
4. How do the results compare to the "theoretical peak" of 191,6 TFLOPS for the 4 GPUs in the node [(source)](https://www.amd.com/en/products/accelerators/instinct/mi200/mi250x.html)? What is the percentage of the results from the theoretical peak?
5. Return answers for questions 1-4 into the `deliverables` folder in GitHub
6. Return the Slurm script you used during your best run into GitHub, under the `deliverables` folder

## Notes and tips

- Use the small-g partition and the reservation "SCC_training"
- The paths where LUMI's MPI and ROCm are installed can be queried with the `module show [module]` command
- The local matrix size should take up as much memory as possible, without overloading it
- Very large matrix sizes might take a lot of time to initialize (> 10 minutes), start with small sizes, e.g. $64^{3}$
- You can check the GPU utilization of the node you're running on with the `rocm-smi` command (ssh into the node first)
