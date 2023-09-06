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

	spark-shell --master local[8] -i query/views.scala -i query/q${i}.scala
	
	t2=$(($(date +%s%N)/1000000))

	dur=$(( $t2 - $t1 ))

	echo "q${i} $dur ms"
done
