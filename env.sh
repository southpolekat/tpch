#!/bin/bash

set -e

export OUTDIR=/tmp/tpch

############################# KITE
# List of kite's host:port. e.g. kite1:7878,kite2:7878
export KITE_LOCATION=kite1:7878

############################# DATA
# Scale factor: 1 or 30
export TPCH_SF=30
export TPCH_TABLES=(lineitem)
export TPCH_QUERIES=(q1 q6)
# Source data file format: csv or parquet 
export DATA_FORMAT=parquet

############################# PRESTO
export PRESTO_HOME=~/presto
export PRESTO_CLI=~/presto-cli
export PRESTO_DATA=/mnt/disk0/presto/data
export PRESTO_USER=presto
# number of presto workers NOT including coordinator (p0)	
export PRESTO_WORKER=8

############################# SPARK 
export SPARK_HOME=/opt/spark
export SPARK_WORKER=32

############################# Greenplum 
# All tables are internal append-optimized
export GP_SCHEMA_AO=ao
# All tables are external kite tables
export GP_SCHEMA_KITE=kite
# Views use all internal tables except lineitem 
export GP_SCHEMA_MIXED=mixed
