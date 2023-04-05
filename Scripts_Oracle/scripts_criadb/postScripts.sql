connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool F:\oracle\admin\curso\scripts\postScripts.log
@F:\oracle\product\11.1.0\db_1\rdbms\admin\dbmssml.sql;
execute dbms_datapump_utl.replace_default_dir;
commit;
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set current_schema=ORDSYS;
@F:\oracle\product\11.1.0\db_1\ord\im\admin\ordlib.sql;
alter session set current_schema=SYS;
connect "SYS"/"&&sysPassword" as SYSDBA
connect "SYS"/"&&sysPassword" as SYSDBA
alter user CTXSYS account unlock identified by change_on_install;
connect "CTXSYS"/"change_on_install"
@F:\oracle\product\11.1.0\db_1\ctx\admin\defaults\dr0defdp.sql;
@F:\oracle\product\11.1.0\db_1\ctx\admin\defaults\dr0defin.sql "BRAZILIAN PORTUGUESE";
connect "SYS"/"&&sysPassword" as SYSDBA
execute ORACLE_OCM.MGMT_CONFIG_UTL.create_replace_dir_obj;
spool off
