#!/bin/bash

source ../env.sh

catalog=${1:-kite}		# kite, hive
schema=${2:-default}
query=${3:-all}

log=$PRESTO_DATA/p0/var/log/server.log

mkdir -p $OUTDIR/presto

for q in "${TPCH_QUERIES[@]}"; do
	[ $query != "all" ] && [ $query != "$q" ] && continue

	OUT=$OUTDIR/presto/$q.out

	$PRESTO_CLI --catalog $catalog --schema $schema \
		--execute "select * from $q;" > $OUT

	sleep 2
	dur=`grep elapsed $log | tail -1 | sed -e "s/.*elapsed //" | sed -e "s/ms .*//"`

	echo "$q $dur ms"
done
