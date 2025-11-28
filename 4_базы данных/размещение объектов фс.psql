Размещение объектов в файловой системе 

/*
1.	pg_relation_filenode - принемает идентификатор oid или имя объекта и возвращает номер файлового узла (filenode) который связан с объектом. Файловым узлом называется основной компонент имени файла, используемого для хранения данных. Для большинства таблиц этот номер совпадает со значением pg_class.relfilenode, но для некоторых системных каталогов это значение равно нулю, и, чтобы узнать действительное значение, нужно использовать эту функцию. Если указанное отношение не хранится на диске, как, например, представления, данная функция возвращает NULL; */
select pg_relation_filenode('pgbench_accounts');
 pg_relation_filenode
----------------------
                16432
select relname from pg_class where relfilenode = '16432';
     relname
------------------
 pgbench_accounts

 ls -l /pgdata/14/data/base/16419/ | grep 16432*
-rw-------. 1 postgres postgres 270172160 ноя 20 13:41 16432
-rw-------. 1 postgres postgres     90112 ноя 19 19:40 16432_fsm
-rw-------. 1 postgres postgres     16384 ноя 19 19:40 16432_vm


-- 2. pg_relation_filepath - возвращает путь к файлу отношения относительно основного каталога данных 

select pg_relation_filepath('pgbench_accounts');
 pg_relation_filepath
----------------------
 base/16419/16432

/*
3. pg_filenode_relation - функция обратная pg_relation_filenode, используется для поиска таблиц по номеру файлового узла 
select pg_filenode_relation(16432); -- Данный пример отсутствует, так как у меня нет такой функции. (может из-за версии)
*/

-- 4. pg_ls_logdir - содержимое каталога где хранятся журналы сообщений СУБД
select * from  pg_ls_logdir();
               name               | size  |      modification
----------------------------------+-------+------------------------
 postgresql-2025-11-19_192421.log |  3217 | 2025-11-19 19:44:50+03
 postgresql-2025-11-20_000000.log | 23061 | 2025-11-20 17:07:10+03
 postgresql-2025-11-21_000000.log | 10414 | 2025-11-21 14:56:48+03
 postgresql-Wed.log               |  8408 | 2025-11-19 19:24:21+03

-- 5. pg_ls_waldir - содержимое каталога pg_wal где хранятся сегменты wal-журнала
select * from pg_ls_waldir() order by modification desc;
           name           |   size   |      modification
--------------------------+----------+------------------------
 000000010000000000000018 | 16777216 | 2025-11-21 12:54:03+03
 000000010000000000000028 | 16777216 | 2025-11-21 12:49:45+03
 000000010000000000000027 | 16777216 | 2025-11-20 14:03:51+03
 000000010000000000000025 | 16777216 | 2025-11-20 13:35:59+03
 000000010000000000000022 | 16777216 | 2025-11-20 13:35:55+03

-- 6. pg_ls_archive_status_dir - содержимое pg_wal/pg_archive_status, где хранятся статусы архивирования отдельных wal сегментов
select * from pg_ls_archive_statusdir();
 name | size | modification
------+------+--------------
(0 строк) -- пусто потому что у меня не включена архивация

--7. pg_ls_tmpdir - содержимое каталога, используемое для хранения временных файлов
 select * from pg_ls_tmpdir();
 name | size | modification
------+------+--------------
(0 строк) -- пусто

-- 8. pg_ls_logiclamapdir - содержимое каталога pg_logical/mappings (У меня такой функции нет)
-- 9. pg_ls_logicalsnapdir — содержимое каталога pg_logical/snapshots (тоже нет)
-- 10. pg_ls_replslotdir - содержимое отдельного каталога слота репликации в pg_replslot (тоже нет)
-- 11. pg_ls_dir - универсальная команда для вывода содержимого каталога (включая те, что за пределами основного каталога данных)
select * from pg_ls_dir('/'); -- (в рамках прав доступа пользователя, под которым запущена СУБД)
 pg_ls_dir
------------
 dev
 sys
 lib
 home
 etc
 sbin
 bin
 lib64
 tmp
 lost+found
 var
 mnt
 media
 boot
 opt
 root
 proc
 pgdata
 srv
 run
 usr

-- 12. pg_read_file - Читает указанный текстовый файл и возвращает его содержимое
select pg_read_file('/etc/os-release');
                 pg_read_file
-----------------------------------------------
 NAME="RED OS"                                +
 VERSION="MUROM (7.3.6)"                      +
 PLATFORM_ID="platform:el7"                   +
 ID="redos"                                   +
 ID_LIKE="rhel centos fedora"                 +
 VERSION_ID="7.3"                             +
 PRETTY_NAME="RED OS MUROM (7.3.6)"           +
 ANSI_COLOR="0;31"                            +
 CPE_NAME="cpe:/o:redos:redos:7"              +
 HOME_URL="https://redos.red-soft.ru/"        +
 BUG_REPORT_URL="https://support.red-soft.ru/"+
 EDITION="Standard"                           +

 -- 13. pg_stat_file - выводит атрибуты указанного объекта
 select * from pg_stat_file('/etc/os-release');
 size |         access         |      modification      |         change         | creation | isdir
------+------------------------+------------------------+------------------------+----------+-------
  311 | 2025-11-20 20:04:19+03 | 2025-08-06 11:56:50+03 | 2025-10-21 12:40:15+03 |          | f
  		-- размер в байтах
  		-- время последнего обращения
  		-- время последнего изменения
  		-- время последнего изменения состояния
  		-- время создания (только в windows)
  		-- флаг указывающий, что объект является каталогом