#!/bin/bash

source env.sh

n=$(( $NUM_WORKER )) 	# number of workers (exluding p0)

etc=$PRESTO_HOME/etc
p0=${etc}/p0

cp catalog/kite/kite.properties ${p0}/catalog/
cp catalog/memory/memory.properties ${p0}/catalog/

for i in $(seq 1 $n);
do
	echo "### Generate config $PRESTO_HOME/etc/p${i}"

	dst=${etc}/p${i}
	port=$(( 8080 + $i ))	

	mkdir -p ${dst}
	mkdir -p ${PRESTO_DATA}/p${i}

	cp -r ${p0}/* ${dst}/.

	sed -i "s/p0/p${i}/" ${dst}/node.properties 
	sed -i "s/node.id=.*/node.id=$(uuidgen)/" ${dst}/node.properties 
	sed -i "s/^coordinator=true/coordinator=false/" ${dst}/config.properties 
	sed -i "s/include-coordinator=true/include-coordinator=false/" ${dst}/config.properties
	sed -i "s/port=8080/port=${port}/" ${dst}/config.properties 
	sed -i "/node-scheduler.include-coordinator/d" ${dst}/config.properties 
	sed -i "/query.max-total-memory-per-node/d" ${dst}/config.properties 
	sed -i "/discovery-server.enabled/d" ${dst}/config.properties 

done

sed -i "s/include-coordinator=true/include-coordinator=false/" ${p0}/config.properties
