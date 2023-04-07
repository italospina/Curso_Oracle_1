-- Quantidade de dias que fica armazenado informacoes de backup
SELECT NAME, VALUE FROM V$PARAMETER
WHERE NAME LIKE '%record_keep_time%';

select * from v$datafile;

--Sequencia
--Putty OU cmd

grant dba do marcio;

rman target marcio/123;

--Formato do arquivo backup
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT
'C:\Oracle\oradata\XE\backup\RMAN\%T_%s.rman';

CONFIGURE DEVICE TYPE DISK PARALLELISM 1
BACKUP TYPE TO BACKUPSET;

run {
shutdown immediate;
startup mount;
backup database include current controlfile tag 'backup';
alter database open;
}