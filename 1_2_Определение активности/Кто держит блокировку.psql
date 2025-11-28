# Поле pg_blocking_pids покажет того кто заблокировал:

SELECT pid, pg_blocking_pids(pid), query
             FROM pg_stat_activity
            WHERE backend_type = 'client backend'
              AND wait_event_type = 'Lock';
 pid   | pg_blocking_pids |                                      query
--------+------------------+---------------------------------------------------------------------------------
 886598 | {907459}         | update pgbench_accounts set abalance = abalance + 1 where aid = 56 and bid = 1;
