# 1. The command you used for installing HPL?
in commands.sh

# 2. The best result your team got with one GPU in use? (GFLOPS)
135Gflops

# 3. The best result on the fully utilized LUMI-G node? (GFLOPS)
60,373Gflops

# 4. How do the results compare to the "theoretical peak" of 191,6 TFLOPS for the 4 GPUs in the node [(source)](https://www.amd.com/en/products/accelerators/instinct/mi200/mi250x.html)? What is the percentage of the results from the theoretical peak?
about 1/3

# 5. The Slurm script you used when running HPL
in each folder "testrun" "testrun2" "testrun2 copy" "testrun2 copy copy"

"testrun" "testrun2" is ran with the wrapper provided. "testrun2 copy" and
"testrun2 copy copy" uses almost the same configuration, in which OMP seems to
be not working, as only 8 CPUs are used.
