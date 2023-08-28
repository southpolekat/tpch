#!/bin/bash

set -e

export PRESTO_HOME=~/presto
export PRESTO_CLI=~/presto-cli
export PRESTO_DATA=/mnt/disk0/presto/data

export NUM_WORKER=8						# number of presto workers including coordinator	

export KITE_LOC=kite1:7878				# List of kite host:port. e.g. kite1:7878,kite2:7878
export TPCH_SF=30							# tpch scale factor 1 or 30
