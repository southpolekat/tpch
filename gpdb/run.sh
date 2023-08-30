#!/bin/bash

source env.sh

schema=${1:-${SCHEMA_KITE}}
query=${2:-all}

outpath=/tmp/tpch_gpdb_out

mkdir -p $outpath

for i in {1..22};
do
	#( [ $i -eq 2 ] || [ $i -eq 11 ] || [ $i -eq 13 ] || [ $i -eq 16 ] || [ $i -eq 22 ] ) && continue

	[[ $(echo ${SKIP_QUERIES[@]} | fgrep -w q$i) ]] && continue
	
	[ $query != "all" ] && [ $query != "q${i}" ] && continue

	t1=$(($(date +%s%N)/1000000))

	OUT=$outpath/q${i}.out

	PGOPTIONS="--search_path=$schema" \
		psql -c "select * from q${i};" > $OUT

	t2=$(($(date +%s%N)/1000000))

	dur=$(( $t2 - $t1 ))

	echo "q${i} $dur ms"
done
