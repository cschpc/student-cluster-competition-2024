# SCC Training 02

Date: 25.03.2024  
Slides: [Link](./slides)

## Schedule

|Time|Topic|
|---|---|
|13:00|Compiling C/Fortran. Makefiles|
|13:30|Parallel computing concepts|
|14:00|Coffee break|
|14:15|Parallel programming via processes|
|14:45|Supercomputer modules|
|15:00|Supercomputer batch job system|  

## Demos and exercises

Demos during today's training can be found in the exercises folder: [exercises](./exercises/)

## Practicalities to discuss

- ISC Team
- Time of next meeting
- Start thinking of a team name
- Fill in team member information

## Homework

### Building and running heat equation solver in Mahti

In this exercise you should build a simple three dimensional heat equation solver,
and investigate its scalability in Mahti.

1. Download the code with `git clone` under your personal scratch space:
```
git clone https://github.com/cschpc/heat-equation.git
```
2. You will work with the pure MPI version of the 3d case, so change into the proper directory:
```
cd heat-equation/3d/mpi
```
3. Investigate the Makefile (however, for this exercise you do **not** need to edit it) and build the code with the `make` command
4. Run the resulting binary `heat_mpi` via Slurm using 1, 2, and 4 nodes (using always 128 tasks per node). With one node, the running time should be less than one minute.
5. Build the code then with the Clang compiler, by first loading the `aocc` module, and then rebuilding. Note that in order to rebuild, you need to either clean the previous GNU build (`make clean; make`) or force rebuilding everything with the `-B` flag for `make` (`make -B`). 
   - You may want to save the previous binary by copying it to a different filename before rebuilding. 
   - Run also the binary build with the Clang compiler using 1, 2, and 4 nodes.

6. Documenting the results
   1. Create a directory into the "deliverables" folder with your name
   2. Save the Slurm batch job file that you used into that folder
   3. Save the outputs of your runs also in that folder
   4. Describe shortly your findings about the scalability and performance with different compilers in a text file in the folder
