Redo Log Buffer, LGWR e Redo Log Files

--Para adicionar membros a grupos
Alter database [database]
add logfile [group integer] filespec
        [, [group integer] filespec] ...]

--Para remover membros a grupos
Alter database [database]
drop logfile 
        {group integer | 
        ('filename' [,'filename']...)}
        [, {group integer |
            ('filename' [, 'filename']...)}]...


--Visões dinamicas
select * from v$log;
select * from v$logfile;
select * from v$log_history;