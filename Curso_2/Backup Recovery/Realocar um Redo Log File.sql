--Realocar um Redo Log File

select * from v$logfile;

--Etapas
shutdown immediate
startup mount

--CMD
copy C:\ORACLE\ORADATA\XE\REDO03.LOG C:\Oracle\oradata\XE\backup\redolog03.log


SQL> alter database rename file
          'C:\ORACLE\ORADATA\XE\REDO03.LOG'
          to
          'C:\Oracle\oradata\XE\backup\redolog03.log';

SQL> alter database open;

SQL> del C:\ORACLE\ORADATA\XE\REDO03.LOG

select * from v$logfile;