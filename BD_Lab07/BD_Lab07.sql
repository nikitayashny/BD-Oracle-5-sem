-- 1.	Прочитайте задание полностью и выдайте своему пользователю необходимые права. (выполнять от YNS)
alter session set container = YNS_PDB;
grant connect, create table, create view, create sequence, create cluster,
create synonym, create public synonym, create materialized view TO U1_YNS_PDB;

-- 2.	Создайте последовательность S1 (SEQUENCE), со следующими характеристиками: начальное значение 1000; приращение 10;
-- нет минимального значения; нет максимального значения; не циклическая; значения не кэшируются в памяти; хронология значений 
-- не гарантируется. (всё выполнять от U1_YNS_PDB)
drop sequence U1_YNS_PDB.S1;

create sequence U1_YNS_PDB.S1
start with 1000 -- начальное значение
increment by 10 -- приращение
nominvalue  -- нет минимального значения
nomaxvalue  -- нет максимального значения
nocycle -- не циклическая
nocache -- не кэшируется
noorder;    -- хронология не гарантируется
-- Получите несколько значений последовательности. Получите текущее значение последовательности.
select u1_yns_pdb.s1.nextval from dual;
select u1_yns_pdb.s1.nextval from dual;
select u1_yns_pdb.S1.currval from dual;


-- 3-4.	Создайте последовательность S2 (SEQUENCE), со следующими характеристиками: начальное значение 10;
-- приращение 10; максимальное значение 100; не циклическую. Получите все значения последовательности. 
-- Попытайтесь получить значение, выходящее за максимальное значение.
drop sequence U1_YNS_PDB.S2;

create sequence U1_YNS_PDB.S2
start with 10
increment by 10
maxvalue 100
nocycle;

select u1_yns_pdb.s2.nextval from dual;

-- 5.	Создайте последовательность S3 (SEQUENCE), со следующими характеристиками: начальное значение 10; приращение -10; 
-- минимальное значение -100; не циклическую; гарантирующую хронологию значений. Получите все значения последовательности. 
-- Попытайтесь получить значение, меньше минимального значения.
drop sequence U1_YNS_PDB.S3;

create sequence u1_yns_pdb.s3 
start with 10
increment by -10
minvalue -100
maxvalue 10
nocycle
order;

select u1_yns_pdb.s3.nextval from dual;

-- 6.	Создайте последовательность S4 (SEQUENCE), со следующими характеристиками: начальное значение 1; приращение 1;
-- минимальное значение 10; циклическая; кэшируется в памяти 5 значений; хронология значений не гарантируется.
-- Продемонстрируйте цикличность генерации значений последовательностью S4.
drop sequence U1_YNS_PDB.S4;

create sequence u1_yns_pdb.s4
start with 1
increment by 1
maxvalue 10
cycle
cache 5
noorder;

select u1_yns_pdb.s4.nextval from dual;

-- 7.	Получите список всех последовательностей в словаре базы данных, владельцем которых является пользователь XXX.
select * from all_sequences where sequence_owner like 'U1_YNS_PDB';

-- 8.	Создайте таблицу T1, имеющую столбцы N1, N2, N3, N4, типа NUMBER (20), кэшируемую и расположенную в буферном пуле KEEP.
-- С помощью оператора INSERT добавьте 7 строк, вводимое значение для столбцов должно формироваться 
-- с помощью последовательностей S1, S2, S3, S4.
create table T1
(
    N1 number(20),
    N2 number(20),
    N3 number(20),
    N4 number(20)
) cache storage (buffer_pool keep);

begin
    for i in 1..7 loop
        insert into T1(N1, N2, N3, N4) values 
        (
            u1_yns_pdb.s1.nextval, u1_yns_pdb.s2.nextval,
            u1_yns_pdb.s3.nextval, u1_yns_pdb.s4.nextval
        );
    end loop;
end;

select * from T1;

-- 9.	Создайте кластер ABC, имеющий hash-тип (размер 200) и содержащий 2 поля: X (NUMBER (10)), V (VARCHAR2(12)).
create cluster u1_yns_pdb.abc 
(
    x number(10),
    v varchar2(12)
)
hashkeys 200 
tablespace yns_pdb_sys_ts;

-- 10.	Создайте таблицу A, имеющую столбцы XA (NUMBER (10)) и VA (VARCHAR2(12)),
-- принадлежащие кластеру ABC, а также еще один произвольный столбец.
create table a
(
    xa number(10),
    va varchar(12),
    title varchar(200)
)
cluster u1_yns_pdb.abc(xa, va);

-- 11.	Создайте таблицу B, имеющую столбцы XB (NUMBER (10)) и VB (VARCHAR2(12)), принадлежащие кластеру ABC, 
-- а также еще один произвольный столбец.
create table b
(
    xb number(10),
    vb varchar(12),
    album varchar(200)
)
cluster u1_yns_pdb.abc(xb, vb);

-- 12.	Создайте таблицу С, имеющую столбцы XС (NUMBER (10)) и VС (VARCHAR2(12)), принадлежащие кластеру ABC,
-- а также еще один произвольный столбец. 
create table c
(
    xc number(10),
    vc varchar(12),
    artist varchar(200)
)
cluster u1_yns_pdb.abc(xc, vc);

-- 13.	Найдите созданные таблицы и кластер в представлениях словаря Oracle.
select * from dba_segments
where segment_type = 'CLUSTER';

select * from user_tables
where cluster_name = 'ABC';

-- 14.	Создайте частный синоним для таблицы XXX.С и продемонстрируйте его применение.
create synonym artist_table_synonym for c;
select * from artist_table_synonym;
drop synonym artist_table_synonym;

-- 15.	Создайте публичный синоним для таблицы XXX.B и продемонстрируйте его применение.
create public synonym artist_table_synonym for b;
select * from artist_table_synonym;
drop public synonym artist_table_synonym;

-- 16.	Создайте две произвольные таблицы A и B (с первичным и внешним ключами), заполните их данными, 
-- создайте представление V1, основанное на SELECT... FOR A inner join B. Продемонстрируйте его работоспособность.
drop table CUSTOMERS;
drop table PRODUCERS;

create table CUSTOMERS (ID number(10) primary key);
create table PRODUCERS (ID number(10), foreign key (ID) references CUSTOMERS(ID));

    begin
        for i in 1..100 loop
            insert into CUSTOMERS(ID) values (u1_yns_pdb.s1.nextval);
            insert into PRODUCERS(ID) values (u1_yns_pdb.s1.currval);
        end loop;
    end;

select * from CUSTOMERS;
select * from PRODUCERS;

create view CUSTOMERS_AND_PRODUCERS_IDS
as select CUSTOMERS.ID CUST_ID, PRODUCERS.ID PROD_ID
from CUSTOMERS join PRODUCERS 
on CUSTOMERS.ID = PRODUCERS.ID;

select * from CUSTOMERS_AND_PRODUCERS_IDS;

-- 17.	На основе таблиц A и B создайте материализованное представление MV, 
-- которое имеет периодичность обновления 2 минуты. Продемонстрируйте его работоспособность.
select name, value from v$parameter where name like '%rewrite%';

drop materialized view MATERIAL_CUST_AND_PRODS_IDS;

create materialized view MATERIAL_CUST_AND_PRODS_IDS
build immediate
refresh force on demand
start with sysdate
next sysdate + numtodsinterval (2, 'MINUTE')
as select CUSTOMERS.ID CUST_ID, PRODUCERS.ID PROD_ID
from CUSTOMERS join PRODUCERS 
on CUSTOMERS.ID = PRODUCERS.ID;

select * from MATERIAL_CUST_AND_PRODS_IDS;
