#!/bin/bash

source env.sh

function setup_catalog_kite {
echo "############# Catalog Kite"
echo "### Create tables"
cat catalog/kite/tables.ddl \
	| sed -e "s/KITE_LOC/$KITE_LOC/" \
	| sed -e "s/TPCH_SF/sf$TPCH_SF/" \
	> /tmp/kite_tables.ddl
${PRESTO_CLI} -f /tmp/kite_tables.ddl 
echo "### Count rows"
${PRESTO_CLI} --catalog kite --schema default -f query/counts.ddl
echo "### Create views"
for i in {1..22}
do
   $PRESTO_CLI --catalog kite --schema default -f query/q${i}.sql
done
}

function setup_catalog_hive {
echo "############# Catalog Hive"
echo "### Create tables"
cat catalog/hive/tables.ddl \
        | sed -e "s/TPCH_SF/sf$TPCH_SF/" \
        > /tmp/hive_tables.ddl
${PRESTO_CLI} -f /tmp/hive_tables.ddl
echo "### Count rows"
${PRESTO_CLI} --catalog hive --schema tpch --execute "select count(*) from lineitem;" 
echo "### Create views"
${PRESTO_CLI} --catalog hive --schema tpch -f query/q1.sql
${PRESTO_CLI} --catalog hive --schema tpch -f query/q6.sql
}

function setup_catalog_memory {
echo "############# Catalog Memory"
echo "### Create tables"
${PRESTO_CLI} -f catalog/memory/tables.ddl
echo "### Load data"
${PRESTO_CLI} -f catalog/memory/load_data.sql
echo "### Count rows"
${PRESTO_CLI} --catalog memory --schema default -f query/counts.ddl
echo "### Create views"
for i in {1..22}
do
	$PRESTO_CLI --catalog memory --schema default -f query/q${i}.sql	
done
}

function setup_schema_mixed {
echo "### Create schema mixed"
${PRESTO_CLI} -f catalog/memory/schema_mixed.sql
echo "### Create views"
for i in {1..22}
do
	tmpq=/tmp/tmp_q.sql
   cat query/q${i}.sql \
		| sed -e "s/NATION/memory.default.nation/" \
		| sed -e "s/REGION/memory.default.region/" \
		| sed -e "s/PART/memory.default.part/" \
		| sed -e "s/SUPPLIER/memory.default.supplier/" \
		| sed -e "s/PARTSUPP/memory.default.partsupp/" \
		| sed -e "s/CUSTOMER/memory.default.customer/" \
		| sed -e "s/ORDERS/memory.default.orders/" \
		| sed -e "s/LINEITEM/kite.default.lineitem/" \
		> $tmpq

	$PRESTO_CLI --catalog memory --schema mixed -f $tmpq
done
} 

setup_catalog_hive
setup_catalog_kite
#setup_catalog_memory
#setup_schema_mixed
