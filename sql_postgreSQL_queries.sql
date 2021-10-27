--0. Extensions:
---- 0.1. Get available extensions
select * from pg_available_extensions;
---- 0.1. Check loaded extensions
select * from pg_extension;
---- 0.2. Load uuid extension
CREATE EXTENSION "uuid-ossp";
SELECT uuid_generate_v1(); -- It should work


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
  
---- 6.2. Create new indexes:
CREATE INDEX idx_owner_id
    ON schema_1.record USING btree
    (owner_id ASC NULLS LAST)
    TABLESPACE pg_default;
---- 6.3. Disable an index:
update pg_index set indisvalid = false where indexrelid = 'my_index_name'::regclass

--7. Sequences
---- 7.3. Alter an existing sequence value
ALTER SEQUENCE my_schema.seq_name RESTART WITH 4700080;

--8. Sessions:
-- 8.1. Select Session
SELECT * FROM pg_stat_activity;
SELECT pid FROM pg_stat_activity WHERE usename='app_user' and application_name='' and datname LIKE '%hamid';
-- 8.2. Terminate sessions
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid = 9102;
SELECT pg_terminate_backend(pid) FROM pg_stat_activity 
 WHERE pid IN (SELECT pid FROM pg_stat_activity) WHERE datname LIKE '%hamid');
 
 --9. Locks:
select pid, usename, pg_blocking_pids(pid) as blocked_by, query as blocked_query
from pg_stat_activity
where cardinality(pg_blocking_pids(pid)) > 0;

--10. Stat Activity
SELECT usename, application_name, xact_start, query, * 
  FROM pg_stat_activity
 WHERE datname = ''
   AND usename = ''
   AND application_name = ''
ORDER BY xact_start DESC

SELECT * FROM pg_catalog.pg_stat_database
SELECT * FROM pg_catalog.pg_database WHERE datname = ''

--11. Log slow queries
SHOW config_file;
SELECT pg_reload_conf();
ALTER DATABASE datasets SET log_min_duration_statement = 5000000;
SELECT pg_sleep(10);
