Таблицы_с_наибольшим_upd_del_ins

/* Представление pg_stat_user_tables является индивидуальным для каждой БД, поэтому, чтобы получить статистику по таблицам в БД pgbench, нужно подключиться именно к этой базе.*/

--	Статистика затронутых строк

select
        relname,
        seq_tup_read as seq_read,
        idx_tup_fetch as idx_fetch,
        n_tup_ins as inserted,
        n_tup_upd as uptdated,
        n_tup_del as deleted
from pg_stat_user_tables
order by relname;
     relname      |  seq_read  | idx_fetch | inserted | uptdated | deleted
------------------+------------+-----------+----------+----------+---------
 pgbench_accounts | 2027156202 |    918567 |  2000000 |    14102 |       0
 pgbench_branches |     282080 |         0 |       20 |    14102 |       0
 pgbench_history  |      14102 |           |    14102 |        0 |       0
 pgbench_tellers  |    1498200 |      6612 |      200 |    14102 |       0
