-- Состояние реплики

select * from pg_stat_wal_receiver \gx
-[ RECORD 1 ]---------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------
pid                   | 136045
status                | streaming
receive_start_lsn     | B/B000000
receive_start_tli     | 38
written_lsn           | B/D87B610
flushed_lsn           | B/D87B610
received_tli          | 38
last_msg_send_time    | 2025-11-28 16:07:59.624404+03
last_msg_receipt_time | 2025-11-28 16:08:00.476313+03
latest_end_lsn        | B/D87B610
latest_end_time       | 2025-11-28 16:07:59.624404+03
slot_name             | node2
sender_host           | 172.23.40.15
sender_port           | 5432
conninfo              | dbname=postgres user=postgres passfile=/var/lib/pgsql/pgpass host=172.23.40.15 port=5432 sslmode=prefer application_name=node2 gssencmode=prefer channel_binding=prefer


Представление отражает состояние репликации со стороны процесса walreceiver и содержит следующую информацию:
pid - id процесса walreceiver в ОС
status - состояние процесса walreceiver
receive_start_lsn - позиция журнала на момент старта процесса walreceiver
receive_start_tli - линия времени в журнале на момент старта процесса walreceiver
written_lsn - позиция журнала соответствующая последним записанным, но еще не синхронизированным данным
flushed_lsn - позиция журнала соответствующая последним записанным и синхронизированным данным. Отправная точка для walreceiver
received_tli - номер линии времени (последний записанный и синхронизированный). Отправная линия для walreceiver
last_msg_send_time - время отправки последнего сообщения, полученного от основного узла
last_msg_receipt_time - время полученного последнего сообщения от основного узла
latest_end_lsn - позиция журнала, отправленная репликой основному узлу в последним сообщении
latest_end_time - время последней позиции в журнале отправленная основному узлу в последнем сообщении
slot_name - имя слота, используемое в данном сеансе репликации
sender_host - имя основного узла с котором установлено соединеине 
sender_port - номер сетевого порта основного узла
conninfo - строка подключения к основному узлу, используется walreceiver

В процессе нет информации о воспроизведении журнала, поскольку это задача процесса startupю

Плезные функции:
select pg_last_wal_receive_lsn(); -- последняя получанная позиция журнала
 pg_last_wal_receive_lsn
-------------------------
 B/D88C1C8

select pg_last_wal_replay_lsn(); -- последняя позиция журнала, записи до которой воспроизведены процессом startup
 pg_last_wal_replay_lsn
------------------------
 B/D88CF38

select pg_is_in_recovery(); -- находится ли СУБД в режиме восстановления
 pg_is_in_recovery
-------------------
 t

 