mkdir F:\oracle\admin\curso\adump
mkdir F:\oracle\admin\curso\dpdump
mkdir F:\oracle\admin\curso\pfile
mkdir F:\oracle\cfgtoollogs\dbca\curso
mkdir F:\oracle\flash_recovery_area
mkdir F:\oracle\oradata
mkdir F:\oracle\product\11.1.0\db_1\database
set ORACLE_SID=curso
set PATH=%ORACLE_HOME%\bin;%PATH%
F:\oracle\product\11.1.0\db_1\bin\oradim.exe -new -sid CURSO -startmode manual -spfile 
F:\oracle\product\11.1.0\db_1\bin\oradim.exe -edit -sid CURSO -startmode auto -srvcstart system 
F:\oracle\product\11.1.0\db_1\bin\sqlplus /nolog @F:\oracle\admin\curso\scripts\curso.sql
