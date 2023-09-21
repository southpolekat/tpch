DROP TABLE IF EXISTS customer;

CREATE TABLE customer(
   C_CUSTKEY BIGINT,
   C_NAME VARCHAR(25),
   C_ADDRESS VARCHAR(40),
   C_NATIONKEY BIGINT,
   C_PHONE VARCHAR(15),
   C_ACCTBAL DOUBLE,
   C_MKTSEGMENT VARCHAR(10),
   C_COMMENT VARCHAR(117) )
WITH ( 
   FORMAT=':DATA_FORMAT', 
   CSV_DELIM='|', 
   LOCATION='kite://:KITE_LOCATION/vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/customer/*'
);