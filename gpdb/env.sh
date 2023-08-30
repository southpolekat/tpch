#!/bin/bash

set -e

export KITE_LOC=kite1:7878				# List of kite host:port. e.g. kite1:7878,kite2:7878
export TPCH_SF=1							# tpch scale factor 1 or 30

SCHEMA_KITE=tpch_kite					# all tables are external
SCHEMA_AO=tpch_ao							# all tables are internal Append-Optimized (A0)
SCHEMA_MIXED=tpch_mixed					# Except lineitem, all tables are internal AO

TABLES="nation region part supplier partsupp customer orders lineitem"

SKIP_QUERIES=(q2 q11 q13 q16 q22)	# skip the queries without using lineitem
