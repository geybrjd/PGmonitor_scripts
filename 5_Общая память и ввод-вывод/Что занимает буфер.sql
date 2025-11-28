 select
        n.nspname,
        c.relname,
        count(*) as buffers,
        pg_size_pretty(count(*)* 8192) as bytes
from pg_buffercache b
join pg_class c
join pg_namespace n
on n.oid = c.relnamespace
on b.relfilenode = pg_relation_filenode(c.oid)
and b.reldatabase in (0,(select oid from pg_database where datname = current_database()))
group by n.nspname, c.relname
order by 3 desc limit 10;
  nspname   |             relname             | buffers |  bytes
------------+---------------------------------+---------+---------
 public     | pgbench_accounts_pkey           |    8404 | 66 MB
 public     | pgbench_accounts                |    7620 | 60 MB
 public     | pgbench_history                 |     144 | 1152 kB
 pg_catalog | pg_proc                         |      94 | 752 kB
 pg_catalog | pg_class                        |      13 | 104 kB
 pg_catalog | pg_amop_opr_fam_index           |       5 | 40 kB
 pg_catalog | pg_attribute_relid_attnum_index |       5 | 40 kB
 pg_catalog | pg_amop                         |       4 | 32 kB
 pg_catalog | pg_class_oid_index              |       4 | 32 kB
 pg_catalog | pg_attribute                    |       4 | 32 kB
