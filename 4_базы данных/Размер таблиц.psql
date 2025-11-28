Размер таблиц

select
        c.relname as table,
        (select count(*) from pg_index i where i.indrelid = c.oid) as n_idx,
        pg_size_pretty(pg_total_relation_size(c.oid)) as total,
        pg_size_pretty(pg_relation_size(c.reltoastrelid)) as toast,
        pg_size_pretty(pg_indexes_size(c.oid)) as indexes,
        pg_size_pretty(pg_relation_size(c.oid, 'main')) as main,
        pg_size_pretty(pg_relation_size(c.oid, 'fsm')) as fsm,
        pg_size_pretty(pg_relation_size(c.oid, 'vm')) as vm,
        pg_size_pretty(pg_relation_size(c.oid, 'init')) as init
from pg_class c
where c.relkind in ('p','r','m')
and not exists ( select 1 from pg_locks
        where relation = c.oid and mode = 'AccessExlusiveLock'
        and granted)
and pg_total_relation_size(c.oid) > 500 * 2^10
order by pg_total_relation_size(c.oid)
desc limit 10;
      table       | n_idx |  total  |   toast    | indexes |  main  |  fsm  |     vm     |  init
------------------+-------+---------+------------+---------+--------+-------+------------+---------
 pgbench_accounts |     2 | 314 MB  |            | 56 MB   | 258 MB | 88 kB | 16 kB      | 0 bytes
 pg_depend        |     2 | 1384 kB |            | 824 kB  | 528 kB | 24 kB | 8192 bytes | 0 bytes
 pg_proc          |     2 | 1192 kB | 8192 bytes | 352 kB  | 752 kB | 24 kB | 8192 bytes | 0 bytes
 pgbench_history  |     0 | 800 kB  |            | 0 bytes | 768 kB | 24 kB | 8192 bytes | 0 bytes
 pg_rewrite       |     2 | 728 kB  | 512 kB     | 32 kB   | 104 kB | 24 kB | 8192 bytes | 0 bytes
 pg_attribute     |     2 | 704 kB  |            | 216 kB  | 456 kB | 24 kB | 8192 bytes | 0 bytes
 pg_collation     |     2 | 640 kB  | 0 bytes    | 160 kB  | 440 kB | 24 kB | 8192 bytes | 0 bytes
 pg_description   |     1 | 600 kB  | 0 bytes    | 216 kB  | 344 kB | 24 kB | 8192 bytes | 0 bytes

/*
	В этом примере есть несколько особенностей:
1.	Вместо pg_stat_users_tables используется pg_class, так как в ней содержится полный список объектов БД
2.	Для получение нужных объектов используется relkind:
				r - обычные таблицы
				p - секционтированные
				m - material view 
3.	Исключить заблокированные таблицы в режиме (AccesExlusiveLock), что не возникало конфликтов блокировок.
4.	Выбрать только таблицы тяжелее 500kb
5. 	Отдельным подзапросом pg_indexes подсчитываем общее кол-во индексов в каждой таблице
6.	Добавляем подсчёт init слоев

*/