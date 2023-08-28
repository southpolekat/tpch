#!/bin/bash

catalog=${1:-kite}
schema=${2:-default}
query=${3:-all}

outpath=/tmp/tpch_presto_out

mkdir -p $outpath

source env.sh

for i in {1..22};
do
	[ $query != "all" ] && [ $query != "q${i}" ] && continue

	t1=$(($(date +%s%N)/1000000))

	OUT=$outpath/q${i}.out

	$PRESTO_CLI --catalog $catalog --schema $schema \
		--execute "select * from q${i};" > $OUT

	t2=$(($(date +%s%N)/1000000))

	dur=$(( $t2 - $t1 ))

	echo "q${i} $dur ms"
done
