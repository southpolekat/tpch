#!/bin/bash

source env.sh

echo "### Create views in memory.default"
for i in {1..22}
do
	$PRESTO_CLI --catalog memory --schema default -f query/q${i}.sql	
done
