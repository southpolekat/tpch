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

val schemas = List(schemaNation, schemaRegion, schemaLineitem)
val names = List("nation", "region", "lineitem")

var i = 0
for (s <- schemas) {
  print("Create view " + names(i) + "\n")
  val dfr = spark.read.format("kite").schema(s)
        .option("host", "51a81ebac1c3:7878")
        .option("path", "vitessedata-public/tpch/sf1/csv/" + names(i) + "*")
        .option("filespec", "csv")
        .option("csv_delim", "|")
        .option("fragcnt", 32)

  val df = dfr.load()

  df.createOrReplaceTempView(names(i))

  i = i + 1
}
