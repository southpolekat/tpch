val start = LocalDateTime.now()

spark.sql("""
select
	l_shipmode,
	sum(case
		when o_orderpriority = '1-URGENT'
			or o_orderpriority = '2-HIGH'
			then 1
		else 0
	end) as high_line_count,
	sum(case
		when o_orderpriority <> '1-URGENT'
			and o_orderpriority <> '2-HIGH'
			then 1
		else 0
	end) as low_line_count
from
	ORDERS,
	LINEITEM	
where
	o_orderkey = l_orderkey
	and (l_shipmode = 'FOB' or l_shipmode = 'TRUCK')
	and l_commitdate < l_receiptdate
	and l_shipdate < l_commitdate
	and l_receiptdate >= date '1996-01-01'
	and l_receiptdate < date '1996-01-01' + interval '1' year
group by
	l_shipmode
;
"""
).show()

val end = LocalDateTime.now()
val duration = Duration.between(start, end)

println("Time: " + duration.toMillis() + " ms")

sys.exit

