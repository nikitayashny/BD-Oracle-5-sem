ALTER SESSION SET CONTAINER = XEPDB1;

--------------------------------------------------------------------------------------------------------------------------------

-- 1. Получите список всех файлов табличных пространств (перманентных  и временных). (выполнять от YNS)
select file_id, tablespace_name, file_name from dba_data_files;
select file_id, tablespace_name, file_name from dba_temp_files;

--------------------------------------------------------------------------------------------------------------------------------

-- 2. Создайте табличное пространство с именем YNS_QDATA (10m). При создании установите его в состояние offline. (выполнять от YNS)
create tablespace YNS_QDATA
  datafile 'YNS_QDATA_NEW.dbf'
  size 10M
  offline;

-- Затем переведите табличное пространство в состояние online. (выполнять от YNS)
alter tablespace YNS_QDATA online;

-- Выделите пользователю XXXCORE квоту 2m в пространстве YNS_QDATA. (выполнять от YNS)
alter user YNSCORE quota 2M on YNS_QDATA;

-- От имени YNSCORE в пространстве YNS_QDATA создайте таблицу из двух столбцов, один из которых будет являться первичным ключом. (выполнять от YNSCORE)
create table YNSCORE_NAMES
(
  id number,
  name varchar(50),
  CONSTRAINT PK_YNSCORE primary key (id)
) tablespace YNS_QDATA;

-- В таблицу добавьте 3 строки. (выполнять от YNSCORE)
insert into YNSCORE_NAMES values (1, 'Nikita');
insert into YNSCORE_NAMES values (2, 'Arina');
insert into YNSCORE_NAMES values (3, 'Ilya');
commit;
--------------------------------------------------------------------------------------------------------------------------------

-- 3. Получите список сегментов табличного пространства YNS_QDATA. (выполнять от YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA';

-- Определите сегмент таблицы YNSCORE_NAMES. (выполнять от YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA'
  and segment_name = 'YNSCORE_NAMES';
  
-- Определите остальные сегменты. (выполнять от YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA'
  and segment_name <> 'YNSCORE_NAMES';
  
--------------------------------------------------------------------------------------------------------------------------------

-- 4. Удалите (DROP) таблицу YNSCORE_NAMES. (выполнять от YNSCORE)
drop table YNSCORE_NAMES;

-- Получите список сегментов табличного пространства  YNS_QDATA. (выполнять от YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA';

-- Определите сегмент таблицы YNSCORE_NAMES. (выполнять от YNS)
select segment_name, segment_type
from dba_segments
where tablespace_name = 'YNS_QDATA'
  and segment_name = 'YNSCORE_NAMES';
  
-- Выполните SELECT-запрос к представлению USER_RECYCLEBIN, поясните результат. (выполнять от YNSCORE)
select * from user_recyclebin;

--------------------------------------------------------------------------------------------------------------------------------

--5. Восстановите (FLASHBACK) удаленную таблицу. (выполнять от YNSCORE)
flashback table YNSCORE_NAMES to before drop;

--------------------------------------------------------------------------------------------------------------------------------

-- 6. Выполните PL/SQL-скрипт, заполняющий таблицу YNSCORE_NAMES данными (10000 строк). (выполнять от YNSCORE)
begin
  for x in 4..10000
  loop
    insert into YNSCORE_NAMES values(x, 'noname');
  end loop;
end;
commit;

--------------------------------------------------------------------------------------------------------------------------------

-- 7. Определите сколько в сегменте таблицы YNSCORE_NAMES экстентов, их размер в блоках и байтах. (выполнять от YNSCORE)
select segment_name, segment_type, tablespace_name, bytes, blocks, extents 
from user_segments
where segment_name = 'YNSCORE_NAMES';

-- Получите перечень всех экстентов. (выполнять от YNSCORE)
select * from user_extents
where tablespace_name = 'YNS_QDATA'

--------------------------------------------------------------------------------------------------------------------------------

-- 8. Удалите табличное пространство YNS_QDATA и его файл. (выполнять от YNS)
drop tablespace YNS_QDATA including contents and datafiles;

--------------------------------------------------------------------------------------------------------------------------------

-- 9. Получите перечень всех групп журналов повтора. (выполнять от YNS)
select * from v$log;

-- Определите текущую группу журналов повтора. (выполнять от YNS)
select * from v$log where status = 'CURRENT';

--------------------------------------------------------------------------------------------------------------------------------

-- 10. Получите перечень файлов всех журналов повтора инстанса. (выполнять от YNS)
select * from v$logfile;

--------------------------------------------------------------------------------------------------------------------------------

-- 11. EX. С помощью переключения журналов повтора пройдите полный цикл переключений. 
-- Запишите серверное время в момент вашего первого переключения (оно понадобится для выполнения следующих заданий).
alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
alter session set container = CDB$ROOT;

alter system switch logfile;
select sysdate from dual;
select * from v$log;

--------------------------------------------------------------------------------------------------------------------------------

-- 12. EX. Создайте дополнительную группу журналов повтора с тремя файлами журнала. 
-- Убедитесь в наличии группы и файлов, а также в работоспособности группы (переключением). Проследите последовательность SCN. 
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

-- 13. EX. Удалите созданную группу журналов повтора. Удалите созданные вами файлы журналов на сервере.

alter database drop logfile member 'C:\OracleDB\oradata\XE\REDO04_2.LOG';
alter database drop logfile member 'C:\OracleDB\oradata\XE\REDO04_1.LOG';
-- alter system checkpoint global;
alter database drop logfile group 4;

--------------------------------------------------------------------------------------------------------------------------------

-- 14. Определите, выполняется или нет архивирование журналов повтора 
-- (архивирование должно быть отключено, иначе дождитесь, пока другой студент выполнит задание и отключит).
select dbid, name, log_mode from v$database; -- NOARCHIVELOG
select instance_name, archiver, active_state from v$instance; -- STOPPED

--------------------------------------------------------------------------------------------------------------------------------

-- 15. Определите номер последнего архива.  
select * from v$archived_log; -- (отсутствует)

--------------------------------------------------------------------------------------------------------------------------------

-- 16. EX.  Включите архивирование. 
--      SQLPLUS:
-- connect /as sysdba;
-- shutdown immediate;
-- startup mount;
-- alter database archivelog;
-- alter database open;

select dbid, name, log_mode from v$database; -- ARCHIVEMODE
select instance_name, archiver, active_state from v$instance; -- STARTED

--------------------------------------------------------------------------------------------------------------------------------

-- 17. EX. Принудительно создайте архивный файл. Определите его номер. Определите его местоположение и убедитесь в его наличии. 
-- Проследите последовательность SCN в архивах и журналах повтора. (переключить журналы)
select * from v$archived_log; -- удалил файлы вручную а при выполнении запроса они выдаются, почему?

--------------------------------------------------------------------------------------------------------------------------------

-- 18. EX. Отключите архивирование. Убедитесь, что архивирование отключено.  
--      SQLPLUS:
-- connect /as sysdba;
-- shutdown immediate;
-- startup mount;
-- alter database noarchivelog;
-- alter database open;

select dbid, name, log_mode from v$database; -- NOARCHIVELOG
select instance_name, archiver, active_state from v$instance; -- STOPPED

--------------------------------------------------------------------------------------------------------------------------------

-- 19. Получите список управляющих файлов.
select * from v$controlfile;

--------------------------------------------------------------------------------------------------------------------------------

-- 20. Получите и исследуйте содержимое управляющего файла. Поясните известные вам параметры в файле.
show parameter control;
--select * from v$controlfile_record_section;

--------------------------------------------------------------------------------------------------------------------------------

-- 21. Определите местоположение файла параметров инстанса. Убедитесь в наличии этого файла. 
show parameter spfile;
select NAME, DESCRIPTION from v$parameter;

--------------------------------------------------------------------------------------------------------------------------------

-- 22. Сформируйте PFILE с именем XXX_PFILE.ORA. Исследуйте его содержимое. Поясните известные вам параметры в файле.
create pfile = 'YNS_PFILE.ORA' from spfile; -- через sqlplus
-- C:\OracleDB\dbhomeXE\database

--------------------------------------------------------------------------------------------------------------------------------

-- 23. Определите местоположение файла паролей инстанса. Убедитесь в наличии этого файла. 
show parameter remote_login_passwordfile;  

--------------------------------------------------------------------------------------------------------------------------------

-- 24. Получите перечень директориев для файлов сообщений и диагностики. 
select * from v$diag_info;

--------------------------------------------------------------------------------------------------------------------------------

-- 25. EX. Найдите и исследуйте содержимое протокола работы инстанса (LOG.XML),
-- найдите в нем команды переключения журналов которые вы выполняли.
