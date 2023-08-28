#!/bin/bash

set -e

export PRESTO_HOME=~/presto
export PRESTO_CLI=~/presto-cli
export PRESTO_DATA=/mnt/disk0/presto/data

export NUM_WORKER=8						# number of workers include coordinator	
