#!/bin/bash

schema=${1:-default}
query=${2:-all}

outpath=/tmp/tpch_gpdb_out

mkdir -p $outpath

source env.sh

for i in {1..22};
do
	[ $query != "all" ] && [ $query != "q${i}" ] && continue

	t1=$(($(date +%s%N)/1000000))

	OUT=$outpath/q${i}.out

	PGOPTIONS="--search_path=$schema" \
		psql -c "select * from q${i};" > $OUT

	t2=$(($(date +%s%N)/1000000))

	dur=$(( $t2 - $t1 ))

	echo "q${i} $dur ms"
done
