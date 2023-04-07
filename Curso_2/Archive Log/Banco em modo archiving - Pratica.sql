--Configurando o Banco em Modo Archiving

SELECT NAME, VALUE FROM V$PARAMETER
WHERE name LIKE '%archive%';

SQL> ARCHIVE Log list

SQL> SHUTDOWN IMMEDIATE;
SQL> STARTUP MOUNT;
--para ativar
SQL> ALTER DATABASE ARCHIVELOG;--coloca o banco modoarquivo
SQL> ARCHIVE LOG START;
--para desativar
SQL> ALTER DATABASE NOARCHIVELOG

SQL> ALTER DATABASE OPEN;

-----------------------------------------------------------------------

--Outros Comandos

SELECT log_mode FROM v$database;

ALTER SYSTEM SET
log_archive_dest_1='LOCATION=c:\u01\oradata\MARCIO\archive1 MANDATORY REOPEN';

ALTER SYSTEM SET
log_archive_dest_2='SERVICE=standby_db1 MANDATORY REOPEN=600'

ALTER SYSTEM SET
log_archive_dest_3='LOCATION=c:\u01\oradata\MARCIO\archive2 OPTIONAL'

--ativar log archive
alter system archive log start;

--Parar log archive
alter system archive log stop;

--Forçar log archive
alter system archive log all;

--Forçar arquivamento log atual
alter system archive log current;

ALTER SYSTEM SET log_archive_min_succeed_dest = 2
ALTER SYSTEM SET LOG_ARCHIVE_MAX_PROCESSES = 5

SELECT NAME, VALUE FROM V$PARAMETER
WHERE name LIKE '%archive%';

SELECT * FROM v$archive_processes;

SELECT * FROM V$ARCHIVED_LOG;

SELECT * FROM V$ARCHIVE_DEST;