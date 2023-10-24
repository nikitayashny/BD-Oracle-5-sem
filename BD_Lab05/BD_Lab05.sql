alter session set container = CDB$ROOT;
alter session set container = XEPDB1;
-- 1.   ���������� ����� ������ ������� SGA.
select sum(value) from v$sga;

-- 2.	���������� ������� ������� �������� ����� SGA.
select component, current_size
from v$sga_dynamic_components
where component like '%pool%'

-- 3.	���������� ������� ������� ��� ������� ����.
select component, granule_size
from v$sga_dynamic_components
where component like '%pool%'

-- 4.	���������� ����� ��������� ��������� ������ � SGA.
select sum(bytes)
from v$sgastat
where name = 'free memory';

-- 5.	���������� ������������ � ������� ������ ������� SGA.
select component, current_size, max_size
from v$sga_dynamic_components;

-- 6.	���������� ������� ����� ���P, DEFAULT � RECYCLE ��������� ����.
select component, min_size, max_size, current_size
from v$sga_dynamic_components
where component IN ('KEEP buffer cache', 'RECYCLE buffer cache', 'DEFAULT buffer cache');

-- 7.	�������� �������, ������� ����� ���������� � ��� ���P.
create table keep_table (
  id number,
  name varchar(50)
) tablespace TS_YNS
  storage (buffer_pool keep);
  
-- ����������������� ������� �������.
select segment_name, segment_type, tablespace_name, buffer_pool
from user_segments 
where segment_name like 'KEEP%';

-- 8.	�������� �������, ������� ����� ������������ � ���� DEFAULT.
create table default_cache_table (
    id number,
    name varchar(50)
) cache tablespace TS_YNS;

-- ����������������� ������� �������. 
select segment_name, segment_type, tablespace_name, buffer_pool
from user_segments 
where segment_name like 'DEFAULT_CACHE%';

-- 9.	������� ������ ������ �������� �������.
show parameter log_buffer;

-- 10.	������� ������ ��������� ������ � ������� ����.
select pool, bytes
from v$sgastat
where pool = 'large pool' and name = 'free memory'

-- 11.	���������� ������ ������� ���������� � ��������� (dedicated, shared).  
SELECT username, server
FROM v$session
where username <> 'null';

-- 12.	�������� ������ ������ ���������� � ��������� ����� ������� ���������.
select paddr, name, description 
from v$bgprocess;
  
-- 13.	�������� ������ ���������� � ��������� ����� ��������� ���������.
select process, program
from v$session
  
-- 14.	����������, ������� ��������� DBWn �������� � ��������� ������.
select count(*)
from v$bgprocess
where name like 'DBW%';

-- 15.	���������� ������� (����� ����������� ����������).
select name, network_name, pdb from v$services;
  
-- 16.	�������� ��������� ��� ��������� �����������.
show parameter dispatcher;

-- 17.	������� � ������ Windows-�������� ������, ����������� ������� LISTENER.
-- services.msc -> OracleOraDB12Home1TNSListener

-- 18.	����������������� � �������� ���������� ����� LISTENER.ORA. 
-- C:\OracleDB\dbhomeXE\network\admin\sample\listener.ora

-- 19.	��������� ������� lsnrctl � �������� �� �������� �������
-- start: ��������� ������ Listener.
-- stop: ������������� ������ Listener.
-- status: ��������� ������� ������ ������ Listener.
-- services: ���������� ������ ��� ������, ��������� ����� Listener.
-- version: ���������� ������ ������ Listener.
-- reload: ������������� ������������ ������ Listener ��� ���������.
-- save_config: ��������� ������� ������������ ������ Listener � ����.
-- trace: �������� ��� ��������� ����������� ������� ��� ������ Listener.
-- quit ��� exit: ����� �� ������� lsnrctl.
-- set: ������������� ��������� ������������ ������ Listener.
-- show: ���������� ������� �������� ���������� ������������ ������ Listener.

-- 20.	�������� ������ ����� ��������, ������������� ��������� LISTENER. 
-- lsnrctl -> services


