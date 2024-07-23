# team2 result

## 1. commands to compile and install HPCG:

```shell
module load LUMI/23.09 partition/G rocm
git clone https://github.com/cschpc/rocHPCG.git
export CXX=CC
export HIPCXX=CC
cd rocHPCG/
./install.sh --with-mpi=$CRAY_MPICH_DIR --gpu-aware-mpi=true
cp build/release/bin/rochpcg-0.8.3 ../testrun/rochpcg-0.8.3
```

## 2. best result for 1 GPU runs

| nx, ny, nz | time | Gflops | memory use |
| ---------- | ---- | ------ | ---------- |
| 256 * 256 * 256 | 182s | 221Gflops | 12GB |
| 384 * 384 * 384 | 360s | 208Gflops | 40GB |
| 256 * 256 * 256 | 2000s | 222Gflops | 12GB |
| 384 * 384 * 384 | 2000s | 197Gflops | 40GB |

## 3. best result for full node runs

| nx, ny, nz | time | Gflops | memory use |
| ---------- | ---- | ------ | ---------- |
| 256 * 256 * 256 | 2000s | 1374Gflops | 96GB |

## 4. comparing to theoretical limits

- the 200Gflops achieved in 1GPU runs translates to about 0.83% of theoretical peak performance.

- 1374Gflops translates to 0.71% of theoretical peak performance.

## 6. slurm scripts and outputs

see folders 1gpu, 8gpu-pinned.
