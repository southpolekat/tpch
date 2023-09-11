#!/bin/bash

set -e

# TPCH scale factor either 1 or 30
export TPCH_SF=30

TABLES="nation region part supplier partsupp customer orders lineitem"
