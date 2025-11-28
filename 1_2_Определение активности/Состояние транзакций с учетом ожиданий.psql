# Отслеживание состояний с учетом ожиданий

/*
Для учета состояния ожидания блокировок есть два способа. первый и предпочтительный заключается в использовании событий ожидания. С помощью условия wait_event_type = 'Lock' процессы можно идентифицировать как находящиеся в ожидании блокировок
*/

# 1

select case when wait_event_type ='Lock'
then 'waiting' else state
end as state,
count(*)
from pg_stat_activity where backend_type = 'client backend'
group by 1 order by 2 desc;
        state        | count
---------------------+-------
 idle                |     5
 idle in transaction |     1
 waiting             |     1
 active              |     1


# 2

select case when not l.granted
then  'waiting' else state
end as state,
count(*)
from pg_stat_activity a
left join pg_locks l ON a.pid=l.pid AND NOT l.granted
where a.backend_type = 'client backend'
group by 1 order by 2 DESC;
        state        | count
---------------------+-------
 idle                |     5
 active              |     1
 idle in transaction |     1
 waiting             |     1


