--Criação do diretório que será utilizado para gerar o arquivo:

-- Dar permissao de criar directory para o usuario aluno
grant create any directory to aluno

create or replace directory dpdir as 'C:\Oracle\data_pump';

--CMD Windows ou Terminal Linux

--Export/Import de esquemas

--Export
expdp system/123 schemas=aluno directory=dpdir dumpfile=curso.dmp logfile=dp.log

--Import
impdp system/123 schemas=aluno directory=dpdir dumpfile=curso.dmp logfile=dp2.log

Parametro: TABLE_EXISTS_ACTION=REPLACE