conn books_admin/MyPassword

declare
BEGIN
	 EXECUTE IMMEDIATE 'DROP TABLE  books_admin.test';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
end;	
/



create table books_admin.test (
  id number,
  x number,
  y float,
  process_state varchar2(20), 
  creation_date date,
  update_date date
);

--drop table books_admin.test;
prompt ======================================
prompt ----------before insert--------------

select * from books_admin.test;

column process_state format a15; 
column creation_date format a15; 
column update_date format a15; 

prompt ======================================
prompt ----------launch sqlldr --------------

host C:\app\gudiea\virtual\product\12.2.0\dbhome_1\bin\sqlldr.exe books_admin/MyPassword control=C:\Artur\University\SUBD\4\test.ctl
--sqlldr books_admin/MyPassword control=C:\Artur\University\SUBD\4\test.ctl

prompt ======================================
prompt ----------after loading---------------

select * from books_admin.test;

--conn system/oracle 