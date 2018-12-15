
CONN books_admin/MyPassword
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
drop user test cascade;  
drop table e;
SHOW PARAMETER heat_map;

ALTER SYSTEM SET heat_map = ON;
SHOW PARAMETER heat_map;

CONN books_admin/MyPassword
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  

CREATE USER test IDENTIFIED BY test QUOTA UNLIMITED ON users;
GRANT CREATE SESSION, CREATE TABLE TO test;

CONN test/test

CREATE TABLE t1 (
  id          NUMBER,
  description VARCHAR2(50),
  CONSTRAINT t1_pk PRIMARY KEY (id)
);

INSERT INTO t1 
    SELECT level, 'Description for ' || level FROM  dual
CONNECT BY level <= 10;
COMMIT;


prompt ==========================================================================================
prompt        FULL SELECT
----------------------
conn books_admin/MyPassword
SELECT * FROM test.t1;
SELECT * FROM test.t1;
SELECT * FROM test.t1;
CONN books_admin/MyPassword;
COLUMN object_name FORMAT A20
SELECT track_time, object_name, n_segment_write, n_full_scan, n_lookup_scan FROM   v$heat_map_segment ORDER BY 1, 2;
---------------------------

prompt ==========================================================================================
prompt        SELECT BY PK
---------------------------
conn books_admin/MyPassword
SELECT * FROM test.t1 WHERE id = 1;
SELECT * FROM test.t1 WHERE id = 1;
SELECT * FROM test.t1 WHERE id = 1;
CONN books_admin/MyPassword;
COLUMN object_name FORMAT A20
SELECT track_time, object_name, n_segment_write, n_full_scan, n_lookup_scan FROM   v$heat_map_segment ORDER BY 1, 2;
--------------------------

prompt =============================================================================================
prompt    SELECT AND INSERT

-- 3 =========================================================
    ---------------------- prepare -------------------------------
    create table e (id int, x int);
    insert into e values (1, 1);
    insert into e values (2, 2);
    conn books_admin/MyPassword;
    select * from V$heat_map_segment;
    
    -- 3.1  ---------------- select from e ----------------------
    select * from e;
    select * from e;
    select * from e;
    insert into e values (3, 3);
    delete from e where id=3;
    conn books_admin/MyPassword;
    select * from V$heat_map_segment;
    --------------------------------------------------------

    -- 3.2  ------------insert and delete from e -----------------
    insert into e values (3, 3);
    delete from e where id=3; 
    
    conn books_admin/MyPassword;
    select * from V$heat_map_segment where object_name = 'E';
    --------------------------------------------------------------
