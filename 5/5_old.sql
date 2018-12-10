
expdp hr SCHEMAS=user3 directory=temp dumpfile=temp:user3.dmp logfile=temp:expdpuser3.log

ALTER USER user3 IDENTIFIED BY user3 ACCOUNT UNLOCK;

drop directory temp; \
CREATE OR REPLACE DIRECTORY temp AS 'C:\Artur\temp'; \
GRANT READ, WRITE ON DIRECTORY temp TO user3; \

drop user user3 cascade;

impdp hr SCHEMAS=user3 directory=temp dumpfile=temp:user3.dmp 


----before-------------------------------------------------------------------

drop user myschema cascade;
drop directory dp_dir;
-----------------------------------------------------------------------

create user myschema identified by myschema; 
ALTER USER myschema ACCOUNT UNLOCK;

grant connect, resource to myschema; 
ALTER USER user3 IDENTIFIED BY user3 ACCOUNT UNLOCK;

create directory dp_dir as 'C:\Programming\Oracle\dp_dir\';
GRANT READ, WRITE ON DIRECTORY dp_dir TO myschema;
GRANT READ, WRITE ON DIRECTORY dp_dir TO system;

GRANT READ, WRITE ON DIRECTORY dp_dir TO user1;

conn myschema/myschema

create table product(id number);
insert into product values(1);
commit;

--create directory dp_dir as 'C:\Programming\Oracle\dp_dir\';
exit 

expdp system/oracle schemas=myschema directory=dp_dir dumpfile=expdp_myschema.dmp logfile=expdp_myschema.log

[oracle@nepal Desktop]$ sqlplus / as sysdba

drop user myschema cascade;
exit

impdp system/oracle schemas=myschema directory=dp_dir dumpfile=expdp_myschema.dmp

sqlplus / as sysdba
conn myschema/myschema

select table_name from tabs;
select * from product;

------------additional 
--ALTER USER myschema IDENTIFIED BY myschema ACCOUNT UNLOCK;
alter user myschema account unlock;
grant connect, resource to myschema;

alter user system account unlock;
grant connect, resource to system;

alter user user1 account unlock;
grant connect, resource to user1;

conn myschema/myschema