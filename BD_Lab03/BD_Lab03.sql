ALTER SESSION SET CONTAINER = XEPDB1;

-- 1. �������� ������ ���� ������������ PDB � ������ ���������� ORA12W. ���������� �� ������� ���������.
SELECT name, open_mode
FROM v$pdbs;

-- 2. ��������� ������ � ORA12W, ����������� �������� �������� �����������.
SELECT instance_name, status, host_name
FROM gv$instance;

-- 3. ��������� ������ � ORA12W, ����������� �������� �������� ������������� ����������� ���� Oracle 12c � �� ������ � ������. 
SELECT comp_name, version, status
FROM dba_registry;

-- 4. �������� ����������� ��������� PDB (���������� ������������ � ������� � ���������� ���������� � ����������� Database
-- Configuration Assistant) � ������ XXX_PDB, ��� XXX � �������� ��������. 

-- 5. �������� ������ ���� ������������ PDB � ������ ���������� ORA12W. ���������, ��� ��������� PDB-���� ������ ����������.
SELECT name, open_mode
FROM v$pdbs;

-- 6. ������������ � XXX_PDB c ������� SQL Developer �������� ���������������� ������� 
-- (��������� ������������, ����, ������� ������������, ������������ � ������ U1_XXX_PDB).
ALTER SESSION SET CONTAINER = CDB$ROOT;

CREATE PLUGGABLE DATABASE YNS_PDB
   ADMIN USER U1_YNS_PDB IDENTIFIED BY password 
   FILE_NAME_CONVERT = ('C:\OracleDB\oradata\XE\pdbseed', 'C:\OracleDB\oradata\XE\yns_pdb')
   DEFAULT TABLESPACE users
   DATAFILE 'C:\OracleDB\oradata\XE\yns_pdb\system01.dbf' SIZE 100M AUTOEXTEND ON;

ALTER SESSION SET CONTAINER = YNS_PDB;

-- tablespaces
create tablespace YNS_PDB_SYS_TS
  datafile 'YNS_PDB_SYS_TS.dbf' 
  size 10M
  autoextend on next 2M
  maxsize 30M;
  
create temporary tablespace YNS_PDB_SYS_TS_TEMP
  tempfile 'YNS_PDB_SYS_TS_TEMP.dbf'
  size 10M
  autoextend on next 2M
  maxsize 20M;
  
  select * from dba_tablespaces where TABLESPACE_NAME like '%YNS%';
  
-- role
create role YNS_PDB_SYS_RL;

grant 
connect, 
create session, 
create any table, 
drop any table, 
create any view, 
drop any view, 
create any procedure, 
drop any procedure 
to YNS_PDB_SYS_RL;

select * from dba_roles where ROLE like '%RL%';
select * from dba_sys_privs where grantee like '%YNS%';

-- profile
create profile YNS_PDB_SYS_PROFILE limit
  password_life_time 365
  sessions_per_user 10
  failed_login_attempts 5
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  
-- user
grant YNS_PDB_SYS_RL to U1_YNS_PDB;
alter user U1_YNS_PDB IDENTIFIED BY 123;
alter user U1_YNS_PDB profile YNS_PDB_SYS_PROFILE;
alter user U1_YNS_PDB default tablespace YNS_PDB_SYS_TS;
alter user U1_YNS_PDB default tablespace YNS_PDB_SYS_TS;
alter user U1_YNS_PDB temporary tablespace YNS_PDB_SYS_TS_TEMP;
GRANT ALTER ANY TABLE TO U1_YNS_PDB;
GRANT SELECT_CATALOG_ROLE TO U1_YNS_PDB;
ALTER USER U1_YNS_PDB QUOTA UNLIMITED ON YNS_PDB_SYS_TS;
GRANT SET CONTAINER TO U1_YNS_PDB;

grant SYSDBA to U1_YNS_PDB;

select * from dba_users where USERNAME like '%YNS%';

-- 7. ������������ � ������������ U1_XXX_PDB, � ������� SQL Developer, 
-- �������� ������� XXX_table, �������� � ��� ������, ��������� SELECT-������ � �������
create table YNS_PDB_SYS_TABLE1 
(
  id number,
  name varchar(50)
);

insert into YNS_PDB_SYS_TABLE1 values (1, 'nikita');
insert into YNS_PDB_SYS_TABLE1 values (2, 'maxim');
insert into YNS_PDB_SYS_TABLE1 values (3, 'arina');
insert into YNS_PDB_SYS_TABLE1 values (4, 'andrew');
commit;

select * from YNS_PDB_SYS_TABLE1;

ALTER SESSION SET CONTAINER = YNS_PDB;

-- 8. � ������� ������������� ������� ���� ������ ����������, ��� ��������� ������������, ���  ����� (������������ � ���������),
-- ��� ���� (� �������� �� ����������), ������� ������������, ���� �������������  ���� ������ XXX_PDB �  ����������� �� ����
select * from dba_tablespaces;
select * from dba_temp_files;
select * from dba_roles;
select * from dba_sys_privs where GRANTEE like 'YNS%';
select * from dba_profiles;
select * from dba_users;

-- 9. ������������  � CDB-���� ������, �������� ������ ������������ � ������ C##XXX, ��������� ��� ����������, 
-- ����������� ����������� � ���� ������ XXX_PDB. �������� 2 ����������� ������������ C##XXX � SQL Developer � CDB-���� ������ 
-- �  XXX_PDB � ���� ������. ��������� �� �����������������
alter session set container = CDB$ROOT;

create user C##YNS identified by 123;

grant connect, create session, alter session, create any table,
drop any table to C##YNS container = all;

grant SYSDBA to C##YNS;

GRANT ALTER ANY TABLE TO C##YNS;
GRANT UNLIMITED TABLESPACE TO C##YNS;

-- YNS_PDB_Connection
create table YNS_PDB_2 (num number, str varchar(40));
select * from YNS_PDB_2;
insert into YNS_PDB_2 values (1, 'nikita');
commit;

-- YNS_CDB_Connection
create table YNS_CDB_2 (num number, str varchar(40));
select * from YNS_CDB_2;
insert into YNS_CDB_2 values (1, 'nikita');
commit;





  
