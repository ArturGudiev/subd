set verify off;
set serveroutput on;

--host "del C:\Programming\Oracle\dp_dir\* /F"
--host cc subd dpclear
host subd dpclear
--host powershell  "& ""Remove-Item C:\Programming\Oracle\dp_dir\*"""

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

create directory dp_dir as 'C:\Programming\Oracle\dp_dir\';
GRANT READ, WRITE ON DIRECTORY dp_dir TO myschema;
GRANT READ, WRITE ON DIRECTORY dp_dir TO system;

conn myschema/myschema

prompt ==============================================================
prompt ===========connected as myschema==============================
prompt ---------- Creating table ------------------------------------

create table products(id number, name varchar2(15));
insert into products values(1, 'bread');
insert into products values(2, 'butter');
insert into products values(3, 'milk');

commit;


conn system/oracle
 
prompt ==============================================================
prompt ===========connected as system==============================

select * from myschema.products;

select COUNT(1) from all_tables where upper(owner)='MYSCHEMA';

host C:\oraclexe\app\oracle\product\11.2.0\server\bin\expdp.exe system/oracle schemas=myschema directory=dp_dir dumpfile=expdp_myschema.dmp logfile=expdp_myschema.log

drop user myschema cascade;

prompt ----------------after dropping --------------------------------

select COUNT(1) from all_tables where upper(owner)='MYSCHEMA';

--host C:\oraclexe\app\oracle\product\11.2.0\server\bin\expdp.exe system/oracle schemas=myschema directory=dp_dir dumpfile=expdp_myschema.dmp logfile=expdp_myschema.log
