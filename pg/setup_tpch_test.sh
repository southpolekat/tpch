#!/bin/bash

source env.sh

vd_s3_url=https://vitessedata-public.s3.amazonaws.com

function download_file_from_s3() {
	f=$(basename $1)
	if [ ! -f $f ]; then
		echo "Download $f from s3"
		wget -O $f ${vd_s3_url}/$1
	fi
	n="${f%.*}"
	if [[ $f == *.tgz ]] && [ ! -d $n ]; then
		echo "extract $f"
		tar -xf $f
	fi		
}

function create_tables_and_load_data() {
	psql -f tables.ddl
	ao_tables="nation region part supplier partsupp customer orders lineitem"
	for t in `echo ${TABLES}`; do
		table=${t}
  		cat data/${t}.tbl | psql -c "COPY ${table} FROM stdin delimiter '|';"
	done
	psql -qAt -f query/counts.sql
}

function create_views() {	
	for i in {1..22}
	do
		psql -f query/q${i}.sql	
	done
}

### Main ###
download_file_from_s3 tpch/sf${TPCH_SF}/data.tgz
create_tables_and_load_data
create_views
