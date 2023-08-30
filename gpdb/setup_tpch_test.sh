#!/bin/bash

source env.sh

opts="-c client_min_messages=warning" # for PGOPTIONS

function setup_schema_kite {
	schema=$SCHEMA_KITE
	echo "############# Schema $schema"

	echo "### Recreate schema"
	PGOPTIONS=$opts psql -qc "Drop schema if exists $schema CASCADE"
	PGOPTIONS=$opts psql -qc "Create schema $schema"

	opts2="$opts --search_path=$schema"

	echo "### Create external tables"
	cat schema/kite/tables.ddl \
		| sed -e "s/KITE_LOC/$KITE_LOC/" \
		| sed -e "s/TPCH_SF/sf$TPCH_SF/" \
		| PGOPTIONS=${opts2} psql -q

	echo "### Count rows"
	PGOPTIONS=${opts2} psql -Atf query/counts.sql

	echo "### Create views"
	for i in {1..22}; do
   		PGOPTIONS=${opts2} psql -q -f query/q${i}.sql
	done
}

function setup_schema_ao {
   schema=$SCHEMA_AO
   echo "############# Schema $schema"

   echo "### Recreate schema"
   PGOPTIONS=$opts psql -qc "Drop schema if exists $schema CASCADE"
   PGOPTIONS=$opts psql -qc "Create schema $schema"

   opts2="$opts --search_path=$schema"

   echo "### Create AO tables"
   cat schema/ao/tables.ddl \
      | PGOPTIONS=${opts2} psql -q

	echo "### Load data"
	for t in $TABLES; do
		PGOPTIONS=${opts2} psql -q -c "insert into $t select * from $SCHEMA_KITE.$t;"
	done

   echo "### Count rows"
   PGOPTIONS=${opts2} psql -Atf query/counts.sql

   echo "### Create views"
   for i in {1..22}; do
         PGOPTIONS=${opts2} psql -q -f query/q${i}.sql
   done
}

function setup_schema_mixed {
   schema=$SCHEMA_MIXED
   echo "############# Schema $schema"

   echo "### Recreate schema"
   PGOPTIONS=$opts psql -qc "Drop schema if exists $schema CASCADE"
   PGOPTIONS=$opts psql -qc "Create schema $schema"

	opts2="$opts --search_path=$schema"

	echo "### Create views"
	for i in {1..22}; do
   	cat query/q${i}.sql \
			| sed -e "s/NATION/${SCHEMA_AO}.nation/" \
			| sed -e "s/REGION/${SCHEMA_AO}.region/" \
			| sed -e "s/PART/${SCHEMA_AO}.part/" \
			| sed -e "s/SUPPLIER/${SCHEMA_AO}.supplier/" \
			| sed -e "s/PARTSUPP/${SCHEMA_AO}.partsupp/" \
			| sed -e "s/CUSTOMER/${SCHEMA_AO}.customer/" \
			| sed -e "s/ORDERS/${SCHEMA_AO}.orders/" \
			| sed -e "s/LINEITEM/${SCHEMA_KITE}.lineitem/" \
			| PGOPTIONS=${opts2} psql -q
	done
}

#setup_schema_kite
#setup_schema_ao
setup_schema_mixed
