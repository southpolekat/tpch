import org.apache.spark.sql.{Row, SparkSession}
import org.apache.spark.sql.types.{IntegerType, StringType, StructType, StructField, LongType, DecimalType, DoubleType, DateType}
import java.time.LocalDateTime
import java.time.Duration

val schemaNation = StructType(Array(
  StructField("N_NATIONKEY", LongType),
  StructField("N_NAME", StringType),
  StructField("N_REGIONKEY", LongType),
  StructField("N_COMMENT", StringType)))

val schemaRegion = StructType(Array(
  StructField("R_REGIONKEY", LongType),
  StructField("R_NAME", StringType),
  StructField("R_COMMENT", StringType)))

val schemaPart = StructType(Array(
  StructField("P_PARTKEY", LongType),
  StructField("P_NAME", StringType),
  StructField("P_MFGR", StringType),
  StructField("P_BRAND", StringType),
  StructField("P_TYPE", StringType),
  StructField("P_SIZE", IntegerType),
  StructField("P_CONTAINER", StringType),
  StructField("P_RETAILPRICE", DoubleType),
  StructField("P_COMMENT", StringType)))

val schemaSupplier = StructType(Array(
  StructField("S_SUPPKEY", LongType),
  StructField("S_NAME", StringType),
  StructField("S_ADDRESS", StringType),
  StructField("S_NATIONKEY", LongType),
  StructField("S_PHONE", StringType),
  StructField("S_ACCTBAL", DoubleType),
  StructField("S_COMMENT", StringType)))

val schemaPartsupp = StructType(Array(
  StructField("PS_PARTKEY", LongType),
  StructField("PS_SUPPKEY", LongType),
  StructField("PS_AVAILQTY", IntegerType),
  StructField("PS_SUPPLYCOST", DoubleType),
  StructField("PS_COMMENT", StringType)))

val schemaCustomer = StructType(Array(
  StructField("C_CUSTKEY", LongType),
  StructField("C_NAME", StringType),
  StructField("C_ADDRESS", StringType),
  StructField("C_NATIONKEY", LongType),
  StructField("C_PHONE", StringType),
  StructField("C_ACCTBAL", DoubleType),
  StructField("C_MKTSEGMENT", StringType),
  StructField("C_COMMENT", StringType)))

val schemaOrders = StructType(Array(
  StructField("O_ORDERKEY", LongType),
  StructField("O_CUSTKEY", LongType),
  StructField("O_ORDERSTATUS", StringType),
  StructField("O_TOTALPRICE", DoubleType),
  StructField("O_ORDERDATE", DateType),
  StructField("O_ORDERPRIORITY", StringType),
  StructField("O_CLERK", StringType),
  StructField("O_SHIPPRIORITY", IntegerType),
  StructField("O_COMMENT", StringType)))

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
      .option("host", "51a81ebac1c3:7878")
      .option("path", "vitessedata-public/tpch/sf1/csv/" + names(i) + ".*")
      .option("filespec", "csv")
      .option("csv_delim", "|")
      .option("fragcnt", 32)

  val df = dfr.load()

  df.createOrReplaceTempView(names(i))

  i = i + 1
}
