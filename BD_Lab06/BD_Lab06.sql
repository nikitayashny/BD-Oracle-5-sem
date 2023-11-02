-- 1.	������� �� ���������� ���������������� ����� SQLNET.ORA � TNSNAMES.ORA � ������������ � �� ����������.
-- C:\OracleDB\homes\OraDB21Home1\network\admin\sqlnet.ora 
-- ������� ������������ Listener�a. ��� ������� ��������� ����������, ��������������, ������������� ���� ������� � ��������� �� ���������� � �.�.
-- C:\OracleDB\homes\OraDB21Home1\network\admin\tnsnames.ora
-- ������������ ������� ���� (Net Service Names) � ������� ������������ ����������. ��� ��� ��������� ����.

-- 2.	����������� ��� ������ sqlplus � Oracle ��� ������������ SYSTEM, �������� �������� ���������� ���������� Oracle.
-- sqlplus
-- system/123
-- show parameter

-- 3.	����������� ��� ������ sqlplus � ������������ ����� ������ ��� ������������ SYSTEM, �������� ������ ��������� �����������, ������ ��������� �����������, ����� � �������������.
-- sqlplus 
-- system/123
-- alter session set container = XEPDB1;
-- select tablespace_name from dba_tablespaces;
-- select file_name from dba_data_files;
-- select role from dba_roles;

-- 4.	������������ � ����������� � HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE �� ����� ����������.
-- ORACLE_HOME: ���� � ��������� �������� Oracle, ��� ����������� ����� ������������ ����������� Oracle.
-- ORACLE_SID: ������������� ���������� ���� ������ Oracle, ������� ��������� �� ���������� ���� ������, � ������� �������� Oracle.
-- SQLPATH: ���� � ����������, ��� Oracle ���� SQL-������� � �����.
-- NLS_LANG: ���������� ������������ ���� � ����� �������� ��� ���� ������ Oracle.
-- TNS_ADMIN: ���� � ����������, ��� ��������� ����� ������������ ��� ������ ���������� TNS (Transparent Network Substrate), ������������ ��� ����������� � ����� ������ Oracle.
-- ORACLE_BASE: ������� �������, � ������� �������� ������������� ���������� Oracle.
-- ORACLE_UNQNAME: ���������� ��� ���� ������ Oracle.

-- 5.	��������� ������� Oracle Net Manager � ����������� ������ ����������� � ������ ���_������_������������_SID, ��� SID � ������������� ������������ ���� ������. 
-- sqlplus YNSCORE/1234@//localhost:1521/XEPDB1
-- connect YNSCORE/1234@LAB06

-- 6.	������������ � ������� sqlplus ��� ����������� ������������� � � ����������� �������������� ������ �����������. 
-- sqlplus YNSCORE/1234@//localhost:1521/XEPDB1

-- 7.	��������� select � ����� �������, ������� ������� ��� ������������. 
--  select count(*) from ynscore_names;

-- 8.	������������ � �������� HELP.�������� ������� �� ������� TIMING. �����������, ������� ������� ������ select � ����� �������.
-- help timing
-- set timing on;
-- select * from ynscore_names;

-- 9.	������������ � �������� DESCRIBE.�������� �������� �������� ����� �������.
-- desc ynscore_names;

-- 10.	�������� �������� ���� ���������, ���������� ������� �������� ��� ������������.
-- select * from user_segments;

-- 11.	�������� �������������, � ������� �������� ���������� ���� ���������, ���������� ���������, ������ ������ � ������ � ����������, ������� ��� ��������.
create view ynscore_segments as
select count(segment_name) segments_count, sum(extents) extents_count, 
sum(blocks) blocks_count, sum(bytes) byte_size
from user_segments;

select * from ynscore_segments;








