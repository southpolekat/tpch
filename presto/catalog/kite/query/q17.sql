USE kite.default;

DROP VIEW IF EXISTS q17;

CREATE VIEW q17 as 
select
	sum(l_extendedprice) / 7.0 as avg_yearly
from
	lineitem,
	part, 
	( select l_partkey as f_partkey, 
		cast(0.2 as double) * (sum(l_quantity) / count(l_quantity)) as f_qnt
	 from lineitem 
	 group by 1) foo
where
	p_partkey = l_partkey
	and p_brand = 'Brand#54'
	and p_container = 'LG BAG'
	and l_partkey = f_partkey
	and l_quantity < f_qnt;
