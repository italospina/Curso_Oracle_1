set verify off
PROMPT specify a password for sys as parameter 1;
DEFINE sysPassword = &1
PROMPT specify a password for system as parameter 2;
DEFINE systemPassword = &2
PROMPT specify a password for sysman as parameter 3;
DEFINE sysmanPassword = &3
PROMPT specify a password for dbsnmp as parameter 4;
DEFINE dbsnmpPassword = &4
host F:\oracle\product\11.1.0\db_1\bin\orapwd.exe file=F:\oracle\product\11.1.0\db_1\database\PWDcurso.ora password=&&sysPassword force=y
@F:\oracle\admin\curso\scripts\CloneRmanRestore.sql
@F:\oracle\admin\curso\scripts\cloneDBCreation.sql
@F:\oracle\admin\curso\scripts\postScripts.sql
@F:\oracle\admin\curso\scripts\ultraSearchCfg.sql
@F:\oracle\admin\curso\scripts\lockAccount.sql
@F:\oracle\admin\curso\scripts\postDBCreation.sql
