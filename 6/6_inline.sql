
CONN books_admin/MyPassword
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
drop user inl cascade;  


CONN books_admin/MyPassword
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

CREATE USER inl IDENTIFIED BY inl QUOTA UNLIMITED ON users;
GRANT CREATE SESSION, CREATE TABLE TO inl;

CONN inl/inl;
create table A (id int, val varchar2(20), count int);
insert into A values (1, 'car', 4);
insert into A values (2, 'building', 15);
insert into A values (3, 'sea', 34);
insert into A values (4, 'choice', 72);
insert into A values (5, 'closure', 21);
/
column id format a5;

with function f(n number)
   return number as
   begin
     return n*20;
   end;
select f(1) from dual;
/

column value format a15;
/
with function f
   return varchar2 as
   begin
     return 'Hello World!';
   end;
select f as value from dual;
/

with function f(n number)
   return varchar2 as
   begin
        return 'const string';
    end;
select id, val, count, f(count) as value from A;
/

WITH 
PROCEDURE decrement(num in out number,
                   diff in number) 
IS  BEGIN   num := num - diff; END; 
FUNCTION dec_amount(v_pValue in number) RETURN number 
IS 
 v_xValue number; 
BEGIN 
   v_xValue := v_pValue; 
   decrement(v_xValue,10); 
   return v_xValue; 
END; 
SELECT  id, val, count, (dec_amount(count)) as decremented FROM A; 

/ 
WITH
 FUNCTION f(n number) return varchar2 IS
   begin
     if n<5 then 
       return 'small';
     elsif (n>5 AND n<50) then
       return 'medium';
     else 
       return 'big';
      end if;     
   end;  
select id, val, count, f(count) as value from A;