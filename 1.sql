create table userroles (
    id number  GENERATED ALWAYS AS IDENTITY, 
    name varchar2(50), 
    description varchar2(50), 
    canModifyRecords number(1), 
    canModifyUserAccounts number(1)) ;

ALTER TABLE userroles 
  ADD (
    CONSTRAINT userroles_pk PRIMARY KEY (id)
  );

insert into userroles (name, description, canModifyRecords, canModifyUserAccounts) 
      values ('guest', 'Can only see records', 0, 0);   
insert into userroles (name, description, canModifyRecords, canModifyUserAccounts) 
      values ('user', 'Can perform base actions', 1, 0); 
insert into userroles (name, description, canModifyRecords, canModifyUserAccounts)
      values ('developer', 'Can execute high level operations', 1, 0);
insert into userroles (name, description, canModifyRecords, canModifyUserAccounts)
      values ('admin', 'Can execute high level operations', 1, 1);

create table users (
    id number GENERATED ALWAYS AS IDENTITY, 
    userrole_id number, 
    name varchar2(50),
    
    CONSTRAINT fk_userrole_id 
    FOREIGN KEY (userrole_id)  
    REFERENCES userroles (id)
);

CREATE INDEX index_user
  ON users (name);



insert into users (userrole_id, name) values (1, 'unknown guest'); 
insert into users (userrole_id, name) values (2, 'chris');
insert into users (userrole_id, name) values (2, 'alex');
insert into users (userrole_id, name) values (2, 'joahna');
insert into users (userrole_id, name) values (3, 'adam');
insert into users (userrole_id, name) values (4, 'admin');

-- view
CREATE VIEW V_USERS AS SELECT  id, userrole_id, name FROM users;

drop view V_USERS; 
drop table users;
drop table userroles;



--function
CREATE OR REPLACE FUNCTION secondsToHours (seconds IN NUMBER)
RETURN NUMBER
IS
         hours NUMBER;
BEGIN
          hours := FLOOR(seconds / (60*60));
          RETURN hours;
END secondsToHours;
/
--procedure
CREATE OR REPLACE PROCEDURE convertSeconds
      ( seconds 		IN 	NUMBER, 
         minutes 	         OUT 	NUMBER, 
         hours 	                 OUT 	NUMBER
       )
IS
BEGIN
     minutes := FLOOR(seconds / 60);
     hours := FLOOR(seconds / (60*60));
END convertSeconds;


