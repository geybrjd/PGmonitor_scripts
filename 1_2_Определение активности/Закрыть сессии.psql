# Закрыть сессиикоторая usename = pgbench которая висит дольше минуты

select pg_terminate_backend(pid) -- Важно! Ты убъешь транзакцию!!!
from pg_stat_activity
WHERE usename = 'pgbench' AND application_name = 'pgbench'
AND clock_timestamp() - coalesce(xact_start, query_start) > '00:01:00'::interval
AND state ~ 'idle in transaction';
 pg_terminate_backend
----------------------
 t

 -- xact_start опказывает время начала транзакции
 -- xact_query показывает время начала запроса