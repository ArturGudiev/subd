REM
REM                Version 0.01.0000
REM             Database creation script
REM
REM      This script must be run under SYS account
REM

set verify off;
set serveroutput on;
prompt Creating schema user...

accept user_name prompt 'Enter the user name: '
--accept schema_password prompt 'Please enter the password of the schema: '
REM accept oracle_service prompt 'Please enter the Oracle service name: '
--accept profile_name prompt 'Please enter the name of the profile to generate: '
accept app_user_name prompt 'Enter the application user name: '
accept app_user_role prompt 'Enter the application user role name: '


rem dropping the user, app user and role 
declare
	res number;
begin
    DBMS_OUTPUT.put_line('---- Check if the same user exists');
	select count(1) into res from all_users where upper(username) = upper('&user_name');
	if res <> 0 then
        DBMS_OUTPUT.put_line('---- Drop the same user');
		execute immediate 'drop user &user_name cascade';
	end if;	
    
    DBMS_OUTPUT.put_line('---- Check if the same  application user exists');
    select count(1) into res from all_users where upper(username) = upper('&app_user_name');
	if res <> 0 then
        DBMS_OUTPUT.put_line('---- Drop the same application user');
		execute immediate 'drop user &app_user_name cascade';
	end if;	

    DBMS_OUTPUT.put_line('---- Check if the same  application user role exists');
    select count(1) into res from dba_roles where upper(role) = upper('&app_user_role');
    if res <> 0 then
        DBMS_OUTPUT.put_line('---- Drop the same application user role');
    	execute immediate 'drop role &app_user_role';
	end if;
end;	
/

create user &user_name identified by &user_name; /
GRANT CONNECT, RESOURCE TO &user_name; /
GRANT CREATE VIEW TO &user_name;

create role &app_user_role;
GRANT CONNECT, RESOURCE TO &app_user_role; /

create user &app_user_name identified by &app_user_name; /
grant app_user_role to &app_user_name;
conn &user_name/&user_name
prompt ==============================================================
prompt ===========connected as developer user =======================
prompt ---- Creating 2 tables, 2 functions and 2 views

create table A (id int ); /
insert into A values (1); /
insert into A values (2); /

create table B(name  varchar(50)); /
insert into B values ('A'); /
insert into B values ('B'); /

create or replace view VA as Select * FROM A where ROWNUM = 1; / 
create or replace view VB as Select * FROM B where ROWNUM = 1; /


create or replace PROCEDURE F1 
IS
BEGIN
    dbms_output.put_line('Hello F1');
END F1;
/
create or replace PROCEDURE F2
IS
BEGIN
    dbms_output.put_line('Hello F2');
END F2;
/
prompt ==================================================
prompt     Grant privilegies on objects to app user
GRANT SELECT ON A TO app_user_role; /
GRANT SELECT ON B TO app_user_role; /
GRANT SELECT ON VA TO app_user_role; /
GRANT SELECT ON VB TO app_user_role; /

GRANT EXECUTE ON F1 to app_user_role; /
GRANT EXECUTE ON F2 to app_user_role; /


conn &app_user_name/&app_user_name
prompt =================================================================
prompt ===========connected as application user ========================


select * from &user_name..A; /
select * from &user_name..B; /
select * from &user_name..VA; /
select * from &user_name..VB; /

set serveroutput on;

execute &user_name..F1();    
execute &user_name..F2();    
