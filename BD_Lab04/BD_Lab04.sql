ALTER SESSION SET CONTAINER = XEPDB1;

--------------------------------------------------------------------------------------------------------------------------------

-- 1. �������� ������ ���� ������ ��������� ����������� (������������  � ���������). (��������� �� YNS)
select file_id, tablespace_name, file_name from dba_data_files;
select file_id, tablespace_name, file_name from dba_temp_files;

--------------------------------------------------------------------------------------------------------------------------------

-- 2. �������� ��������� ������������ � ������ YNS_QDATA (10m). ��� �������� ���������� ��� � ��������� offline. (��������� �� YNS)
create tablespace YNS_QDATA
  datafile 'YNS_QDATA_NEW.dbf'
  size 10M
  offline;

-- ����� ���������� ��������� ������������ � ��������� online. (��������� �� YNS)
alter tablespace YNS_QDATA online;

-- �������� ������������ XXXCORE ����� 2m � ������������ YNS_QDATA. (��������� �� YNS)
alter user YNSCORE quota 2M on YNS_QDATA;

-- �� ����� YNSCORE � ������������ YNS_QDATA �������� ������� �� ���� ��������, ���� �� ������� ����� �������� ��������� ������. (��������� �� YNSCORE)
create table YNSCORE_NAMES
(
  id number,
  name varchar(50),
  CONSTRAINT PK_YNSCORE primary key (id)
) tablespace YNS_QDATA;

-- � ������� �������� 3 ������. (��������� �� YNSCORE)
insert into YNSCORE_NAMES values (1, 'Nikita');
insert into YNSCORE_NAMES values (2, 'Arina');
insert into YNSCORE_NAMES values (3, 'Ilya');
commit;
--------------------------------------------------------------------------------------------------------------------------------

-- 3. �������� ������ ��������� ���������� ������������ YNS_QDATA. (��������� �� YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA';

-- ���������� ������� ������� YNSCORE_NAMES. (��������� �� YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA'
  and segment_name = 'YNSCORE_NAMES';
  
-- ���������� ��������� ��������. (��������� �� YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA'
  and segment_name <> 'YNSCORE_NAMES';
  
--------------------------------------------------------------------------------------------------------------------------------

-- 4. ������� (DROP) ������� YNSCORE_NAMES. (��������� �� YNSCORE)
drop table YNSCORE_NAMES;

-- �������� ������ ��������� ���������� ������������  YNS_QDATA. (��������� �� YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA';

-- ���������� ������� ������� YNSCORE_NAMES. (��������� �� YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA'
  and segment_name = 'YNSCORE_NAMES';
  
-- ��������� SELECT-������ � ������������� USER_RECYCLEBIN, �������� ���������. (��������� �� YNSCORE)
select * from user_recyclebin;

--------------------------------------------------------------------------------------------------------------------------------

--5. ������������ (FLASHBACK) ��������� �������. (��������� �� YNSCORE)
flashback table YNSCORE_NAMES to before drop;

--------------------------------------------------------------------------------------------------------------------------------

-- 6. ��������� PL/SQL-������, ����������� ������� YNSCORE_NAMES ������� (10000 �����). (��������� �� YNSCORE)
begin
  for x in 4..10000
  loop
    insert into YNSCORE_NAMES values(x, 'noname');
  end loop;
end;
commit;

--------------------------------------------------------------------------------------------------------------------------------

-- 7. ���������� ������� � �������� ������� YNSCORE_NAMES ���������, �� ������ � ������ � ������. (��������� �� YNSCORE)
select segment_name, segment_type, tablespace_name, bytes, blocks, extents 
from user_segments
where segment_name = 'YNSCORE_NAMES';

-- �������� �������� ���� ���������. (��������� �� YNSCORE)
select * from user_extents
where tablespace_name = 'YNS_QDATA'

--------------------------------------------------------------------------------------------------------------------------------

-- 8. ������� ��������� ������������ YNS_QDATA � ��� ����. (��������� �� YNS)
drop tablespace YNS_QDATA including contents and datafiles;

--------------------------------------------------------------------------------------------------------------------------------

-- 9. �������� �������� ���� ����� �������� �������. (��������� �� YNS)
select * from v$log;

-- ���������� ������� ������ �������� �������. (��������� �� YNS)
select * from v$log where status = 'CURRENT';

--------------------------------------------------------------------------------------------------------------------------------

-- 10. �������� �������� ������ ���� �������� ������� ��������. (��������� �� YNS)
select * from v$logfile;

--------------------------------------------------------------------------------------------------------------------------------

-- 11. EX. � ������� ������������ �������� ������� �������� ������ ���� ������������. 
-- �������� ��������� ����� � ������ ������ ������� ������������ (��� ����������� ��� ���������� ��������� �������).
alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
alter session set container = CDB$ROOT;

alter system switch logfile;
select sysdate from dual;
select * from v$log;

--------------------------------------------------------------------------------------------------------------------------------

-- 12. EX. �������� �������������� ������ �������� ������� � ����� ������� �������. 
-- ��������� � ������� ������ � ������, � ����� � ����������������� ������ (�������������). ���������� ������������������ SCN. 
alter database add logfile 
    group 4 
    'C:\OracleDB\oradata\XE\REDO04.LOG'
    size 50m 
    blocksize 512;

alter database add logfile 
    member 
    'C:\OracleDB\oradata\XE\REDO04_1.LOG' 
    to group 4;
    
alter database add logfile 
    member 
    'C:\OracleDB\oradata\XE\REDO04_2.LOG' 
    to group 4;

select * from v$log;
select * from v$logfile;

--------------------------------------------------------------------------------------------------------------------------------

-- 13. EX. ������� ��������� ������ �������� �������. ������� ��������� ���� ����� �������� �� �������.

alter database drop logfile member 'C:\OracleDB\oradata\XE\REDO04_2.LOG';
alter database drop logfile member 'C:\OracleDB\oradata\XE\REDO04_1.LOG';
-- alter system checkpoint global;
alter database drop logfile group 4;

--------------------------------------------------------------------------------------------------------------------------------

-- 14. ����������, ����������� ��� ��� ������������� �������� ������� 
-- (������������� ������ ���� ���������, ����� ���������, ���� ������ ������� �������� ������� � ��������).
select dbid, name, log_mode from v$database; -- NOARCHIVELOG
select instance_name, archiver, active_state from v$instance; -- STOPPED

--------------------------------------------------------------------------------------------------------------------------------

-- 15. ���������� ����� ���������� ������.  
select * from v$archived_log; -- (�����������)

--------------------------------------------------------------------------------------------------------------------------------

-- 16. EX.  �������� �������������. 
--      SQLPLUS:
-- connect /as sysdba;
-- shutdown immediate;
-- startup mount;
-- alter database archivelog;
-- alter database open;

select dbid, name, log_mode from v$database; -- ARCHIVEMODE
select instance_name, archiver, active_state from v$instance; -- STARTED

--------------------------------------------------------------------------------------------------------------------------------

-- 17. EX. ������������� �������� �������� ����. ���������� ��� �����. ���������� ��� �������������� � ��������� � ��� �������. 
-- ���������� ������������������ SCN � ������� � �������� �������. (����������� �������)
select * from v$archived_log; -- ������ ����� ������� � ��� ���������� ������� ��� ��������, ������?

--------------------------------------------------------------------------------------------------------------------------------

-- 18. EX. ��������� �������������. ���������, ��� ������������� ���������.  
--      SQLPLUS:
-- connect /as sysdba;
-- shutdown immediate;
-- startup mount;
-- alter database noarchivelog;
-- alter database open;

select dbid, name, log_mode from v$database; -- NOARCHIVELOG
select instance_name, archiver, active_state from v$instance; -- STOPPED

--------------------------------------------------------------------------------------------------------------------------------

-- 19. �������� ������ ����������� ������.
select * from v$controlfile;

--------------------------------------------------------------------------------------------------------------------------------

-- 20. �������� � ���������� ���������� ������������ �����. �������� ��������� ��� ��������� � �����.
show parameter control;
--select * from v$controlfile_record_section;

--------------------------------------------------------------------------------------------------------------------------------

-- 21. ���������� �������������� ����� ���������� ��������. ��������� � ������� ����� �����. 
show parameter spfile;
select NAME, DESCRIPTION from v$parameter;

--------------------------------------------------------------------------------------------------------------------------------

-- 22. ����������� PFILE � ������ XXX_PFILE.ORA. ���������� ��� ����������. �������� ��������� ��� ��������� � �����.
create pfile = 'YNS_PFILE.ORA' from spfile; -- ����� sqlplus
-- C:\OracleDB\dbhomeXE\database

--------------------------------------------------------------------------------------------------------------------------------

-- 23. ���������� �������������� ����� ������� ��������. ��������� � ������� ����� �����. 
show parameter remote_login_passwordfile;  

--------------------------------------------------------------------------------------------------------------------------------

-- 24. �������� �������� ����������� ��� ������ ��������� � �����������. 
select * from v$diag_info;

--------------------------------------------------------------------------------------------------------------------------------

-- 25. EX. ������� � ���������� ���������� ��������� ������ �������� (LOG.XML),
-- ������� � ��� ������� ������������ �������� ������� �� ���������.
