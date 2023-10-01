#!/usr/bin/python3

import sys
import json
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

debug = 1

def convert_csv_to_parquet(in_schema, in_csv, out_parquet):

	# read schema
	f = open(in_schema)
	data = f.read()
	schema = json.loads(data)

	# read csv
	df = pd.read_csv(in_csv, sep='|', header=None, 
		#dtype=schema, 
		engine='pyarrow',
		dtype_backend='pyarrow',
		parse_dates=True) 
	df.columns = schema.keys()
	df = df.astype(schema)

	df = df.dropna(axis=1)

	# Convert Pandas DataFrame to PyArrow Table
	table = pa.Table.from_pandas(df)

	# Write PyArrow Table to Parquet file
	pq.write_table(table, out_parquet, compression='none')

	if debug == 1:
		print(schema,"\n")
		df.info()
		print()
		print(df.head(5))	
	
		# Open the Parquet file
		table = pq.read_table(out_parquet)

		# Convert the table to a Pandas DataFrame
		df = table.to_pandas()
		print()
		df.info()
		print()
		print(df.head(5))	


if __name__ == "__main__":

	if len(sys.argv) != 4:
		print("Usage:", sys.arg[0], "schema.json", "in.csv", "out.parquet")
		sys.exit(-1)

	in_schema = sys.argv[1]
	in_csv = sys.argv[2]
	out_parquet = sys.argv[3]

	convert_csv_to_parquet(in_schema, in_csv, out_parquet)
