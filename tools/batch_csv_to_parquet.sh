#!/bin/bash

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

s3_src=s3://vitessedata-public/tpch/sf1/csv
s3_dst=s3://vitessedata-public/tpch/sf1/parquet

tmp_dir=/tmp/csv2parquet

rm -rf ${tmp_dir}
mkdir -p ${tmp_dir}/csv
mkdir -p ${tmp_dir}/parquet

tables="nation region part supplier partsupp customer orders lineitem"
for t in $tables
do
	mkdir -p ${tmp_dir}/parquet/$t
	aws s3 cp ${s3_src}/$t ${tmp_dir}/csv/$t --recursive
	for f in `ls ${tmp_dir}/csv/$t/`
	do
		o=${f%.*}.parquet
		cmd="$SCRIPT_DIR/csv2parquet.py $SCRIPT_DIR/../schema/$t.json 
			${tmp_dir}/csv/$t/$f ${tmp_dir}/parquet/$t/$o"
		echo $cmd
		eval $cmd
	done
	aws s3 cp ${tmp_dir}/parquet/$t ${s3_dst}/$t --recursive
done
