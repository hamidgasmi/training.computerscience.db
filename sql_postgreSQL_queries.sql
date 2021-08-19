--5. Tables
---- 5.1. Select existing tables
SELECT * 
  FROM information_schema.tables
 WHERE table_schema = 'schema_1'

--6. Index
---- 6.1. Select existing indexes:
SELECT schemaname, tablename, indexname, indexdef 
  FROM pg_indexes 
WHERE schemaname = 'schema_1'
  AND tablename = 'table_name';
  
---- 6.2. Create new indexe:

--7. Sessions:
-- 7.1. Select Session
SELECT * FROM pg_stat_activity;
SELECT pid FROM pg_stat_activity WHERE usename='app_user' and application_name='' and datname LIKE '%hamid';
-- 7.2. Terminate sessions
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid = 9102;
SELECT pg_terminate_backend(pid) FROM pg_stat_activity 
 WHERE pid IN (SELECT pid FROM pg_stat_activity) WHERE datname LIKE '%hamid');
 
 --8. Locks:
select pid, usename, pg_blocking_pids(pid) as blocked_by, query as blocked_query
from pg_stat_activity
where cardinality(pg_blocking_pids(pid)) > 0;

--9. Stat Activity
SELECT usename, application_name, xact_start, query, * 
  FROM pg_stat_activity
 WHERE datname = ''
   AND usename = ''
   AND application_name = ''
ORDER BY xact_start DESC

SELECT * FROM pg_catalog.pg_stat_database
SELECT * FROM pg_catalog.pg_database WHERE datname = ''


