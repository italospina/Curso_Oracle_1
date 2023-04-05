connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool F:\oracle\admin\curso\scripts\cloneDBCreation.log
Create controlfile reuse set database "curso"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'&&file0',
'&&file1',
'&&file2',
'&&file3'
LOGFILE GROUP 1  SIZE 51200K,
GROUP 2  SIZE 51200K,
GROUP 3  SIZE 51200K RESETLOGS;
select name from v$controlfile;
exec dbms_backup_restore.zerodbid(0);
shutdown immediate;
startup nomount pfile="F:\oracle\admin\curso\scripts\initcursoTemp.ora";
Create controlfile reuse set database "curso"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'&&file0',
'&&file1',
'&&file2',
'&&file3'
LOGFILE GROUP 1  SIZE 51200K,
GROUP 2  SIZE 51200K,
GROUP 3  SIZE 51200K RESETLOGS;
alter system enable restricted session;
alter database "curso" open resetlogs;
alter database rename global_name to "curso";
set linesize 2048;
column ctl_files NEW_VALUE ctl_files;
select concat('control_files=''', concat(replace(value, ', ', ''','''), '''')) ctl_files from v$parameter where name ='control_files';
host "echo &ctl_files >>F:\oracle\admin\curso\scripts\init.ora";
host "echo &ctl_files >>F:\oracle\admin\curso\scripts\initcursoTemp.ora";
ALTER TABLESPACE TEMP ADD TEMPFILE SIZE 20480K AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED;
select tablespace_name from dba_tablespaces where tablespace_name='USERS';
select sid, program, serial#, username from v$session;
alter database character set INTERNAL_CONVERT WE8MSWIN1252;
alter database national character set INTERNAL_CONVERT AL16UTF16;
alter user sys identified by "&&sysPassword";
alter user system identified by "&&systemPassword";
alter system disable restricted session;
