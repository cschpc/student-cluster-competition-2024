# Findings

## Comparison GCC vs clang

The performance was mostly congruent, no matter if the binary was compiled by
default GCC or loaded aocc (clang). In case running on 1 and 2 nodes, clang
version wins a bit under "Compute" but loses a bit under "MPI" time. In the 4
nodes case this was reversed, but the performance still balances out (<1% diff).

## Scalability
Rather interestingly, when running with only one node the "Compute" portion,
which I will assume runs locally at a given node, takes around 10s, but when
running on two nodes it only takes 2.7s, then on four nodes it's 1.6s. This
perhaps hints at some sort of cache size bottleneck when running on only one
node.

In contrast this time was "gained back" perhaps by the virtue of running on the
same node, in the "MPI" portion (where a quick look in the code suggests that it
is for moving data to respective nodes), without having to go through the
networking stack and its bottleneck somewhere (latency?). So overall performance
gain for increasing from one node to two nodes was almost perfectly 2x (22s ->
11s), coincidentally.

Then again surprisingly from two nodes to four nodes, the "MPI" portion was
scaled almost linearly (8.8s -> 4.4s), perhaps because the inter-node link has
more scalable capacity. Compare this to when the computation portion (2.7s ->
1.5s) starting to see (only slightly) diminishing returns, this would point at
non-parallelizable portion and operating system level contention such as
allocation and scheduling overhead.
