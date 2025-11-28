#!/bin/bash

if [ $# -ne 4 ]; then 
	echo "Usage: $(basename $0) NCPU MEM_GB MAX_CONN MAX_VAC_WORKERS"
	echo "Example: ./$(basename $0) 8 64 200 4"
	exit
fi;


MEM_TOTAL=$(($2*1024*1024*1024))
MAX_CONN=$3
MAX_VACUUM_WORKER=$4

MAX_WORKERS=$(( $1 - 2 ))

function calc_more_settings {
#shared_buffers 1/4 Memory Total
	SHARED_BUF=$((${MEM_TOTAL}/4194304))
	S1=$((3*${MAX_CONN}/2+2*${MAX_VACUUM_WORKER}))
	HALF_MEM=$((${MEM_TOTAL}/2097152))
#work_memory округляем до чётного, мне так больше нравится и не меньше 4МБ
	WORK_MEM=$((${HALF_MEM}/S1/2*2))
	[ $WORK_MEM -lt 4 ] && WORK_MEM=4

#temp_buffers = 0.5 work_mem .
	TEMP_BUF=$((${WORK_MEM}/2))

#maintenance_work_mem = 2*work_mem, но не меньше 64МБ
	MAINT_MEM=$((2*$WORK_MEM))
	[ $MAINT_MEM -lt 64 ] && MAINT_MEM=64


	echo "
ALTER SYSTEM SET max_worker_processes = ${MAX_WORKERS};
ALTER SYSTEM SET max_connections = ${MAX_CONN};
ALTER SYSTEM SET max_prepared_transactions = $(($MAX_CONN-1));
ALTER SYSTEM SET autovacuum_max_workers = ${MAX_VACUUM_WORKER};
ALTER SYSTEM SET shared_buffers = '${SHARED_BUF}MB';
ALTER SYSTEM SET effective_cache_size = '${HALF_MEM}MB';
ALTER SYSTEM SET work_mem = '${WORK_MEM}MB';
ALTER SYSTEM SET maintenance_work_mem = '${MAINT_MEM}MB';
ALTER SYSTEM SET temp_buffers = '${TEMP_BUF}MB';
ALTER SYSTEM SET shared_preload_libraries='pg_stat_statements';
ALTER SYSTEM SET log_line_prefix = '[%m u=%u d=%d h=%r p=%p l=%l txid=%x vxid=%v ] ';
ALTER SYSTEM SET vacuum_cost_limit = $((${MAX_VACUUM_WORKER} * 60));
ALTER SYSTEM SET max_parallel_workers_per_gather=$(( $MAX_WORKERS * 2 / 8 ));
ALTER SYSTEM SET max_parallel_workers = $(( $MAX_WORKERS ));
--ALTER SYSTEM SET wal_keep_segments=1000;
ALTER SYSTEM SET max_wal_size='32GB';
ALTER SYSTEM SET pg_stat_statements.track='all';
ALTER SYSTEM SET log_lock_waits='on';
ALTER SYSTEM SET log_min_duration_statement='500ms';
ALTER SYSTEM SET log_checkpoints='on';
ALTER SYSTEM SET log_connections='on';
ALTER SYSTEM SET log_disconnections='on';
ALTER SYSTEM SET log_temp_files = 0;
ALTER SYSTEM SET log_autovacuum_min_duration = 0;
ALTER SYSTEM SET random_page_cost=1.2;
ALTER SYSTEM SET autovacuum_naptime='10s';
ALTER SYSTEM SET autovacuum_vacuum_scale_factor=0.05;
ALTER SYSTEM SET autovacuum_analyze_scale_factor=0.05;
ALTER SYSTEM SET autovacuum_vacuum_threshold=10000;
ALTER SYSTEM SET autovacuum_analyze_threshold=2000;
"
}

calc_more_settings;


