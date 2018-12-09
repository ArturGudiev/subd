CONN / AS SYSDBA
ALTER SESSION SET CONTAINER = pdb1;

SHOW PARAMETER heat_map;

ALTER SYSTEM SET heat_map = ON;
SHOW PARAMETER heat_map;

--notice that disabled
CONN / AS SYSDBA
SHOW PARAMETER heat_map;
----------------------------

-------------------------------Do some work ------------------------------
ALTER SESSION SET CONTAINER = pdb1;

CREATE USER test IDENTIFIED BY test QUOTA UNLIMITED ON users;
GRANT CREATE SESSION, CREATE TABLE TO test;

CONN test/test@pdb1

CREATE TABLE t1 (
  id          NUMBER,
  description VARCHAR2(50),
  CONSTRAINT t1_pk PRIMARY KEY (id)
);

INSERT INTO t1
SELECT level,
       'Description for ' || level
FROM   dual
CONNECT BY level <= 10;
COMMIT;

SELECT * FROM   t1;

SELECT * FROM   t1 WHERE  id = 1;


-------------see information 

CONN / AS SYSDBA
ALTER SESSION SET CONTAINER = pdb1;

COLUMN object_name FORMAT A20

SELECT track_time,
       object_name,
       n_segment_write,
       n_full_scan,
       n_lookup_scan
FROM   v$heat_map_segment
ORDER BY 1, 2;

SET LINESIZE 100

COLUMN owner FORMAT A10
COLUMN segment_name FORMAT A20
COLUMN tablespace_name FORMAT A20

SELECT owner,
       segment_name, 
       segment_type,
       tablespace_name,
       segment_size
FROM   TABLE(DBMS_HEAT_MAP.object_heat_map('TEST','T1'));

---------------------------------
