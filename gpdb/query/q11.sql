
DROP VIEW IF EXISTS q11;

CREATE VIEW q11 as 
select
	ps_partkey,
	sum(ps_supplycost * ps_availqty) as value
from
	PARTSUPP,
	SUPPLIER,
	NATION	
where
	ps_suppkey = s_suppkey
	and s_nationkey = n_nationkey
	and n_name = 'JAPAN'
group by
	ps_partkey having
		sum(ps_supplycost * ps_availqty) > (
			select
				sum(ps_supplycost * ps_availqty) * 0.0001000000
			from
				PARTSUPP,
				SUPPLIER,
				NATION	
			where
				ps_suppkey = s_suppkey
				and s_nationkey = n_nationkey
				and n_name = 'JAPAN'
		)
;
