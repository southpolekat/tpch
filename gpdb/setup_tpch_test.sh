#!/bin/bash

source ../env.sh

opts="-c client_min_messages=warning -c optimizer=0" # for PGOPTIONS
psql="psql -v ON_ERROR_STOP=1 -q"

function setup_schema_kite {
	schema=$GP_SCHEMA_KITE
	echo "############# Schema $schema"

	echo "### Recreate schema"
	PGOPTIONS=$opts $psql -c "Drop schema if exists $schema CASCADE"
	PGOPTIONS=$opts $psql -c "Create schema $schema"

	opts2="$opts --search_path=$schema"

	echo "### Create external tables"
	cat schema/kite/tables.ddl \
		| sed -e "s/:KITE_LOCATION/$KITE_LOCATION/" \
		| sed -e "s/:TPCH_SF/sf$TPCH_SF/" \
		| sed -e "s/:DATA_FORMAT/$DATA_FORMAT/" \
		| PGOPTIONS=${opts2} $psql

	echo "### Analyze tables"
	PGOPTIONS=${opts2} $psql -Atf query/analyze.sql

	echo "### Count rows"
	PGOPTIONS=${opts2} $psql -Atf query/counts.sql

	echo "### Create views"
	for i in {1..22}; do
   		PGOPTIONS=${opts2} $psql -f query/q${i}.sql
	done
}

function setup_schema_ao {
   schema=$GP_SCHEMA_AO
   echo "############# Schema $schema"

   echo "### Recreate schema"
   PGOPTIONS=$opts $psql -c "Drop schema if exists $schema CASCADE"
   PGOPTIONS=$opts $psql -c "Create schema $schema"

   opts2="$opts --search_path=$schema"

   echo "### Create AO tables"
   cat schema/ao/tables.ddl \
      | PGOPTIONS=${opts2} $psql

	echo "### Load data"
	for t in "${TPCH_TABLES[@]}"; do
		PGOPTIONS=${opts2} $psql -c "insert into $t select * from $GP_SCHEMA_KITE.$t;"
	done

   echo "### Analyze tables"
   PGOPTIONS=${opts2} $psql -Atf query/analyze.sql

   echo "### Count rows"
   PGOPTIONS=${opts2} $psql -Atf query/counts.sql

   echo "### Create views"
   for i in {1..22}; do
         PGOPTIONS=${opts2} $psql -f query/q${i}.sql
   done
}

function setup_schema_mixed {
   schema=$GP_SCHEMA_MIXED
   echo "############# Schema $schema"

   echo "### Recreate schema"
   PGOPTIONS=$opts $psql -c "Drop schema if exists $schema CASCADE"
   PGOPTIONS=$opts $psql -c "Create schema $schema"

	opts2="$opts --search_path=$schema"

	echo "### Create views"
	for i in {1..22}; do
   	cat query/q${i}.sql \
			| sed -e "s/NATION/${GP_SCHEMA_AO}.nation/" \
			| sed -e "s/REGION/${GP_SCHEMA_AO}.region/" \
			| sed -e "s/PART/${GP_SCHEMA_AO}.part/" \
			| sed -e "s/SUPPLIER/${GP_SCHEMA_AO}.supplier/" \
			| sed -e "s/PARTSUPP/${GP_SCHEMA_AO}.partsupp/" \
			| sed -e "s/CUSTOMER/${GP_SCHEMA_AO}.customer/" \
			| sed -e "s/ORDERS/${GP_SCHEMA_AO}.orders/" \
			| sed -e "s/LINEITEM/${GP_SCHEMA_KITE}.lineitem/" \
			| PGOPTIONS=${opts2} $psql
	done
}

setup_schema_kite
setup_schema_ao
setup_schema_mixed
