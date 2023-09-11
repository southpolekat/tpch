DROP TABLE IF EXISTS NATION cascade;
DROP TABLE IF EXISTS REGION cascade;
DROP TABLE IF EXISTS PART cascade;
DROP TABLE IF EXISTS SUPPLIER cascade;
DROP TABLE IF EXISTS PARTSUPP cascade;
DROP TABLE IF EXISTS CUSTOMER cascade;
DROP TABLE IF EXISTS ORDERS cascade;
DROP TABLE IF EXISTS LINEITEM cascade;

CREATE TABLE NATION (
	N_NATIONKEY BIGINT,
   N_NAME VARCHAR(25),
   N_REGIONKEY BIGINT,
   N_COMMENT VARCHAR(152) )
;

CREATE TABLE REGION (
	R_REGIONKEY BIGINT,
   R_NAME VARCHAR(25),
   R_COMMENT VARCHAR(152) )
;

CREATE TABLE PART (
	P_PARTKEY BIGINT,
   P_NAME VARCHAR(55),
   P_MFGR VARCHAR(25),
   P_BRAND VARCHAR(10),
   P_TYPE VARCHAR(25),
   P_SIZE INTEGER,
   P_CONTAINER VARCHAR(10),
   P_RETAILPRICE DOUBLE PRECISION,
   P_COMMENT   VARCHAR(23) )
;

CREATE TABLE SUPPLIER (
	S_SUPPKEY BIGINT,
   S_NAME VARCHAR(25),
   S_ADDRESS VARCHAR(40),
   S_NATIONKEY BIGINT,
   S_PHONE VARCHAR(15),
   S_ACCTBAL DOUBLE PRECISION,
   S_COMMENT VARCHAR(101) )
;

CREATE TABLE PARTSUPP (
PS_PARTKEY BIGINT,
   PS_SUPPKEY BIGINT,
   PS_AVAILQTY INTEGER,
   PS_SUPPLYCOST DOUBLE PRECISION,
   PS_COMMENT VARCHAR(199) )
;

CREATE TABLE CUSTOMER (	
	C_CUSTKEY BIGINT,
	C_NAME VARCHAR(25),
	C_ADDRESS VARCHAR(40),
	C_NATIONKEY BIGINT,
	C_PHONE VARCHAR(15),
	C_ACCTBAL DOUBLE PRECISION,
	C_MKTSEGMENT VARCHAR(10),
	C_COMMENT VARCHAR(117) )
;

CREATE TABLE ORDERS (
	O_ORDERKEY BIGINT,
   O_CUSTKEY BIGINT,
   O_ORDERSTATUS VARCHAR(1),
   O_TOTALPRICE DOUBLE PRECISION,
   O_ORDERDATE DATE,
   O_ORDERPRIORITY VARCHAR(15),  
   O_CLERK VARCHAR(15), 
   O_SHIPPRIORITY INTEGER,
   O_COMMENT VARCHAR(79) )
;

CREATE TABLE LINEITEM ( 
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
;
