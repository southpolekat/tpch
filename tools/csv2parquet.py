#!/usr/bin/python3

import sys
import json
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq
import pyarrow.csv as pc
import fastparquet as fp
import datetime

debug = 0

def convert_csv_to_parquet(in_schema, in_csv, out_parquet):

	# read schema
	f = open(in_schema)
	data = f.read()
	schema = json.loads(data)

	for c in schema:
		if schema[c] == "date":
			schema[c] = pa.date32()

	csv_parse_options = pa.csv.ParseOptions(
		delimiter = '|'
	)
	csv_read_options = pa.csv.ReadOptions(
		column_names = schema.keys()
	)
	csv_convert_options = pc.ConvertOptions(
		column_types = schema
	)

	table = pc.read_csv(in_csv,
		parse_options = csv_parse_options,
		read_options = csv_read_options,
		convert_options = csv_convert_options
	)	
	pq.write_table(table, out_parquet)
	
	if debug == 1:
		print(schema,"\n")
		df = table.to_pandas()
		df.info()
		print(df.head(5))	
	
		table = pq.read_table(out_parquet)
		df = table.to_pandas()
		df.info()
		print(df.head(5))	

if __name__ == "__main__":

	if len(sys.argv) != 4:
		print("Usage:", sys.arg[0], "schema.json", "in.csv", "out.parquet")
		sys.exit(-1)

	in_schema = sys.argv[1]
	in_csv = sys.argv[2]
	out_parquet = sys.argv[3]

	convert_csv_to_parquet(in_schema, in_csv, out_parquet)
