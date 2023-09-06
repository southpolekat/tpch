val start = LocalDateTime.now()

spark.sql("""
select
	s_name,
	s_address
from
	SUPPLIER,
	NATION	
where
	s_suppkey in (
		select
			ps_suppkey
		from
			PARTSUPP	
		where
			ps_partkey in (
				select
					p_partkey
				from
					PART	
				where
					p_name like 'lime%'
			)
			and ps_availqty > (
				select
					0.5 * sum(l_quantity)
				from
					LINEITEM	
				where
					l_partkey = ps_partkey
					and l_suppkey = ps_suppkey
					and l_shipdate >= date '1993-01-01'
					and l_shipdate < date '1993-01-01' + interval '1' year
			)
	)
	and s_nationkey = n_nationkey
	and n_name = 'VIETNAM'
;
"""
).show()

val end = LocalDateTime.now()
val duration = Duration.between(start, end)

println("Time: " + duration.toMillis() + " ms")

sys.exit

