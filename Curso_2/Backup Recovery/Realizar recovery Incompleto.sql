shutdown IMMEDIATE;
startup MOUNT;

recover database until cancel;
->CANCEL

recover database until TIME '2015-05-12';

recover DATABASE UNTIL CANCEL USING BACKUP CONTROLFILE;
->CANCEL

ALTER DATABASE RESETLOGS;


ALTER DATABASE OPEN;


SELECT * FROM v$logfile;

SELECT * FROM v$log;

--CONECTADO COMO ALUNO
CREATE TABLE ALUNO
(
CODIGO INTEGER NOT NULL PRIMARY KEY,
NOME VARCHAR(30)
);

INSERT INTO TALUNO VALUES (1,'MARCIO');
INSERT INTO TALUNO VALUES (2,'PAULA');


ALTER SYSTEM SWITCH LOGFILE;

SELECT * FROM v$log;

DROP TABLE Aluno;


--perda de logfile corrent;
shutdown IMMEDIATE;
startup MOUNT;

ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 1;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 2;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 3;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 4;

ALTER DATABASE OPEN;