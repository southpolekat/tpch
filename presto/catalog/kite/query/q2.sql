USE kite.default;

DROP VIEW IF EXISTS q2;

CREATE VIEW q2 as 
select
	s_acctbal,
	s_name,
	n_name,
	p_partkey,
	p_mfgr,
	s_address,
	s_phone,
	s_comment
from
	part,
	supplier,
	partsupp,
	nation,
	region,
	(select ps_partkey as f_partkey,
		min(ps_supplycost) as f_mincost
		from
			partsupp,
			supplier,
			nation,
			region
		where
			s_suppkey = ps_suppkey
			and s_nationkey = n_nationkey
			and n_regionkey = r_regionkey
			and r_name = 'MIDDLE EAST'
		group by 1) foo
where
	p_partkey = ps_partkey
	and s_suppkey = ps_suppkey
	and p_size = 9
	and p_type like '%TIN'
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'MIDDLE EAST'
	and ps_supplycost = f_mincost
	and p_partkey = f_partkey
;
