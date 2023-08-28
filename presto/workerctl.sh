#!/bin/bash

ctl=${1:-start} # Commands: run, start, stop, restart, kill, status

source ./env.sh

n=$(( $NUM_WORKER - 1 ))

for i in $(seq 0 $n);
do
	cmd="${PRESTO_HOME}/bin/launcher --etc ${PRESTO_HOME}/etc/p${i} ${ctl}"
	echo "### $cmd"
	eval $cmd
done
