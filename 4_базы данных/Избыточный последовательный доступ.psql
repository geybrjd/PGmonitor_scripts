Избыточный последовательный доступ

/* 	При отсутствии подходящего индекса последовательный доступ будет зайдействован даже при запросе всего одной строки, что может привести к избыточному использованию ресурсов i/o и cpu (чтение и фильтрация строк)*/
--	Для получения списка таблиц, которые читаются последовательно:

select relname, seq_scan, seq_tup_read, idx_scan, idx_tup_fetch
from pg_stat_user_tables
where seq_scan > 0
order by seq_tup_read desc;
     relname      | seq_scan | seq_tup_read | idx_scan | idx_tup_fetch
------------------+----------+--------------+----------+---------------
 pgbench_accounts |     1133 |   2027156202 |    37196 |        918567
 pgbench_tellers  |     7491 |      1498200 |     6612 |          6612
 pgbench_branches |    14104 |       282080 |        0 |             0
