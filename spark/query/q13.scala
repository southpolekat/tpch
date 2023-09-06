val start = LocalDateTime.now()

spark.sql("""
select
	c_count,
	count(*) as custdist
from
	(
		select
			c_custkey,
			count(o_orderkey)
		from
			CUSTOMER left outer join ORDERS on
				c_custkey = o_custkey
				and o_comment not like '%pending%accounts%'
		group by
			c_custkey
	) as c_orders (c_custkey, c_count)
group by
	c_count
;
"""
).show()

val end = LocalDateTime.now()
val duration = Duration.between(start, end)

println("Time: " + duration.toMillis() + " ms")

sys.exit

