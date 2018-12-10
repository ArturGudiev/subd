set verify off;
set serveroutput on;

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
 
