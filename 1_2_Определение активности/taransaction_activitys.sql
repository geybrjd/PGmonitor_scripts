#Транзакционная активность

/* Запросы - базовая единица рабочей нагрузки. Запросы могут быть объединины в транзакции (либо выполняются полностью "commit", либо не выполняются вовсе "rollback").
По кол-ву выполняемых транзакций, можно сделать вывод, насколько активно используется БД. */ 

select datname, xact_commit + xact_rollback as xacts
from pg_stat_database
order by xact_commit + xact_rollback desc;
   datname    |  xacts
--------------+----------
 test         | 17677740
 fah_oltp     |  1714436
 postgres     |   112560
 pwr_workload |    16942
 template0    |        0
 template1    |        0
              |        0
