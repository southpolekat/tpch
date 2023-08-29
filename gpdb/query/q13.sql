
DROP VIEW IF EXISTS q13;

CREATE VIEW q13 as 
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
				and o_comment != /*not like*/ '%pending%accounts%'
		group by
			c_custkey
	) as c_orders (c_custkey, c_count)
group by
	c_count
;
