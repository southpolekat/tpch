USE kite.default;

DROP VIEW IF EXISTS q22;

CREATE VIEW q22 as 
select
	cntrycode,
	count(*) as numcust,
	sum(c_acctbal) as totacctbal
from
	(
		select
			substring(c_phone from 1 for 2) as cntrycode,
			c_acctbal
		from
			customer
		where
			substring(c_phone from 1 for 2) in
				('10', '11', '26', '22', '19', '20', '27')
			and c_acctbal > (
				select
					sum(c_acctbal) / count(c_acctbal)	
				from
					customer
				where
					c_acctbal > 0.00
					and substring(c_phone from 1 for 2) in
						('10', '11', '26', '22', '19', '20', '27')
			)
			and not exists (
				select
					*
				from
					orders
				where
					o_custkey = c_custkey
			)
	) as custsale
group by
	cntrycode
;
