--archive status

--cmd ou putty

ARCHIVE Log list;

--colocar banco em modo noarchived
sqlplus Sys/Oracle as Sysdba
shutdown IMMEDIATE;
Startup MOUNT;
ALTER DATABASE noarchivelog;
ALTER DATABASE OPEN;
ARCHIVE Log list;


--
shutdown IMMEDIATE;
EXIT;
ou
Host

--trocar datafile de local
--arquivo destino tem que existir

SELECT * FROM v$datafile

->cd D:\oracle\oradata\CURSO\DATAFILES
->copy tbs_aluno.dbf
D:\oracle\oradata\BACKUP\tbs_aluno2.dbf

SQL> Startup MOUNT;

SQL> 
ALTER DATABASE RENAME FILE 'C:\Oracle\oradata\tbs_dados.dbf' TO 'c:\backup\tbs_dados.dbf';

SQL> Alter database open;

SELECT name FROM v$datafile;

connect sys/oracle as sysdba

Shutdown IMMEDIATE;
Startup mount

ALTER DATABASE RENAME FILE 'c:\backup\tbs_dados.dbf' TO 'C:\Oracle\oradata\tbs_dados.dbf';

Alter Database open;

--caso dar algum erro ao abrir realizar o recover para sincronizar e recuperar os arquivos do banco
Shutdown IMMEDIATE;

Startup mount

recover database;

alter database open;

--Recovery do banco de dados
Shutdown IMMEDIATE;
startup MOUNT;
recover database until cancel;
alter database open resetlogs;

SELECT * FROM V$RECOVER_FILE;

SELECT * FROM V$LOG_HISTORY;

SELECT * FROM V$RECOVERY_LOG;

--Limpando logfile nao arquivado
shutdown IMMEDIATE;
startup MOUNT;

ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 1;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 2;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 3;

ALTER DATABASE OPEN;

--recriando log
SELECT * FROM V$LOGFILE;

ALTER DATABASE DROP LOGFILE GROUP 3;

ALTER DATABASE ADD LOGFILE GROUP 4
'D:\oracle\oradata\CURSO\ONLINELOG\redoO4.log' size 10M;

SELECT * FROM V$RECOVERY_FILE_STATUS;

SELECT * FROM V$RECOVERY_STATUS;