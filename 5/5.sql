set verify off;
set serveroutput on;

--host "del C:\Programming\Oracle\dp_dir\* /F"
--host cc subd dpclear
host subd dpclear
--host powershell  "& ""Remove-Item C:\Programming\Oracle\dp_dir\*"""

conn books_admin/MyPassword
alter session set "_ORACLE_SCRIPT"=true;  


declare
	res number;
begin
    DBMS_OUTPUT.put_line('---- Check if the user myschema exists');
	select count(1) into res from all_users where upper(username) = upper('myschema');
	if res <> 0 then
        DBMS_OUTPUT.put_line('---- Drop user myschema');
		execute immediate 'drop user myschema cascade';
	end if;	
    
    DBMS_OUTPUT.put_line('---- Check if the directory dp_dir exists');
	select count(1) into res from all_directories where upper(directory_name) = upper('dp_dir');
	if res <> 0 then
        DBMS_OUTPUT.put_line('---- Drop directory dp_dir');
		execute immediate 'drop directory dp_dir';
	end if;	    
end;	
/

create user myschema identified by myschema; 
ALTER USER myschema ACCOUNT UNLOCK;

grant connect, resource to myschema; 
GRANT CREATE ANY TABLE TO myschema;
ALTER USER myschema quota unlimited on USERS;

create directory dp_dir as 'C:\Programming\Oracle\dp_dir\';
GRANT READ, WRITE ON DIRECTORY dp_dir TO myschema;
GRANT READ, WRITE ON DIRECTORY dp_dir TO books_admin;

conn myschema/myschema

prompt ==============================================================
prompt ===========connected as myschema==============================
prompt ---------- Creating table ------------------------------------

create table products(id number, name varchar2(15));
insert into products values(1, 'bread');
insert into products values(2, 'butter');
insert into products values(3, 'milk');

commit;


conn books_admin/MyPassword
 
prompt ==============================================================
prompt ===========connected as books_admin==============================

select * from myschema.products;

select COUNT(1) from all_tables where upper(owner)='MYSCHEMA';

host C:\app\gudiea\virtual\product\12.2.0\dbhome_1\bin\expdp.exe books_admin/MyPassword schemas=myschema directory=dp_dir dumpfile=expdp_myschema.dmp logfile=expdp_myschema.log

drop user myschema cascade;

prompt ----------------after dropping --------------------------------

select COUNT(1) from all_tables where upper(owner)='MYSCHEMA';

host C:\app\gudiea\virtual\product\12.2.0\dbhome_1\bin\impdp.exe books_admin/MyPassword schemas=myschema directory=dp_dir dumpfile=expdp_myschema.dmp

select COUNT(1) from all_tables where upper(owner)='MYSCHEMA';

select * from myschema.products;
