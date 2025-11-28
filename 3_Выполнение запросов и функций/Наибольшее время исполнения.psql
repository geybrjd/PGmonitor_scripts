# Наибольшее время исполнения

select 
	to_char( 
			interval '1 millisecond' * sum(total_exec_time), 'HH24:MI:SS'
			) as exec_time,
	left(query, 64) as query_trunc
from pg_stat_statements
group by query 
order by sum(total_exec_time)
desc limit 10;

 exec_time |                           query_trunc
-----------+------------------------------------------------------------------
 00:09:46  | WITH RECURSIVE useless_cte AS (                                 +
           |     SELECT aid, bid, abalance, $
 00:00:36  | select * from pgbench_accounts
 00:00:20  | UPDATE pgbench_branches SET bbalance = bbalance + $1 WHERE bid =
 00:00:15  | select count(*) from pgbench_accounts
 00:00:11  | copy pgbench_accounts from stdin
 00:00:09  | UPDATE pgbench_accounts SET abalance = abalance + $1 WHERE aid =
 00:00:08  | SELECT a.aid, a.bid, a.abalance                                 +
           | FROM pgbench_accounts a                                         +
           | WHERE (
 00:00:05  | CREATE INDEX acc_balance_idx ON pgbench_accounts (abalance)
 00:00:04  | alter table pgbench_accounts add primary key (aid)
 00:00:04  | UPDATE pgbench_tellers SET tbalance = tbalance + $1 WHERE tid =


# За какой период набрана статистика?

SELECT now() - stats_reset FROM pg_stat_statements_info;
    ?column?
-----------------
 19:02:21.284254


/*
Чем полезен?
Можем выявить самые горячие запросы, и если это возможно, то оптимизировать.
*/

