Clone the latest stable branch/tag, as some external dependencies come as git submodules fetch also them:

`git clone https://github.com/cschpc/icon-scc24.git`

Then:

```
cd icon-scc24
mkdir build-cpu
cd build-cpu
../config/csc/scc24.cpu.cce-18.0.0 2>&1 | tee loki.conf
make -j8 2>&1 | tee make.conf
```

(Note  2>&1 | tee loki.xxx settings which store the terminal output also to a file, so it is easier debug possible problems in the build process.)
