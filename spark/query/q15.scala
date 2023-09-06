val start = LocalDateTime.now()

spark.sql("""

DROP VIEW IF EXISTS revenue0;
DROP VIEW IF EXISTS q15;

create view revenue0 as
	select
		l_suppkey as supplier_no,
		sum(l_extendedprice * (1 - l_discount)) as total_revenue
	from
		LINEITEM	
	where
		l_shipdate >= date '1995-12-01'
		and l_shipdate < date '1995-12-01' + interval '3' month
	group by
		l_suppkey;

CREATE VIEW q15 as 
select
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
from
	SUPPLIER,
	revenue0
where
	s_suppkey = supplier_no
	and total_revenue = (
		select
			max(total_revenue)
		from
			revenue0
	)
;
"""
).show()

val end = LocalDateTime.now()
val duration = Duration.between(start, end)

println("Time: " + duration.toMillis() + " ms")

sys.exit

