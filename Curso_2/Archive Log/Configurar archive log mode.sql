--Para iniciar o Modo archive log
SQL> archive log list
Modo log de banco de dados   Modo Sem Arquivamento
Arquivamento automßtico             Desativado
Destino de arquivamento            C:\Oracle\homes\OraDB21Home1\RDBMS
A sequÛncia de log on-line mais antiga     36
SequÛncia de log atual           38
SQL> shutdown immediate;
Banco de dados fechado.
Banco de dados desmontado.
InstÔncia ORACLE desativada.
SQL> startup mount
InstÔncia ORACLE iniciada.

Total System Global Area  645921624 bytes
Fixed Size                  9857880 bytes
Variable Size             381681664 bytes
Database Buffers          251658240 bytes
Redo Buffers                2723840 bytes
Banco de dados montado.
SQL> alter database archivelog;

Banco de dados alterado.

SQL> alter database open;

Banco de dados alterado.

SQL> archive log list
Modo log de banco de dados     Modo de Arquivamento
Arquivamento automßtico             Ativado
Destino de arquivamento            C:\Oracle\homes\OraDB21Home1\RDBMS
A sequÛncia de log on-line mais antiga     36
Pr¾xima sequÛncia de log a arquivar   38
SequÛncia de log atual           38

--Para desativar o Modo archive log
SQL> shutdown immediate;
Banco de dados fechado.
Banco de dados desmontado.
InstÔncia ORACLE desativada.
SQL> startup mount
InstÔncia ORACLE iniciada.

Total System Global Area  645921624 bytes
Fixed Size                  9857880 bytes
Variable Size             381681664 bytes
Database Buffers          251658240 bytes
Redo Buffers                2723840 bytes
Banco de dados montado.
SQL> alter database noarchivelog;

Banco de dados alterado.

SQL> alter database open;

Banco de dados alterado.

