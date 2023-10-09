#!/bin/bash

source ../env.sh

connector=${1:-kite}
query=${2:-all}

mkdir -p $OUTDIR/spark

for q in "${TPCH_QUERIES[@]}"; do
   [ $query != "all" ] && [ $query != "$q" ] && continue

   OUT=$OUTDIR/spark/$q.out

	spark-shell --master local[$SPARK_WORKER] \
		-i query/views_${connector}.scala \
		-i query/${q}.scala 2>&1 > $OUT
	
	dur=`grep Time $OUT | tail -1 | cut -f2 -d ' '`

	echo "${q} $dur ms"
done
