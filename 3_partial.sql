
conn books_admin/MyPassword;
alter session set "_ORACLE_SCRIPT"=true;  

set verify off;
set serveroutput on;
prompt Creating schema user...

accept user_name prompt 'Enter the user name: '
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

create user &user_name identified by &user_name; 
GRANT CONNECT, RESOURCE TO &user_name; 
GRANT CREATE ANY TABLE TO &user_name;
GRANT CREATE VIEW TO &user_name;

ALTER USER &user_name quota unlimited on USERS;

create role &app_user_role;
GRANT CONNECT, RESOURCE TO &app_user_role; 

create user &app_user_name identified by &app_user_name; 
grant &app_user_role to &app_user_name;
