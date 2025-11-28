# топ запросов по запрашиваемым строкам

select
	sum(rows) as total_rows,
	left(query, 64) as query_trunc
from pg_stat_statements
group by query
order by sum(rows) DESC
limit 10;
 total_rows |                           query_trunc
------------+------------------------------------------------------------------
    3155600 | select * from pgbench_accounts
    2000000 | select abalance from pgbench_accounts
    2000000 | copy pgbench_accounts from stdin
      14102 | UPDATE pgbench_accounts SET abalance = abalance + $1 WHERE aid =
      14102 | UPDATE pgbench_tellers SET tbalance = tbalance + $1 WHERE tid =
      14102 | SELECT abalance FROM pgbench_accounts WHERE aid = $1
      14102 | INSERT INTO pgbench_history (tid, bid, aid, delta, mtime) VALUES
      14102 | UPDATE pgbench_branches SET bbalance = bbalance + $1 WHERE bid =
        390 | SELECT t.oid,t.*,c.relkind,format_type(nullif(t.typbasetype, $1)
        343 | SELECT pg_catalog.quote_ident(c.relname) FROM pg_catalog.pg_clas


# Должен вернуть резултат запросов, которые выдают больше всего строк.
/* В данном примере мы видими, что запрос "select * from pgbench_accounts" вернул 3млн строк (Это накопительный эфект, так что не факт что за 1 раз).*/