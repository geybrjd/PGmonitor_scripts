Размер табличных пространств

select
        spcname,
        pg_tablespace_location(oid) as path,
        pg_size_pretty(pg_tablespace_size(spcname)) as size
from pg_tablespace
order by 2 desc;
  spcname   | path |  size
------------+------+--------
 pg_default |      | 349 MB
 pg_global  |      | 560 kB

 -- Путь не был прописан, потому что в дефолтных ТП его не прописывают, в кастомных он будет виден