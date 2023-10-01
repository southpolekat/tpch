#!/bin/bash

set -e

src_path=/tmp/parquet
s3_path=s3://vitessedata-public/tpch/sf1/parquet

cd $src_path
 
aws s3 cp nation ${s3_path}/nation/ --recursive
aws s3 cp region ${s3_path}/region/ --recursive
aws s3 cp part ${s3_path}/part/ --recursive
aws s3 cp partsupp ${s3_path}/partsupp/ --recursive
aws s3 cp supplier ${s3_path}/supplier/ --recursive
aws s3 cp orders ${s3_path}/orders/ --recursive
aws s3 cp customer ${s3_path}/customer/ --recursive
aws s3 cp lineitem ${s3_path}/lineitem/ --recursive

