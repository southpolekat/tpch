#!/bin/bash

source env.sh

query=${1:-all}

outpath=/tmp/tpch_pg_out

mkdir -p $outpath

for i in {1..22};
do
	[[ $(echo ${SKIP_QUERIES[@]} | fgrep -w q$i) ]] && continue
	
	[ $query != "all" ] && [ $query != "q${i}" ] && continue


	OUT=$outpath/q${i}.out

	psql -f query/settings.sql -c "select * from q${i};" > $OUT

	dur=`grep Time $OUT | tail -1 | cut -d ' ' -f2`

	echo "q${i} $dur ms"
done
