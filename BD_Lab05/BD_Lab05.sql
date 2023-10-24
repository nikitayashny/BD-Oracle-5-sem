alter session set container = CDB$ROOT;
alter session set container = XEPDB1;
-- 1.   Определите общий размер области SGA.
select sum(value) from v$sga;

-- 2.	Определите текущие размеры основных пулов SGA.
select component, current_size
from v$sga_dynamic_components
where component like '%pool%'

-- 3.	Определите размеры гранулы для каждого пула.
select component, granule_size
from v$sga_dynamic_components
where component like '%pool%'

-- 4.	Определите объем доступной свободной памяти в SGA.
select sum(bytes)
from v$sgastat
where name = 'free memory';

-- 5.	Определите максимальный и целевой размер области SGA.
select component, current_size, max_size
from v$sga_dynamic_components;

-- 6.	Определите размеры пулов КЕЕP, DEFAULT и RECYCLE буферного кэша.
select component, min_size, max_size, current_size
from v$sga_dynamic_components
where component IN ('KEEP buffer cache', 'RECYCLE buffer cache', 'DEFAULT buffer cache');

-- 7.	Создайте таблицу, которая будет помещаться в пул КЕЕP.
create table keep_table (
  id number,
  name varchar(50)
) tablespace TS_YNS
  storage (buffer_pool keep);
  
-- Продемонстрируйте сегмент таблицы.
select segment_name, segment_type, tablespace_name, buffer_pool
from user_segments 
where segment_name like 'KEEP%';

-- 8.	Создайте таблицу, которая будет кэшироваться в пуле DEFAULT.
create table default_cache_table (
    id number,
    name varchar(50)
) cache tablespace TS_YNS;

-- Продемонстрируйте сегмент таблицы. 
select segment_name, segment_type, tablespace_name, buffer_pool
from user_segments 
where segment_name like 'DEFAULT_CACHE%';

-- 9.	Найдите размер буфера журналов повтора.
show parameter log_buffer;

-- 10.	Найдите размер свободной памяти в большом пуле.
select pool, bytes
from v$sgastat
where pool = 'large pool' and name = 'free memory'

-- 11.	Определите режимы текущих соединений с инстансом (dedicated, shared).  
SELECT username, server
FROM v$session
where username <> 'null';

-- 12.	Получите полный список работающих в настоящее время фоновых процессов.
select paddr, name, description 
from v$bgprocess;
  
-- 13.	Получите список работающих в настоящее время серверных процессов.
select process, program
from v$session
  
-- 14.	Определите, сколько процессов DBWn работает в настоящий момент.
select count(*)
from v$bgprocess
where name like 'DBW%';

-- 15.	Определите сервисы (точки подключения экземпляра).
select name, network_name, pdb from v$services;
  
-- 16.	Получите известные вам параметры диспетчеров.
show parameter dispatcher;

-- 17.	Укажите в списке Windows-сервисов сервис, реализующий процесс LISTENER.
-- services.msc -> OracleOraDB12Home1TNSListener

-- 18.	Продемонстрируйте и поясните содержимое файла LISTENER.ORA. 
-- C:\OracleDB\dbhomeXE\network\admin\sample\listener.ora

-- 19.	Запустите утилиту lsnrctl и поясните ее основные команды
-- start: Запускает службу Listener.
-- stop: Останавливает службу Listener.
-- status: Проверяет текущий статус службы Listener.
-- services: Отображает список баз данных, доступных через Listener.
-- version: Отображает версию службы Listener.
-- reload: Перезагружает конфигурацию службы Listener без остановки.
-- save_config: Сохраняет текущую конфигурацию службы Listener в файл.
-- trace: Включает или отключает трассировку событий для службы Listener.
-- quit или exit: Выход из утилиты lsnrctl.
-- set: Устанавливает параметры конфигурации службы Listener.
-- show: Отображает текущие значения параметров конфигурации службы Listener.

-- 20.	Получите список служб инстанса, обслуживаемых процессом LISTENER. 
-- lsnrctl -> services


