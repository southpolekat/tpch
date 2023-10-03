#!/bin/bash

source ../env.sh

schema=${1:-${GP_SCHEMA_KITE}}
query=${2:-all}

mkdir -p $OUTDIR/gpdb

for q in "${TPCH_QUERIES[@]}"; do
   [ $query != "all" ] && [ $query != "$q" ] && continue

	IN=$OUTDIR/gpdb/$q.sql
   OUT=$OUTDIR/gpdb/$q.out

	echo '\timing on' > $IN
	echo "select * from ${schema}.${q};" >> $IN

	PGOPTIONS="-c optimizer=0" psql -f $IN > $OUT 

	t2=$(($(date +%s%N)/1000000))

	dur=`grep Time $OUT | tail -1 | cut -d ' ' -f2`

	echo "$q $dur ms"
done
