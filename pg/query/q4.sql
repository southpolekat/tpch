
DROP VIEW IF EXISTS q4;

CREATE VIEW q4 as 
select
	o_orderpriority,
	count(*) as order_count
from
	ORDERS	
where
	o_orderdate >= date '1997-07-01'
	and o_orderdate < date '1997-07-01' + interval '3' month
	and exists (
		select
			*
		from
			LINEITEM
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
;
