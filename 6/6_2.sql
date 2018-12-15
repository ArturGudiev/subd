--SELECT * FROM v$version;
--select sys_context('userenv', 'ip_address') ip_address, port from gv$session where gv$session.inst_id = sys_context('userenv', 'instance') and gv$session.sid = sys_context('userenv', 'sid');

CONN books_admin/MyPassword
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
--drop user test2 cascade;  
--ALTER SESSION SET CONTAINER = pdb1;

SHOW PARAMETER heat_map;

ALTER SYSTEM SET heat_map = ON;
SHOW PARAMETER heat_map;

CONN books_admin/MyPassword
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  

---------------------format heat map table
column object_name format a15;
column subobject_name format a15;
set linesize 200;

select * from V$heat_map_segment;

create table A123 (id int);
insert into A123 values (5);
insert into A123 values (6);

-- 1 -----------check select changes----------
select * from A123;
select * from A123;
select * from A123;
conn books_admin/MyPassword;
select * from V$heat_map_segment;
-------------------------------------------

-- 2 =========================================================
---------------------- prepare -------------------------------
create table salgrade(id int, val varchar2(50));
insert into salgrade values (1, 'a');
insert into salgrade values (2, 'b');

-------------check select changes----------
select * from salgrade;
select * from salgrade;
select * from salgrade;
conn books_admin/MyPassword;
select * from V$heat_map_segment;
-------------------------------------------

-- 3 =========================================================
    ---------------------- prepare -------------------------------
    create table e (id int, x int);
    insert into e values (1, 1);
    insert into e values (2, 2);

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

    -- 3.3  ------------ select with condition --------------------
    select * from e where id=2;
    select * from e where id=2;
    select * from e where id=2;
    
    conn books_admin/MyPassword;
    select * from V$heat_map_segment where object_name = 'E';
    

-- 4 =================================================================
    ------------before---------------------------
    conn sys as sysdba;
    startup force ;
    
    conn books_admin/MyPassword;
    select * from V$heat_map_segment;

    column owner format a15;
    select *  from dba_heat_map_seg_histogram;
    select object_name, track_time, segment_write, full_scan, lookup_scan  from dba_heat_map_seg_histogram;


--5 deeper =====================================================================
    select segment_name, block_id from table(dbms_heat_map.block_heat_map('books_admin','e'));
