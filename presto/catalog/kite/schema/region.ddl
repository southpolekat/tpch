DROP TABLE IF EXISTS region;

CREATE TABLE region(
   R_REGIONKEY BIGINT,
   R_NAME VARCHAR(25),
   R_COMMENT VARCHAR(152) )
WITH ( 
   FORMAT=':DATA_FORMAT', 
   CSV_DELIM='|', 
   LOCATION='kite://:KITE_LOCATION/vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/region/*'
);
