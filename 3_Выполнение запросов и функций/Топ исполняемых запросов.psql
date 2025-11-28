Топ часто исполняемых запросов

select
	sum(calls) as total_calls,
	left(query, 64) as query_trunc
from pg_stat_statements
group by query
order by sum(calls) desc
limit 10;

