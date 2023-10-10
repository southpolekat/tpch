#!/bin/bash

source ../env.sh

connector=${1:-kite}
query=${2:-all}

mkdir -p $OUTDIR/spark

for q in "${TPCH_QUERIES[@]}"; do
   [ $query != "all" ] && [ $query != "$q" ] && continue

   OUT=$OUTDIR/spark/$q.out

	cat query/views_${connector}.scala query/${q}.scala \
		| sed -e "s/:KITE_LOCATION/$KITE_LOCATION/" \
		| sed -e "s/:TPCH_SF/sf$TPCH_SF/" \
		| sed -e "s/:DATA_FORMAT/$DATA_FORMAT/" \
		| sed -e "s/:SPARK_WORKER/$SPARK_WORKER/" \
		| spark-shell --master local[$SPARK_WORKER] > $OUT 2>&1
	
	dur=`grep "^Time:" $OUT | tail -1 | cut -f2 -d ' '`

	echo "${q} $dur ms"
done
