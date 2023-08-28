#!/bin/bash
# 
# split the source csv files by number of lines 
# rename the files $prefix.prt.$rnd.csv
# gzip the file csv files
#
# ./split_csv.sh data/customer.tbl 15000 customer
# ./split_csv.sh data/nation.tbl 25 nation
# ./split_csv.sh data/orders.tbl 150000 orders
# ./split_csv.sh data/part.tbl 20000 part
# ./split_csv.sh data/partsupp.tbl 80000 partsupp
# ./split_csv.sh data/region.tbl 5 region
# ./split_csv.sh data/supplier.tbl 1000 supplier

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo $0 src_csv num_of_lines prefix
	echo $0 data/customer.tbl 15000 customer
	exit 
fi

csv=$1
line=$2
prefix=$3

dst=/tmp/split_out

mkdir -p $dst
rm -f $dst/*

f=$(readlink -f $csv)

cd $dst
split -l $line $f 

rnd=$(shuf -i 1000000-9999999 -n 1)

for i in `ls`
do 
	mv $i $prefix.prt.$rnd.csv
	rnd=$(( $rnd + 1 ))
done

gzip *.csv
