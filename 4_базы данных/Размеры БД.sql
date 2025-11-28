Размеры БД

select
        t.spcname as tablespace,
        d.datname as dbname,
        pg_get_userbyid(d.datdba) as owner,
        pg_size_pretty(pg_database_size(d.datname)) as size
from pg_database d
join pg_tablespace t
on d.dattablespace = t.oid
order by pg_database_size(d.datname) desc;
 tablespace |  dbname   |  owner   |  size
------------+-----------+----------+---------
 pg_default | test      | postgres | 324 MB
 pg_default | postgres  | postgres | 8929 kB
 pg_default | template1 | postgres | 8713 kB
 pg_default | template0 | postgres | 8713 kB
