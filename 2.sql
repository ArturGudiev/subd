REM
REM                Version 0.01.0000
REM             Database creation script
REM
REM      This script must be run under SYS account
REM

set verify off;
set serveroutput on;
prompt Creating schema user...

accept user_name prompt 'Please enter the name of user to generate: '
accept schema_password prompt 'Please enter the password of the schema: '
REM accept oracle_service prompt 'Please enter the Oracle service name: '
--accept profile_name prompt 'Please enter the name of the profile to generate: '
--accept user_app_name prompt 'Please enter the name of the app user to generate: '


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
    
--    select count(1) into res from all_users where upper(username) = upper('&user_app_name');
--	if res <> 0 then
--		execute immediate 'drop user &user_app_name cascade';
--	end if;	
--    
--    select count(1) into res from dba_profiles where upper(username) = upper('&profile_name');
--    if res <> 0 then
--		execute immediate 'drop user &profile_name cascade';
--	end if;
end;	
/
--create profile &profile_name limit
--    IDLE_TIME		            1
--    SESSIONS_PER_USER           2; /
--    
create user &user_name identified by &user_name; /

--GRANT CONNECT, RESOURCE TO &user_name; /
--GRANT CREATE VIEW TO &user_name;

