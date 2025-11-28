Наибольшее время ввода-вывода

-- Учет статистики ведется только при включенном параметре track_io_timing

select to_char(
        interval '1 millisecond' * sum(
                blk_read_time + blk_write_time + temp_blks_read + temp_blks_written
        ), 'HH24:MI:SS.MS'
     ) as io_time,
     left(query, 64) as query_trunc
from pg_stat_statements
where blk_read_time + blk_write_time + temp_blks_read + temp_blks_written > 0
group by query
order by sum(blk_read_time + blk_write_time + temp_blks_read + temp_blks_written) desc
limit 5;
   io_time    |                         query_trunc
--------------+-------------------------------------------------------------
 00:00:27.473 | SELECT a.aid, a.bid, a.abalance                            +
              | FROM pgbench_accounts a                                    +
              | WHERE (
 00:00:25.188 | WITH RECURSIVE useless_cte AS (                            +
              |     SELECT aid, bid, abalance, $
 00:00:19.582 | alter table pgbench_accounts add primary key (aid)
 00:00:19.578 | CREATE INDEX acc_balance_idx ON pgbench_accounts (abalance)
 00:00:00.005 | SELECT pg_catalog.pg_get_viewdef($1::pg_catalog.oid, $2)


