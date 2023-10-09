#!/bin/bash

query=${1:-all}

outpath=/tmp/tpch_spark_out

mkdir -p $outpath

source env.sh

for i in {1..22};
do
	[ $query != "all" ] && [ $query != "q${i}" ] && continue

	t1=$(($(date +%s%N)/1000000))

	OUT=$outpath/q${i}.out

	spark-shell --master local[32] -i query/views.scala -i query/q${i}.scala > $OUT
	
	t2=$(($(date +%s%N)/1000000))

	dur=$(( $t2 - $t1 ))
	dur=`grep Time $OUT | tail -1 | cut -f2 -d ' '`

	echo "q${i} $dur ms"
done
