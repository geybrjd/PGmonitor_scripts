Размер индексов
 select
        coalesce(tablespace, 'pg_default') as teablespace,
        schemaname ||'.'|| tablename  as table,
        indexname as index,
        pg_size_pretty(pg_relation_size(indexname::regclass)) as size
from pg_indexes
order by pg_relation_size(indexname::regclass) desc
limit 10;
 teablespace |           table           |              index              |  size
-------------+---------------------------+---------------------------------+--------
 pg_default  | public.pgbench_accounts   | pgbench_accounts_pkey           | 43 MB
 pg_default  | public.pgbench_accounts   | acc_balance_idx                 | 13 MB
 pg_default  | pg_catalog.pg_depend      | pg_depend_reference_index       | 424 kB
 pg_default  | pg_catalog.pg_depend      | pg_depend_depender_index        | 352 kB
 pg_default  | pg_catalog.pg_proc        | pg_proc_proname_args_nsp_index  | 264 kB
 pg_default  | pg_catalog.pg_description | pg_description_o_c_o_index      | 216 kB
 pg_default  | pg_catalog.pg_attribute   | pg_attribute_relid_attnam_index | 128 kB
 pg_default  | pg_catalog.pg_collation   | pg_collation_name_enc_nsp_index | 104 kB
 pg_default  | pg_catalog.pg_attribute   | pg_attribute_relid_attnum_index | 88 kB
 pg_default  | pg_catalog.pg_proc        | pg_proc_oid_index               | 88 kB
