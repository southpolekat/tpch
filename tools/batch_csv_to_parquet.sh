#!/bin/bash

set -e

src=/tmp/csv
dst=/tmp/parquet

tables="nation region part supplier partsupp customer orders lineitem"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


for t in $tables 
do
	mkdir -p $dst/$t
	rm -f $dst/$t/*
	for f in `find $src/$t -type f -name *.csv`
	do
		n=$(basename $f)
		out=${n%.*}.parquet
		cmd="$SCRIPT_DIR/csv2parquet.py $SCRIPT_DIR/../schema/$t.json $f $dst/$t/$out"
		echo $cmd
		eval $cmd
	done
done
