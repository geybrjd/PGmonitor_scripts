pg_stat_statements

wal_records — общее количество записей, отправленных в журнал
wal_fpi — общее количество FPI-страниц, записанное в журнал
wal_bytes — общий объем данных, записанный в журнал, в байтах

select
pg_size_pretty(sum(wal_bytes)) as wal_volume,
left(query, 64) as query_trunc
from pg_stat_statements
group by query
order by sum(wal_bytes) desc
limit 10;
 wal_volume |                           query_trunc
------------+------------------------------------------------------------------
 5039 MB    | update pgbench_accounts set abalance = abalance + $1 where abala
 1532 MB    | vacuum FULL
 1224 MB    | copy pgbench_accounts from stdin
 444 MB     | UPDATE pgbench_accounts SET abalance = abalance + $1 WHERE aid =
 349 MB     | select count(*) from pgbench_accounts
 233 MB     | alter table pgbench_accounts add primary key (aid)
 60 MB      | create index acc_idx on pgbench_accounts(abalance)
 12 MB      | create index acc_balance_idx on pgbench_accounts (abalance)
 12 MB      | CREATE INDEX acc_balance_idx ON pgbench_accounts (abalance)
 11 MB      | vacuum analyze pgbench_accounts

Так мы узнали какие запросы пишут больше всех в журнал 
Резултат показал, что наибольший объем записей генерирует запрос связанный с обновлением строк в pgbench_accounts