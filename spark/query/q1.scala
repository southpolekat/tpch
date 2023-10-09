//val start = LocalDateTime.now()

spark.sql("""
select
	l_returnflag,
	l_linestatus,
	sum(l_quantity) as sum_qty,
	sum(l_extendedprice) as sum_base_price,
	sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
	sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
	avg(l_quantity) as avg_qty,
	sum(l_extendedprice) / count(l_extendedprice) /*avg(l_extendedprice)*/ as avg_price,
	sum(l_discount)/count(l_discount) /*(avg(l_discount)*/ as avg_disc,
	count(*) as count_order
from
	lineitem
where
	l_shipdate <= date '1998-12-01' - interval '112 day'
group by
	l_returnflag,
	l_linestatus
;
"""
).show()

val end = LocalDateTime.now()
val duration = Duration.between(start, end)

println("Time: " + duration.toMillis() + " ms")

sys.exit
