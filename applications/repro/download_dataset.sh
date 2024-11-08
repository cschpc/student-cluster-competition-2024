#!/bin/sh
set -e
ROOTDIR=$PWD

wget "https://zenodo.org/records/7846089/files/artifacts_sc23.tar.gz?download=1" -O artifacts_sc23.tar.gz
tar xvf artifacts_sc23.tar.gz
mkdir artifacts_sc23/Performance/1000genome_perf_number/scratch

git clone https://github.com/pegasus-isi/1000genome-workflow.git
cd 1000genome-workflow/
sh prepare_input.sh

cd $ROOTDIR/artifacts_sc23/Performance/1000genome_perf_number/
cp -s $ROOTDIR/1000genome-workflow/data/20130502/*.vcf .

cp $ROOTDIR/testi.sbatch .
python -m venv venv
source venv/bin/activate
pip install matplotlib
