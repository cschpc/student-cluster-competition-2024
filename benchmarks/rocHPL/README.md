# GPU-aware MPI

rocHPL requires GPU-aware MPI, i.e. during communication phases data is used
directly from GPUs.

By default, cray-mpich uses a lower level communication layer called libfabric. However,
libfabric does not support communication directly from GPUs, resulting an error like 
below when trying to run with multiple nodes:
```
```

System comes fortunately with another lower level communication layer UCX, which 
**does** support GPU-aware communication. UCX can be used by loading the corresponding 
module:
```
module unload cray-mpich
module load cray-mpich-ucx
```
(Note that `module swap` does not work in all situations, so we first `unload`. This
might lead into a harmless warning "cannot be unloaded").

However, UCX in the system has also some problems, the default method for communication inside a node does not work, giving an error like:
```
[o184i071:149115:0:149115]      cma_ep.c:85   process_vm_writev(pid=149113 {0x7f84ed48da3d,524288}-->{0x7f0e5ae1ce3d,524288}) returned -1: Bad address
==== backtrace (tid: 149115) ====
 0 0x0000000000003d0a uct_cma_ep_t_new()  ???:0
...
```
This can be circumvented by setting explicitly "posix" method for intra-node communication:
```
export UCX_TLS=self,posix,rc
```
(The `rc` is needed for internode communication).

It is important to note that these are **runtime** settings, i.e. you need to put them into the batch job script:
```
...
#SBATCH --exclusive

module unload cray-mpich
module load cray-mpich-ucx 

export MPICH_GPU_SUPPORT_ENABLED=1
export UCX_TLS=self,posix,rc

...
```

Unfortunaly UCX + "posix" intranode transport degragades performance, and one obtains only ~38 TFLOP/s in a single node (compared to ~40 TFLOP/s with the default `cray-mpich`).


