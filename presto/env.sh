#!/bin/bash

set -e

export PRESTO_HOME=~/presto
export PRESTO_CLI=~/presto-cli
export PRESTO_DATA=/mnt/disk0/presto/data
export NUM_WORKER=3						# number of presto workers include coordinator	

export KITE_URL=kite1:7878
export TPCH_SF=1							# tpch scale factor 1 or 30
