connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool F:\oracle\admin\curso\scripts\postDBCreation.log
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='F:\oracle\product\11.1.0\db_1\database\spfilecurso.ora' FROM pfile='F:\oracle\admin\curso\scripts\init.ora';
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup ;
alter user SYSMAN identified by "&&sysmanPassword" account unlock;
alter user DBSNMP identified by "&&dbsnmpPassword" account unlock;
execute DBMS_AUTO_TASK_ADMIN.disable();
select 'utl_recomp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute utl_recomp.recomp_serial();
select 'utl_recomp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute dbms_swrf_internal.cleanup_database(cleanup_local => FALSE);
commit;
host F:\oracle\product\11.1.0\db_1\bin\emca.bat -config dbcontrol db -silent -DB_UNIQUE_NAME curso -PORT 1521 -EM_HOME F:\oracle\product\11.1.0\db_1 -LISTENER LISTENER -SERVICE_NAME curso -SYS_PWD &&sysPassword -SID curso -ORACLE_HOME F:\oracle\product\11.1.0\db_1 -DBSNMP_PWD &&dbsnmpPassword -HOST Marcio-Note -LISTENER_OH F:\oracle\product\11.1.0\db_1 -LOG_FILE F:\oracle\admin\curso\scripts\emConfig.log -SYSMAN_PWD &&sysmanPassword;
connect "SYS"/"&&sysPassword" as SYSDBA
spool F:\oracle\admin\curso\scripts\postDBCreation.log
