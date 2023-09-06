val start = LocalDateTime.now()

spark.sql("""
select
	sum(l_extendedprice) / 7.0 as avg_yearly
from
	LINEITEM,
	PART, 
	( select l_partkey as f_partkey, 
		cast(0.2 as double) * (sum(l_quantity) / count(l_quantity)) as f_qnt
	 from LINEITEM 
	 group by 1) foo
where
	p_partkey = l_partkey
	and p_brand = 'Brand#54'
	and p_container = 'LG BAG'
	and l_partkey = f_partkey
	and l_quantity < f_qnt;
"""
).show()

val end = LocalDateTime.now()
val duration = Duration.between(start, end)

println("Time: " + duration.toMillis() + " ms")

sys.exit
