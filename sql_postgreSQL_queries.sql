--0. Extensions:
---- 0.1. Get available extensions
select * from pg_available_extensions;
---- 0.1. Check loaded extensions
select * from pg_extension;
---- 0.2. Load uuid extension
CREATE EXTENSION "uuid-ossp";
SELECT uuid_generate_v1(); -- It should work

----0.9. Create session variable
SET SESSION vars.entity_id = 12887; -- from a constant
SELECT set_config('vars.entity_id', "id"::text, false) FROM schema_1.my_table WHERE guid = '63b0ab2f-2675-6668-e653-46f067fda6d5'; -- from a query
SELECT current_setting('vars.entity_id');
SELECT * FROM schema_1.my_table WHERE id = current_setting('vars.entity_id')::bigint;

--1. Analyze a query performance:
EXPLAIN ANALYZE SELECT *


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

---- 6.4. Drop index
DROP INDEX IF EXISTS my_schema.idx_name;

---- 6.7. analyze a table indexes
ANALYZE my_schema.table_name;

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

---- 10.1. stat all tables:
SELECT * FROM pg_stat_all_tables WHERE schemaname = 'schema_1' ORDER BY seq_tup_read DESC;

--11. Log slow queries
SHOW config_file;
SELECT pg_reload_conf();
ALTER DATABASE datasets SET log_min_duration_statement = 5000000;
SELECT pg_sleep(10);

---- 11.1.
SELECT * FROM pg_stat_statements
