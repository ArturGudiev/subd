-------------------------------------------------------------------

drop user s1; / 
drop user CAT_APP_USER cascade; / 

-------------------------------------------------------------------

create table A (id int ); /
insert into A values (1); /
insert into A values (2); /

create table B(name  varchar(50)); /
insert into B values ('A'); /
insert into B values ('B'); /

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

set serveroutput on; /

create or replace view VA as Select * FROM A where ROWNUM = 1; / 
create or replace view VB as Select * FROM B where ROWNUM = 1; /

-------------------------------------------------------------------

GRANT SELECT ON A TO CAT_APP_USER; /
GRANT SELECT ON B TO CAT_APP_USER; /
GRANT SELECT ON VA TO CAT_APP_USER; /
GRANT SELECT ON VB TO CAT_APP_USER; /

GRANT EXECUTE ON F1 to CAT_APP_USER; /
GRANT EXECUTE ON F2 to CAT_APP_USER; /

-------------------------------------------------------------------

SELECT * FROM s1.A; /  
SELECT * FROM s1.B; / 
SELECT * FROM s1.VA; / 
SELECT * FROM s1.VB; /

set serveroutput on;
execute s1.F1();    
execute s1.F2(); 
