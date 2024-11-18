# MLPerf run documentation

### MLCommons CM

Create a virtual environment to install CM into
```
python3 -m venv cm
source cm/bin/activate
```
Update pip
```
python -m pip install --upgrade pip
```
Now install CM
```
pip install cm4mlops
```
### Pytorch framework
Now setup a virtual environment for Python
```
cm run script --tags=install,python-venv --name=mlperf
export CM_SCRIPT_EXTRA_CMD="--adr.python.name=mlperf"
```
Performance Estimation for Offline Scenario
```
cm run script --tags=run-mlperf,inference,_find-performance,_r4.1-dev,_short,_scc24-main \
   --model=sdxl \
   --implementation=reference \
   --framework=pytorch \
   --category=datacenter \
   --scenario=Offline \
   --execution_mode=test \
   --device=rocm  \
   --quiet \
   --precision=float16 \
   --env.CM_GENERIC_SYS_UTIL_IGNORE_MISSING_PACKAGE=yes \
   --env.CM_MLPERF_INFERENCE_MAX_QUERY_COUNT=10
```
To get the main variant, use ```_scc24-main``` instead of ```_scc24-base```
#### Offline
```
cm run script --tags=run-mlperf,inference,_r4.1-dev,_short,_scc24-base \
   --model=sdxl \
   --implementation=reference \
   --framework=pytorch \
   --category=datacenter \
   --scenario=Offline \
   --execution_mode=test \
   --device=rocm \
   --quiet \
   --precision=float16 \
   --env.CM_GENERIC_SYS_UTIL_IGNORE_MISSING_PACKAGE=yes
```
### Generate actual submission tree
```
cm run script --tags=generate,inference,submission \
   --clean \
   --preprocess_submission=yes \
   --run-checker \
   --tar=yes \
   --env.CM_TAR_OUTFILE=submission.tar.gz \
   --division=open \
   --category=datacenter \
   --env.CM_DETERMINE_MEMORY_CONFIGURATION=yes \
   --run_style=test \
   --adr.submission-checker.tags=_short-run \
   --quiet \
   --submitter=loyly \
   --hw_name="loyly_cluster"
```
### Push Results to GitHub
```
cm run script --tags=push,github,mlperf,inference,submission \
   --repo_url=https://github.com/Matteo-Murdaca/cm4mlperf-inference \
   --repo_branch=mlperf-inference-results-scc24 \
   --commit_message="Results on system loyly_cluster" \
   --quiet
```
