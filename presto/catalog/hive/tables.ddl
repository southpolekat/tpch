Drop view if exists hive.tpch.q1;
Drop view if exists hive.tpch.q6;
Drop table if exists hive.tpch.lineitem;
Drop schema if exists hive.tpch;

CREATE SCHEMA hive.tpch; 

Use hive.tpch;

CREATE TABLE LINEITEM ( 
   L_ORDERKEY   BIGINT,
   L_PARTKEY   BIGINT,
   L_SUPPKEY   BIGINT,
   L_LINENUMBER  BIGINT,
   L_QUANTITY   DOUBLE,
   L_EXTENDEDPRICE  DOUBLE,
   L_DISCOUNT   DOUBLE,
   L_TAX   DOUBLE,
   L_RETURNFLAG  VARCHAR(1),
   L_LINESTATUS  VARCHAR(1),
   L_SHIPDATE   DATE,
   L_COMMITDATE  DATE,
   L_RECEIPTDATE DATE,
   L_SHIPINSTRUCT VARCHAR(25),
   L_SHIPMODE   VARCHAR(10),
   L_COMMENT   VARCHAR(44) )
WITH (
	FORMAT='parquet',
	external_location='s3://vitessedata-public/tpch/TPCH_SF/par/'
)
;
