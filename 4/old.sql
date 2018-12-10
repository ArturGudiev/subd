
create table books_admin.XX_MYEXAMPLE2 (
    id number,
    item varchar2(100),
    color varchar2(100), 
    price number,
    creation_date date
); / 

drop table books_admin.XX_MYEXAMPLE2; 

--insert into books_admin.XX_MYEXAMPLE2 values (1,'1','1',2, sysdate); /

column item format a10; \
column color format a10; \
select * from books_admin.XX_MYEXAMPLE2; 
/

sqlldr books_admin/MyPassword control=a2.ctl
----------------------------------------------------------------

create table books_admin.EXPERIMENTS (
    id number,
    x float,
    y float,
    z float,
    creation_date date, 
    last_modify_date date,
    str varchar2(50)
);

/
drop table books_admin.EXPERIMENTS; 
/
SELECT * FROM  books_admin.EXPERIMENTS; 
/

--sqlldr books_admin/MyPassword control=experiments.ctl

-----------------------test---------------------------------------
