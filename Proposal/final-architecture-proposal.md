# Team Löyly: Final Hardware Architecture Proposal

--------------
Competition requirements:

    Hardware Configuration: Describe your anticipated hardware in sufficient detail to estimate an upper-bound energy budget, and to allow Application Experts to determine whether each application will be able to run on your hardware. The statement must also include a description of why you believe that the system described is appropriate for the challenge. Please also address the following points.
        Cooling configuration: If you are using any external cooling apparatus, e.g. mineral oil, you should describe this also. It will be considered as part of your system and included in your power usage.
        Power Configuration: The PDUs you will connect to have "Combination C13/C19" outlets. Please confirm in your proposal that you will bring power cables that are appropriate.
        Network Configuration: The SCC will provide RJ45 Gigabit ethernet connection at your booth, along with a 10/25 Gbe fiber connection with appropriate optics. Details were provided in an earlier mailing. Using the faster fiber connection is optional this year, and all teams must be able to connect to basic gigabit ethernet at a minimum, and as a backup option for teams intending to use the fiber. Please describe how you plan to connect to the network.
        Physical Configuration: All hardware must be properly enclosed and mounted. For example, rack mount gear must be mounted in rack. The SCC does NOT provide a rack, you MUST bring a rack. Hardware cannot be set on the floor or tables unless it is intended to be a desktop system.

    Software used (OS, middleware, etc): This statement must include a description of why you believe that the anticipated software is appropriate for the challenge.
---------------

## Hardware overview

Our hardware is HPE ProLiant DL385 Gen11 server, consisting of three dual socket compute nodes. Each node contains two AMD EPYC 9354 32-core CPUs with 768 GB (12 x 64 GB DDR5-4800) of memory, as well as two AMD MI210 GPUs with 64 GB of HBM2e memory per GPU. For storage, each node has two 3.2 TB NVMe drives. The nodes are connected by Infiniband NDR200 switches. The system is air cooled, and the estimated power consumption in full utilization is around 4000 W, fitting thus into the 4500 W power limit. All hardware will be mounted within a single rack provided by the team.

Each GPU has about 20 TFLOPS/s double precision peak performance (over 40 TFLOPS/s double precision matrix performance) and they are the highest performing air cooled AMD GPUs, thus we believe our system performs well as the benchmarks and applications that are able to utilize GPUs. Also, the CPUs provide plenty of compute power and memory bandwidth in case the mystery benchmark does not support GPUs.

Power configuration: our system has two PDUs with C13/C19 outlets, and we will bring also the appropriate power cables.

Network configuration: we are planning to connect with RJ45 Gigabit ethernet connection.

## Software overview

As operating system we will use RedHat 9.4, and we will utilize also Slurm batch job system. The compilers are provided by the Cray Programming Environment (CPE), which includes Cray C/C++ and Fortran compilers, GNU C/C++ and Fortran compilers, as well as AMD C/C++ and Fortran compilers. For GPUs there is ROCm and HIP stacks. MPI environment is provided by Cray-mpich, which supports also GPU aware communication.

AMD provides a version of High Performance Linpack for AMD GPUs, rocHPL, which can be run on our system. Also, MLPerf Inference runs on AMD GPUs via PyTorch, where we utilize also Cray Python.

Regarding the applications, NAMD 3.0 supports AMD GPUs via accelerated HIP kernels. ICON is implemented in Fortran, with GPU version using OpenACC which is supported by Cray Fortran. 

Finally, Reproducibility challenge relies on standard Linux software and can thus be run in our system.

Overall, our system includes all the necessary software for running the benchmarks and applications successfully.  
