set search_path=tpch;

DROP EXTERNAL TABLE IF EXISTS XNATION;
CREATE EXTERNAL TABLE XNATION  ( like nation )
LOCATION ('xdrive://localhost:7171/tpch/nation.tbl*.gz')
FORMAT 'CSV' (DELIMITER '|');

DROP EXTERNAL TABLE IF EXISTS XREGION;
CREATE EXTERNAL TABLE XREGION  ( like region )
LOCATION ('xdrive://localhost:7171/tpch/region.tbl*.gz')
FORMAT 'CSV' (DELIMITER '|');

DROP EXTERNAL TABLE IF EXISTS XPART;
CREATE EXTERNAL TABLE XPART  ( like part )
LOCATION ('xdrive://localhost:7171/tpch/part.tbl*.gz')
FORMAT 'CSV' (DELIMITER '|');

DROP EXTERNAL TABLE IF EXISTS XSUPPLIER;
CREATE EXTERNAL TABLE XSUPPLIER ( like supplier )
LOCATION ('xdrive://localhost:7171/tpch/supplier.tbl*.gz')
FORMAT 'CSV' (DELIMITER '|');

DROP EXTERNAL TABLE IF EXISTS XPARTSUPP;
CREATE EXTERNAL TABLE XPARTSUPP ( like partsupp )
LOCATION ('xdrive://localhost:7171/tpch/partsupp.tbl*.gz')
FORMAT 'CSV' (DELIMITER '|');

DROP EXTERNAL TABLE IF EXISTS XCUSTOMER;
CREATE EXTERNAL TABLE XCUSTOMER ( like customer )
LOCATION ('xdrive://localhost:7171/tpch/customer.tbl*.gz')
FORMAT 'CSV' (DELIMITER '|');

DROP EXTERNAL TABLE IF EXISTS XORDERS;
CREATE EXTERNAL TABLE XORDERS  ( like orders )
LOCATION ('xdrive://localhost:7171/tpch/orders.tbl*.gz')
FORMAT 'CSV' (DELIMITER '|');

DROP EXTERNAL TABLE IF EXISTS XLINEITEM;
CREATE EXTERNAL TABLE XLINEITEM ( like lineitem )
LOCATION ('xdrive://localhost:7171/tpch/lineitem.tbl*.gz')
FORMAT 'CSV' (DELIMITER '|');

