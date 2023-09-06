for (n <- names) {
  spark.sql("select count(*) from " + n).show()
}
sys.exit
