DROP EXTERNAL TABLE IF EXISTS NATION;
DROP EXTERNAL TABLE IF EXISTS REGION;
DROP EXTERNAL TABLE IF EXISTS PART;
DROP EXTERNAL TABLE IF EXISTS SUPPLIER;
DROP EXTERNAL TABLE IF EXISTS PARTSUPP;
DROP EXTERNAL TABLE IF EXISTS CUSTOMER;
DROP EXTERNAL TABLE IF EXISTS ORDERS;
DROP EXTERNAL TABLE IF EXISTS LINEITEM;

CREATE EXTERNAL TABLE NATION (
	N_NATIONKEY BIGINT,
   N_NAME VARCHAR(25),
   N_REGIONKEY BIGINT,
   N_COMMENT VARCHAR(152) )
LOCATION('pxf://vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/nation/*?PROFILE=s3::DATA_FORMAT&SERVER=s3srvcfg&accesskey=:AWS_ACCESS_KEY&secretkey=:AWS_SECRET_KEY')
FORMAT 'TEXT' (DELIMITER '|');

CREATE EXTERNAL TABLE REGION (
   R_REGIONKEY BIGINT,
   R_NAME VARCHAR(25),
   R_COMMENT VARCHAR(152) )
LOCATION('pxf://vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/region/*?PROFILE=s3::DATA_FORMAT&SERVER=s3srvcfg&accesskey=:AWS_ACCESS_KEY&secretkey=:AWS_SECRET_KEY')
FORMAT 'TEXT' (DELIMITER '|');

CREATE EXTERNAL TABLE PART (
   P_PARTKEY BIGINT,
   P_NAME VARCHAR(55),
   P_MFGR VARCHAR(25),
   P_BRAND VARCHAR(10),
   P_TYPE VARCHAR(25),
   P_SIZE INTEGER,
   P_CONTAINER VARCHAR(10),
   P_RETAILPRICE DOUBLE PRECISION,
   P_COMMENT   VARCHAR(23) )
LOCATION('pxf://vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/part/*?PROFILE=s3::DATA_FORMAT&SERVER=s3srvcfg&accesskey=:AWS_ACCESS_KEY&secretkey=:AWS_SECRET_KEY')
FORMAT 'TEXT' (DELIMITER '|');

CREATE EXTERNAL TABLE SUPPLIER (
   S_SUPPKEY BIGINT,
   S_NAME VARCHAR(25),
   S_ADDRESS VARCHAR(40),
   S_NATIONKEY BIGINT,
   S_PHONE VARCHAR(15),
   S_ACCTBAL DOUBLE PRECISION,
   S_COMMENT VARCHAR(101) )
LOCATION('pxf://vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/supplier/*?PROFILE=s3::DATA_FORMAT&SERVER=s3srvcfg&accesskey=:AWS_ACCESS_KEY&secretkey=:AWS_SECRET_KEY')
FORMAT 'TEXT' (DELIMITER '|');

CREATE EXTERNAL TABLE PARTSUPP (
PS_PARTKEY BIGINT,
   PS_SUPPKEY BIGINT,
   PS_AVAILQTY INTEGER,
   PS_SUPPLYCOST DOUBLE PRECISION,
   PS_COMMENT VARCHAR(199) )
LOCATION('pxf://vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/partsupp/*?PROFILE=s3::DATA_FORMAT&SERVER=s3srvcfg&accesskey=:AWS_ACCESS_KEY&secretkey=:AWS_SECRET_KEY')
FORMAT 'TEXT' (DELIMITER '|');

CREATE EXTERNAL TABLE CUSTOMER (
   C_CUSTKEY BIGINT,
   C_NAME VARCHAR(25),
   C_ADDRESS VARCHAR(40),
   C_NATIONKEY BIGINT,
   C_PHONE VARCHAR(15),
   C_ACCTBAL DOUBLE PRECISION,
   C_MKTSEGMENT VARCHAR(10),
   C_COMMENT VARCHAR(117) )
LOCATION('pxf://vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/customer/*?PROFILE=s3::DATA_FORMAT&SERVER=s3srvcfg&accesskey=:AWS_ACCESS_KEY&secretkey=:AWS_SECRET_KEY')
FORMAT 'TEXT' (DELIMITER '|');

CREATE EXTERNAL TABLE ORDERS (
   O_ORDERKEY BIGINT,
   O_CUSTKEY BIGINT,
   O_ORDERSTATUS VARCHAR(1),
   O_TOTALPRICE DOUBLE PRECISION,
   O_ORDERDATE DATE,
   O_ORDERPRIORITY VARCHAR(15),
   O_CLERK VARCHAR(15),
   O_SHIPPRIORITY INTEGER,
   O_COMMENT VARCHAR(79) )
LOCATION('pxf://vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/orders/*?PROFILE=s3::DATA_FORMAT&SERVER=s3srvcfg&accesskey=:AWS_ACCESS_KEY&secretkey=:AWS_SECRET_KEY')
FORMAT 'TEXT' (DELIMITER '|');

CREATE EXTERNAL TABLE LINEITEM (
   L_ORDERKEY   BIGINT,
   L_PARTKEY   BIGINT,
   L_SUPPKEY   BIGINT,
   L_LINENUMBER  BIGINT,
   L_QUANTITY   DOUBLE PRECISION,
   L_EXTENDEDPRICE  DOUBLE PRECISION,
   L_DISCOUNT   DOUBLE PRECISION,
   L_TAX   DOUBLE PRECISION,
   L_RETURNFLAG  VARCHAR(1),
   L_LINESTATUS  VARCHAR(1),
   L_SHIPDATE   DATE,
   L_COMMITDATE  DATE,
   L_RECEIPTDATE DATE,
   L_SHIPINSTRUCT VARCHAR(25),
   L_SHIPMODE   VARCHAR(10),
   L_COMMENT   VARCHAR(44) )
LOCATION('pxf://vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/lineitem/*?PROFILE=s3::DATA_FORMAT&SERVER=s3srvcfg&accesskey=:AWS_ACCESS_KEY&secretkey=:AWS_SECRET_KEY')
FORMAT 'TEXT' (DELIMITER '|');

