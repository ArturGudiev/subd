SELECT * FROM v$version;

select sys_context('userenv', 'ip_address') ip_address, port from gv$session where gv$session.inst_id = sys_context('userenv', 'instance') and gv$session.sid = sys_context('userenv', 'sid');
