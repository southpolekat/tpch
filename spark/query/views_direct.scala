import java.time.LocalDateTime
import org.apache.spark.sql.types.{IntegerType, StringType, StructType, StructField, LongType, DecimalType, DoubleType, DateType}
import java.time.Duration

//spark.sparkContext.setLogLevel("INFO")

val start = LocalDateTime.now()

/* parquet */
var df = spark.read.parquet("s3a://vitessedata-public/tpch/sf30/parquet/lineitem/*")

/* csv */
/*
val schemaLineitem = StructType(Array(
   StructField("l_orderkey", LongType),
   StructField("l_partkey", LongType),
   StructField("l_suppkey", LongType),
   StructField("l_linenumber", LongType),
   StructField("l_quantity", DoubleType),
   StructField("l_extendedprice", DoubleType),
   StructField("l_discount", DoubleType),
   StructField("l_tax", DoubleType),
   StructField("l_returnflag", StringType),
   StructField("l_linestatus", StringType),
   StructField("l_shipdate", DateType),
   StructField("l_commitdate", DateType),
   StructField("l_receiptdate", DateType),
   StructField("l_shipinstruct", StringType),
   StructField("l_shipmode", StringType),
   StructField("l_comment", StringType)))

val df = spark.read.format("csv")
  .options(Map("delimiter"->"|"))
  .option("header", "false")
  .schema(schemaLineitem)
  .load("s3a://vitessedata-public/tpch/sf30/csv/lineitem.prt.*")
*/

df.createOrReplaceTempView("lineitem");

