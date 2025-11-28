pg_stat_archiver

Для отслеживанияпроцесса архивирования есть представление pg_stat_archiver

archived_count - общее кол-во сегментов, отправленных в архивиров
last_archived_wal - имя последнего сегмента, отправленного в архив
last_archived_time - отметка времени последней отправки сегмента в архив
failed_count - кол-во неудачных попыток отправки в архив
last_failed_wal - имя сегмента, при отправке которого 

table pg_stat_archiver \gx
-[ RECORD 1 ]------+------------------------------
archived_count     | 0
last_archived_wal  |
last_archived_time |
failed_count       | 0
last_failed_wal    |
last_failed_time   |
stats_reset        | 2025-11-19 19:06:13.398524+03


Как давно была последняя архивация? 
select *, now() - last_archived_time as last_archived_age from pg_stat_archiver \gx
-[ RECORD 1 ]------+------------------------------
archived_count     | 11
last_archived_wal  | 000000010000000200000047
last_archived_time | 2025-11-27 12:46:10.772499+03
failed_count       | 0
last_failed_wal    | <-- ошибок никаких нет
last_failed_time   | <-- ошибок никаких нет
stats_reset        | 2025-11-19 19:06:13.398524+03
last_archived_age  | 00:02:20.536733 <-- В нашем случае 2 минуты назад


Сколько файлов наодится в состоянии ожидания? 
 select count(*) from pg_ls_archive_statusdir() where name ~'.ready';
 count
-------
     0


Показывает статус и кол-во файлов в директории $PGDATA/pg_wal/archive_status/
Не путать с диреторией архивов wal. 
SELECT *
FROM pg_ls_archive_statusdir() ORDER BY modification;

Здесь мы можем осталдить например есть ли какой-то сегмент,
который выпал в ошибку при архивировании