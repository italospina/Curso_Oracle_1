set echo off;
set serveroutput on;
select TO_CHAR(systimestamp,'YYYYMMDD HH:MI:SS') from dual;
variable devicename varchar2(255);
declare
omfname varchar2(512) := NULL;
  done boolean;
  begin
    dbms_output.put_line(' ');
    dbms_output.put_line(' Allocating device.... ');
    dbms_output.put_line(' Specifying datafiles... ');
       :devicename := dbms_backup_restore.deviceAllocate;
    dbms_output.put_line(' Specifing datafiles... ');
    dbms_backup_restore.restoreSetDataFile;
    dbms_backup_restore.getOMFFileName('SYSTEM',omfname);
    if (omfname IS NOT NULL) 
    THEN 
      dbms_backup_restore.restoreDataFileTo(1, omfname, 0, 'SYSTEM');
    ELSE 
      dbms_backup_restore.restoreDataFileTo(1, 'F:\oracle\oradata\curso\SYSTEM01.DBF', 0, 'SYSTEM');
    END IF; 
    dbms_backup_restore.getOMFFileName('SYSAUX',omfname);
    if (omfname IS NOT NULL) 
    THEN 
      dbms_backup_restore.restoreDataFileTo(2, omfname, 0, 'SYSAUX');
    ELSE 
      dbms_backup_restore.restoreDataFileTo(2, 'F:\oracle\oradata\curso\SYSAUX01.DBF', 0, 'SYSAUX');
    END IF; 
    dbms_backup_restore.getOMFFileName('UNDOTBS1',omfname);
    if (omfname IS NOT NULL) 
    THEN 
      dbms_backup_restore.restoreDataFileTo(3, omfname, 0, 'UNDOTBS1');
    ELSE 
      dbms_backup_restore.restoreDataFileTo(3, 'F:\oracle\oradata\curso\UNDOTBS01.DBF', 0, 'UNDOTBS1');
    END IF; 
    dbms_backup_restore.getOMFFileName('USERS',omfname);
    if (omfname IS NOT NULL) 
    THEN 
      dbms_backup_restore.restoreDataFileTo(4, omfname, 0, 'USERS');
    ELSE 
      dbms_backup_restore.restoreDataFileTo(4, 'F:\oracle\oradata\curso\USERS01.DBF', 0, 'USERS');
    END IF; 
    dbms_output.put_line(' Restoring ... ');
    dbms_backup_restore.restoreBackupPiece('F:\oracle\product\11.1.0\db_1\assistants\dbca\templates\Seed_Database.dfb', done);
    if done then
        dbms_output.put_line(' Restore done.');
    else
        dbms_output.put_line(' ORA-XXXX: Restore failed ');
    end if;
    dbms_backup_restore.deviceDeallocate;
  end;
/
select TO_CHAR(systimestamp,'YYYYMMDD HH:MI:SS') from dual;
