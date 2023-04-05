connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool F:\oracle\admin\curso\scripts\ultraSearchCfg.log
alter user WKSYS account unlock identified by change_on_install;
@F:\oracle\product\11.1.0\db_1\ultrasearch\admin\wk0config.sql change_on_install (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=Marcio-Note)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=curso))) false " ";
spool off
