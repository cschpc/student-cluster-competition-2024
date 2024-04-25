## Performances with different compilers

Comparing the logs produced by the execution of heat_mpi, the iteration time is  similar, at parity of configuration, regardless of the compiler utilised.
Executing heat_mpi with only one node it's possible to appreciate a significant difference in the distribution of execution time: while the iteration is roughly 22.3s in both cases MPI execution took 11.6s in the gcc case and 15.1s in the clang one while compute took 10.6s in the gcc version and 7.3s in the clang one.

## Scalability

The iteration time seems to scale roughly linearly with the nodes increase (22s - 11.5s - 6s with 1 - 2 - 4 nodes).

This behaviour is not matched when it comes to MPI and Compute execution times taken separately. 
In the Clang case MPI execution times scale linearly (15s - 8.7s - 4.3s) while the Compute time scales in log_2 basis (7.3s - 2.9s - 1.7s). 
In the GCC case the execution time variation is irregular between (1 - 2 nodes), it then exhibit the same behaviour as the Clang one for (2 - 4 nodes)

This behaviour might be caused by a bottleneck related to cache management in the single node GCC case.
