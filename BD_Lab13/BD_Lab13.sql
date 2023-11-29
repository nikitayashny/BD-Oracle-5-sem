alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';

create tablespace t1 datafile 't1.DAT'
    size 10M reuse autoextend on next 2M maxsize 20M;
create tablespace t2 datafile 't2.DAT'
    size 10M reuse autoextend on next 2M maxsize 20M;  
create tablespace t3 datafile 't3.DAT'
    size 10M reuse autoextend on next 2M maxsize 20M;  
create tablespace t4 datafile 't4.DAT'
    size 10M reuse autoextend on next 2M maxsize 20M;
  
--grant create tablespace to system;
--alter user system quota unlimited on t1;
--alter user system quota unlimited on t2;
--alter user system quota unlimited on t3;
--alter user system quota unlimited on t4;

-- 1.	Создайте таблицу T_RANGE c диапазонным секционированием. Используйте ключ секционирования типа NUMBER. 
create table T_RANGE( id number, TIME_ID date)
    partition by range(id)
    (
        partition P1 values less than (100) tablespace T1,
        partition P2 values less than (200) tablespace T2,
        partition P3 values less than (300) tablespace T3,
        partition PMAX values less than (maxvalue) tablespace T4
    );
    
insert into T_RANGE(id, TIME_ID) values(50,  '01-02-2018');
insert into T_RANGE(id, TIME_ID) values(105, '01-02-2017');
insert into T_RANGE(id, TIME_ID) values(205, '01-02-2016');
insert into T_RANGE(id, TIME_ID) values(305, '01-02-2015');
insert into T_RANGE(id, TIME_ID) values(405, '01-02-2015');
    
select * from T_RANGE partition(p1);
select * from T_RANGE partition(p2);
select * from T_RANGE partition(p3);
select * from T_RANGE partition(pmax);
select * from T_RANGE partition(p5);
    
select TABLE_NAME, PARTITION_NAME, HIGH_VALUE, TABLESPACE_NAME
from USER_TAB_PARTITIONS 
where table_name = 'T_RANGE';

-- 2.	Создайте таблицу T_INTERVAL c интервальным секционированием. Используйте ключ секционирования типа DATE.
create table T_INTERVAL(id number, time_id date)
    partition by range(time_id)
    interval (numtoyminterval(1,'month'))
    (
        partition p0 values less than(to_date ('1-12-2009', 'dd-mm-yyyy')),
        partition p1 values less than(to_date ('1-12-2015', 'dd-mm-yyyy')),
        partition p2 values less than(to_date ('1-12-2018', 'dd-mm-yyyy'))
    );
    
insert into T_INTERVAL(id, time_id) values(50, '01-02-2008');
insert into T_INTERVAL(id, time_id) values(105,'01-01-2009');
insert into T_INTERVAL(id, time_id) values(105,'01-01-2014');
insert into T_INTERVAL(id, time_id) values(205,'01-01-2015');
insert into T_INTERVAL(id, time_id) values(305,'01-01-2016');
insert into T_INTERVAL(id, time_id) values(405,'01-01-2018');
insert into T_INTERVAL(id, time_id) values(505,'01-01-2019');
   
select * from T_INTERVAL partition(p0);
select * from T_INTERVAL partition(p1);
select * from T_INTERVAL partition(P2);
select * from T_INTERVAL partition(SYS_P2285);   -- само создалось

select TABLE_NAME, PARTITION_NAME, HIGH_VALUE, TABLESPACE_NAME
from USER_TAB_PARTITIONS 
where table_name = 'T_INTERVAL';

-- 3.	Создайте таблицу T_HASH c хэш-секционированием. Используйте ключ секционирования типа VARCHAR2.
create table T_HASH (str varchar2 (50), id number)
    partition by hash (str)
    (
        partition k1 tablespace t1,
        partition k2 tablespace t2,
        partition k3 tablespace t3,
        partition k4 tablespace t4
    );
    
insert into T_HASH (STR,id) values('stroka 1', 1);
insert into T_HASH (str,id) values('stroka 2', 2);
insert into T_HASH (STR,id) values('stroka 3', 3);
insert into T_HASH (STR,id) values('stroka 4', 4);
insert into T_HASH (str,id) values('stroka 5', 5);
insert into T_HASH (str,id) values('stroka 6', 6);
insert into T_HASH (str,id) values('stroka 7', 7);
insert into T_HASH (str,id) values('stroka 8', 8);
insert into T_HASH (str,id) values('stroka 9', 9);
insert into T_HASH (str,id) values('stroka 0', 0);
insert into T_HASH (str,id) values('qwe', 10);
insert into T_HASH (str,id) values('q', 11);
insert into T_HASH (str,id) values('a', 12);
insert into T_HASH (STR,id) values('qweqweqwe', 13);
insert into T_HASH (str,id) values('some string', 14);
insert into T_HASH (str,id) values('i love db', 15);
    
select * from T_HASH partition(K1);
select * from T_HASH partition(k2);
select * from T_HASH partition(K3);
select * from T_HASH partition(K4);

select TABLE_NAME, PARTITION_NAME, HIGH_VALUE, TABLESPACE_NAME
from USER_TAB_PARTITIONS 
where table_name = 'T_HASH';

-- 4.	Создайте таблицу T_LIST со списочным секционированием. Используйте ключ секционирования типа CHAR.
create table T_LIST(obj char(3))
    partition by list (obj)
    (
        partition p1 values ('1'),
        partition p2 values ('2'),
        partition p3 values ('3')
    );
    
insert into T_LIST(obj) values('1');
insert into T_LIST(OBJ) values('2');
insert into T_LIST(OBJ) values('3');
    
select * from T_LIST partition (p1);
select * from T_LIST partition (p2);
select * from T_LIST partition (p3);
    
select TABLE_NAME, PARTITION_NAME, HIGH_VALUE, TABLESPACE_NAME
from USER_TAB_PARTITIONS 
where table_name = 'T_LIST';

-- 5.	Введите с помощью операторов INSERT данные в таблицы T_RANGE, T_INTERVAL, T_HASH, T_LIST. 
-- Данные должны быть такими, чтобы они разместились по всем секциям. Продемонстрируйте это с помощью SELECT запроса. 
-- ок

-- 6.	Продемонстрируйте для всех таблиц процесс перемещения строк между секциями, 
-- при изменении (оператор UPDATE) ключа секционирования.
alter table T_LIST enable row movement;
    update T_LIST set obj='1' where obj='2';
    
-- 7.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE MERGE.
alter table T_RANGE merge partitions
    p1,p2 into partition p5;
    
select * from T_RANGE partition (p5);

-- 8.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE SPLIT.
alter table T_INTERVAL split partition p2 at (to_date ('1-06-2018', 'dd-mm-yyyy')) 
    into (partition p6 tablespace t4, partition p5 tablespace t2);
    
    select * from T_INTERVAL partition (p5);
    select * from T_INTERVAL partition (p6);
    
-- 9.	Для одной из таблиц продемонстрируйте действие оператора ALTER TABLE EXCHANGE.
create table T_LIST1(obj char(3));
    alter table T_LIST exchange partition  p3 
        with table T_LIST1 without validation;
    select * from T_LIST partition (p3);
    select * from T_LIST1;
    
commit;
