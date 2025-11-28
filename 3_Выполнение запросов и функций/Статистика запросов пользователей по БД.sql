-- Статистика запросов пользователей по базам данных

SELECT pg_get_userbyid(s.userid) AS username, d.datname, count(*)
FROM pg_stat_statements s, pg_database d
WHERE s.dbid = d.oid
GROUP BY 1,2 ORDER BY 3 DESC;
 username |   datname    | count
----------+--------------+-------
 exporter | fah_oltp     |   104
 postgres | postgres     |    17
 postgres | test         |    15
 sv_admin | fah_oltp     |    11
 postgres | pwr_workload |     8
 postgres | fah_oltp     |     8

-- В данном примере используется pg_stat_statements в случае с pgpro_stats заменить на pgpro_stat_statements
-- pg_get_userbyid функция, которая преобразует userid в читаемое имя. 
-- В этом примере мы видим, что больше всего запросов было обращено пользователем exporter к БД fah_oltp

select pg_get_userbyid(s.userid) AS username,
        s.query
from pgpro_stats_statements s
left join pg_database d on s.dbid=d.oid
where d.datname = 'fah_oltp'
and pg_get_userbyid(s.userid) = 'postgres';
 username |                                          query
----------+-----------------------------------------------------------------------------------------
 postgres | BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY
 postgres | SET lock_timeout=3000
 postgres | SELECT st.*,stio.idx_blks_read,stio.idx_blks_hit,CASE l.relation WHEN st.indexrelid THE.
          |.N $1 ELSE pg_relation_size(st.indexrelid) END relsize,$2,pg_class.reltablespace as tabl.
          |.espaceid,(ix.indisunique OR con.conindid IS NOT NULL) AS indisunique,pg_class.relpages:.
          |.:bigint * current_setting($3)::bigint AS relpages_bytes,$4 AS relpages_bytes_diff FROM .
          |.pg_catalog.pg_stat_all_indexes st JOIN pg_catalog.pg_statio_all_indexes stio USING (rel.
          |.id, indexrelid, schemaname, relname, indexrelname) JOIN pg_catalog.pg_index ix ON (ix.i.
          |.ndexrelid = st.indexrelid) JOIN pg_catalog.pg_class ON (pg_class.oid = st.indexrelid) L.
          |.EFT OUTER JOIN pg_catalog.pg_constraint con ON (con.conindid = ix.indexrelid AND con.co.
          |.ntype in ($5,$6)) LEFT OUTER JOIN LATERAL (SELECT relation FROM pg_catalog.pg_locks WHE.
          |.RE (relation = st.indexrelid AND granted AND locktype = $7 AND mode=$8)) l ON (l.relati.
          |.on = st.indexrelid)
 postgres | SET search_path=''
 postgres | COMMIT
 postgres | SET application_name='pgpro_pwr'
 postgres | SELECT f.funcid,f.schemaname,f.funcname,pg_get_function_arguments(f.funcid) AS funcargs.
          |.,f.calls,f.total_time,f.self_time,p.prorettype::regtype::text =$1 AS trg_fn FROM pg_cat.
          |.alog.pg_stat_user_functions f JOIN pg_catalog.pg_proc p ON (f.funcid = p.oid) WHERE pg_.
          |.get_function_arguments(f.funcid) IS NOT NULL
 postgres | SELECT st.relid,st.schemaname,st.relname,st.seq_scan,st.seq_tup_read,st.idx_scan,st.idx.
          |._tup_fetch,st.n_tup_ins,st.n_tup_upd,st.n_tup_del,st.n_tup_hot_upd,st.n_live_tup,st.n_d.
          |.ead_tup,st.n_mod_since_analyze,st.n_ins_since_vacuum,st.last_vacuum,st.last_autovacuum,.
          |.st.last_analyze,st.last_autoanalyze,st.vacuum_count,st.autovacuum_count,st.analyze_coun.
          |.t,st.autoanalyze_count,stio.heap_blks_read,stio.heap_blks_hit,stio.idx_blks_read,stio.i.
          |.dx_blks_hit,stio.toast_blks_read,stio.toast_blks_hit,stio.tidx_blks_read,stio.tidx_blks.
          |._hit,CASE locked.objid WHEN st.relid THEN $1 ELSE pg_catalog.pg_table_size(st.relid) - .
          |.coalesce(pg_catalog.pg_relation_size(class.reltoastrelid),$2) END relsize,$3 relsize_di.
          |.ff,class.reltablespace AS tablespaceid,class.reltoastrelid,class.relkind,class.relpages.
          |.::bigint * current_setting($4)::bigint AS relpages_bytes,$5 AS relpages_bytes_diff FROM.
          |. pg_catalog.pg_stat_all_tables st JOIN pg_catalog.pg_statio_all_tables stio USING (reli.
          |.d, schemaname, relname) JOIN pg_catalog.pg_class class ON (st.relid = class.oid) LEFT O.
          |.UTER JOIN LATERAL (WITH RECURSIVE deps (objid) AS (SELECT relation FROM pg_catalog.pg_l.
          |.ocks WHERE granted AND locktype = $6 AND mode=$7 UNION SELECT refobjid FROM pg_catalog..
          |.pg_depend d JOIN deps dd ON (d.objid = dd.objid)) SELECT objid FROM deps) AS locked ON .
          |.(st.relid = locked.objid)

/* Самое меньшее количество запросов поступает от postgres к pwr_workload и fah_oltp. Мы обратились 
к postgres в fah_oltp и убедились что к ней идет 8 запросов. Это не значит что их всего было 8
это говорит о том, что это остновные запросы, которые часто повторяются (кол-во поторений поле calls)*/