-- 1.	Найдите на компьютере конфигурационные файлы SQLNET.ORA и TNSNAMES.ORA и ознакомьтесь с их содержимым.
-- C:\OracleDB\homes\OraDB21Home1\network\admin\sqlnet.ora 
-- сетевая конфигурация Listener’a. Тут указаны настройки шифрования, аутентификации, разграничение прав доступа к листенеру по айпишникам и т.д.
-- C:\OracleDB\homes\OraDB21Home1\network\admin\tnsnames.ora
-- соответствие кратких имен (Net Service Names) и длинных дескрипторов соединений. Про это подробнее ниже.

-- 2.	Соединитесь при помощи sqlplus с Oracle как пользователь SYSTEM, получите перечень параметров экземпляра Oracle.
-- sqlplus
-- system/123
-- show parameter

-- 3.	Соединитесь при помощи sqlplus с подключаемой базой данных как пользователь SYSTEM, получите список табличных пространств, файлов табличных пространств, ролей и пользователей.
-- sqlplus 
-- system/123
-- alter session set container = XEPDB1;
-- select tablespace_name from dba_tablespaces;
-- select file_name from dba_data_files;
-- select role from dba_roles;

-- 4.	Ознакомьтесь с параметрами в HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE на вашем компьютере.
-- ORACLE_HOME: Путь к домашнему каталогу Oracle, где установлены файлы программного обеспечения Oracle.
-- ORACLE_SID: Идентификатор экземпляра базы данных Oracle, который указывает на конкретную базу данных, с которой работает Oracle.
-- SQLPATH: Путь к директории, где Oracle ищет SQL-скрипты и файлы.
-- NLS_LANG: Определяет используемый язык и набор символов для базы данных Oracle.
-- TNS_ADMIN: Путь к директории, где находятся файлы конфигурации для службы именования TNS (Transparent Network Substrate), используемой для подключения к базам данных Oracle.
-- ORACLE_BASE: Базовый каталог, в котором хранятся установленные компоненты Oracle.
-- ORACLE_UNQNAME: Уникальное имя базы данных Oracle.

-- 5.	Запустите утилиту Oracle Net Manager и подготовьте строку подключения с именем имя_вашего_пользователя_SID, где SID – идентификатор подключаемой базы данных. 
-- sqlplus YNSCORE/1234@//localhost:1521/XEPDB1
-- connect YNSCORE/1234@LAB06

-- 6.	Подключитесь с помощью sqlplus под собственным пользователем и с применением подготовленной строки подключения. 
-- sqlplus YNSCORE/1234@//localhost:1521/XEPDB1

-- 7.	Выполните select к любой таблице, которой владеет ваш пользователь. 
--  select count(*) from ynscore_names;

-- 8.	Ознакомьтесь с командой HELP.Получите справку по команде TIMING. Подсчитайте, сколько времени длится select к любой таблице.
-- help timing
-- set timing on;
-- select * from ynscore_names;

-- 9.	Ознакомьтесь с командой DESCRIBE.Получите описание столбцов любой таблицы.
-- desc ynscore_names;

-- 10.	Получите перечень всех сегментов, владельцем которых является ваш пользователь.
-- select * from user_segments;

-- 11.	Создайте представление, в котором получите количество всех сегментов, количество экстентов, блоков памяти и размер в килобайтах, которые они занимают.
create view ynscore_segments as
select count(segment_name) segments_count, sum(extents) extents_count, 
sum(blocks) blocks_count, sum(bytes) byte_size
from user_segments;

select * from ynscore_segments;








