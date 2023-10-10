import org.apache.spark.sql.{Row, SparkSession}
import org.apache.spark.sql.types.{IntegerType, StringType, StructType, StructField, LongType, DecimalType, DoubleType, DateType}
import java.time.LocalDateTime
import java.time.Duration

val start = LocalDateTime.now()

val schemaNation = StructType(Array(
  StructField("n_nationkey", LongType),
  StructField("n_name", StringType),
  StructField("n_regionkey", LongType),
  StructField("n_comment", StringType)))

val schemaRegion = StructType(Array(
  StructField("r_regionkey", LongType),
  StructField("r_name", StringType),
  StructField("r_comment", StringType)))

val schemaPart = StructType(Array(
  StructField("p_partkey", LongType),
  StructField("p_name", StringType),
  StructField("p_mfgr", StringType),
  StructField("p_brand", StringType),
  StructField("p_type", StringType),
  StructField("p_size", IntegerType),
  StructField("p_container", StringType),
  StructField("p_retailprice", DoubleType),
  StructField("p_comment", StringType)))

val schemaSupplier = StructType(Array(
  StructField("s_suppkey", LongType),
  StructField("s_name", StringType),
  StructField("s_address", StringType),
  StructField("s_nationkey", LongType),
  StructField("s_phone", StringType),
  StructField("s_acctbal", DoubleType),
  StructField("s_comment", StringType)))

val schemaPartsupp = StructType(Array(
  StructField("ps_partkey", LongType),
  StructField("ps_suppkey", LongType),
  StructField("ps_availqty", IntegerType),
  StructField("ps_supplycost", DoubleType),
  StructField("ps_comment", StringType)))

val schemaCustomer = StructType(Array(
  StructField("c_custkey", LongType),
  StructField("c_name", StringType),
  StructField("c_address", StringType),
  StructField("c_nationkey", LongType),
  StructField("c_phone", StringType),
  StructField("c_acctbal", DoubleType),
  StructField("c_mktsegment", StringType),
  StructField("c_comment", StringType)))

val schemaOrders = StructType(Array(
  StructField("o_orderkey", LongType),
  StructField("o_custkey", LongType),
  StructField("o_orderstatus", StringType),
  StructField("o_totalprice", DoubleType),
  StructField("o_orderdate", DateType),
  StructField("o_orderpriority", StringType),
  StructField("o_clerk", StringType),
  StructField("o_shippriority", IntegerType),
  StructField("o_comment", StringType)))

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

val schemas = List(schemaNation, schemaRegion, schemaPart, schemaSupplier,
  schemaPartsupp, schemaCustomer, schemaOrders, schemaLineitem)
val names = List("nation", "region", "part", "supplier", 
  "partsupp", "customer", "orders", "lineitem")

var i = 0
for (s <- schemas) {
  print("Create view " + names(i) + "\n")
  val dfr = spark.read.format("kite").schema(s)
      .option("host", ":KITE_LOCATION")
      .option("path", "vitessedata-public/tpch/:TPCH_SF/:DATA_FORMAT/" + names(i) + "/*")
      .option("filespec", ":DATA_FORMAT")
      .option("csv_delim", "|")
      .option("fragcnt", :SPARK_WORKER)

  val df = dfr.load()

  df.createOrReplaceTempView(names(i))

  i = i + 1
}
