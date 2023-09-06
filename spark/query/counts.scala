for (n <- names) {
  spark.sql("select '" + n + "', count(*) from " + n).show()
}
sys.exit
