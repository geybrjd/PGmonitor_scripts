# Отслеживание состояний

/* По стотянию есть возможность отслеживания рабочей нагрузки и появления в ней разных анамалий */

select state, count(*)
from pg_stat_activity where backend_type = 'client backend'
group by 1 order by 2 desc;
        state        | count
---------------------+-------
 idle                |    10
 active              |     1
 idle in transaction |     1

