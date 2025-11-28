Функции для работы с объектами СУБД

-- Определить размер объектов

-- 1. Размер ТП
select * from pg_size_pretty(pg_tablespace_size('pg_default'));
 pg_size_pretty
----------------
 349 MB

-- 2. Размер БД
select * from pg_size_pretty(pg_database_size('test'));
 pg_size_pretty
----------------
 324 MB

 -- 3. общий размер таблицы включая (toast/vm/fsm/init)
 select * from pg_size_pretty(pg_table_size('pgbench_accounts'));
 pg_size_pretty
----------------
 258 MB

-- 4. Общий размер ВСЕХ индексов таблицы
select * from pg_size_pretty(pg_indexes_size('pgbench_accounts'));
 pg_size_pretty
----------------
 56 MB

 -- 5. Общий размер указанной таблицы, включая (toast/vm/fsm/init + все её индексы)
 select * from pg_size_pretty(pg_total_relation_size('pgbench_accounts'));
 pg_size_pretty
----------------
 314 MB

-- 6. размер слоя отношения (таблицы или индекса), указанного в первом аргументе, во втором аргументе имя слоя (main/fsm/vm)
-- Таблица:
select * from pg_size_pretty(pg_relation_size('pgbench_accounts','main' ));
 pg_size_pretty
----------------
 258 MB
-- Индекс
select * from pg_size_pretty(pg_relation_size('acc_balance_idx','main' ));
 pg_size_pretty
----------------
 13 MB

 -- З.Ы. Если не указать второй аргумент покажет будет main. Если у индекса смотреть vm будет всегда 0 (понятно же почему (О_о))

 /* Я везде использовал pg_pretty_siize что бы преобразовать размер в читаемы вид, но также можно преобразовать вывод в байты функцией pg_size_bytes */

 