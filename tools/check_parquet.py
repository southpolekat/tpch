#!/usr/bin/python3

import pyarrow.parquet as pq
import sys

print(pq.ParquetFile(sys.argv[1]).schema)

table = pq.read_table(sys.argv[1])
df = table.to_pandas()
print(df.head(5))
