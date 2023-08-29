#!/bin/bash

source env.sh

function setup_schema_kite {
	schema=kite
	echo "############# Catalog Kite"
	echo "### Create external tables"
	cat schema/kite/tables.ddl \
		| sed -e "s/KITE_LOC/$KITE_LOC/" \
		| sed -e "s/TPCH_SF/sf$TPCH_SF/" \
		| psql -q
	echo "### Count rows"
	PGOPTIONS="--search_path=$schema" psql -f query/counts.sql
	echo "### Create views"
	for i in {1..22}
	do
   	PGOPTIONS="--search_path=$schema" psql -f query/q${i}.sql
	done
}

setup_schema_kite
