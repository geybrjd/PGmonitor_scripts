#Количество клиентов подключенных к БД

# есть два способа:

# 1

select datname, numbackends
from pg_stat_database
order by numbackends desc;
   datname    | numbackends
--------------+-------------
 fah_oltp     |           4
 pwr_workload |           3
 postgres     |           3
 test         |           2
 template0    |           0
 template1    |           0
              |           0

/* 
В выводе запроса для каждой базы можно увидеть текущее количество клиентских процессов, подключенных к ней. Однако представление pg_stat_database показывает информацию
о подключенных клиентах только в контексте баз данных, что может быть недостаточно для
более детального анализа. Также обратите внимание на строку с пустым именем в результате запроса: это служебная строка, объединяющая в себе статистику по разделяемым объектам,
которые доступны во всех БД, но при этом не принадлежат ни одной из них. Все такие объекты
принадлежат системному каталогу
*/



# 2 более подробно

select client_addr, usename, datname, count(*)
from pg_stat_activity
group by 1,2,3
order by 4 desc;
  client_addr  | usename  |   datname    | count
---------------+----------+--------------+-------
               |          |              |     4
               | postgres |              |     3
 172.17.33.101 | postgres | pwr_workload |     3
 172.17.33.101 | postgres | postgres     |     2
 172.17.33.101 | postgres | test         |     1
 172.23.40.15  | exporter | fah_oltp     |     1
 127.0.0.1     | postgres | postgres     |     1
               | postgres | fah_oltp     |     1
 172.23.40.11  | sv_admin | fah_oltp     |     1
 172.23.40.20  | exporter | fah_oltp     |     1
 172.23.40.20  | postgres |              |     1
               | postgres | test         |     1


# В этом примере клиенты сгруппированы по адресу подключения, имени пользователя и имени БД
# Если в client_addr null, это говорит о том, что клиент подключен через UNIX-сокет
# Для отсеивания фоновых служб можно выставить условие backend_type='client backen'