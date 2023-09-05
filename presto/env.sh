#!/bin/bash

set -e

export PRESTO_HOME=~/presto
export PRESTO_CLI=~/presto-cli
export PRESTO_DATA=/mnt/disk0/presto/data

# number of presto workers NOT including coordinator (p0)	
export NUM_WORKER=8

# List of kite host:port. e.g. kite1:7878,kite2:7878
export KITE_LOC=kite1:7878

# tpch scale factor 1 or 30
export TPCH_SF=30
