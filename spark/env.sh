#!/bin/bash

set -e

# number of workers
export NUM_WORKER=8

# List of kite host:port. e.g. kite1:7878,kite2:7878
export KITE_LOC=kite1:7878

# tpch scale factor 1 or 30
export TPCH_SF=30
