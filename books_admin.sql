CREATE USER books_admin IDENTIFIED BY MyPassword;

GRANT CONNECT TO books_admin;

GRANT CONNECT, RESOURCE, DBA TO books_admin;
GRANT CREATE SESSION TO books_admin;
--GRANT ANY PRIVILEGE TO books_admin;
GRANT UNLIMITED TABLESPACE TO books_admin;