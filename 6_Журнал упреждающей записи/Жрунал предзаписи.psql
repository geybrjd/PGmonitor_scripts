Журнал предзаписи:

pg_current_wal_insert_lsn — позиция последней вставленной в журнал записи;
pg_current_wal_lsn — позиция последней сохраненной на диск записи;
pg_current_wal_flush_lsn — позиция последней сохраненной и синхронизированной с диском записи.
pg_walfile_name - Какой wal сегмент исползуется для конкретной lsn

select pg_current_wal_lsn();
 pg_current_wal_lsn
--------------------
 2/3C000148

select pg_walfile_name('2/3C000148');
    pg_walfile_name
--------------------------
 00000001000000020000003C
