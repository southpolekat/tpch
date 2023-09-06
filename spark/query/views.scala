import org.apache.spark.sql.{Row, SparkSession}
import org.apache.spark.sql.types.{IntegerType, StringType, StructType, StructField, LongType, DecimalType, DoubleType, DateType}
import java.time.LocalDateTime
import java.time.Duration

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

val dfrLineitem = spark.read.format("kite").schema(schemaLineitem)
        .option("host", "51a81ebac1c3:7878")
        .option("path", "vitessedata-public/tpch/sf1/csv/lineitem*")
        .option("filespec", "csv")
        .option("csv_delim", "|")
        .option("fragcnt", 32)

val dfLineitem = dfrLineitem.load()

dfLineitem.createOrReplaceTempView("lineitem")
