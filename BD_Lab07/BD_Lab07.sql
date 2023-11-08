-- 1.	���������� ������� ��������� � ������� ������ ������������ ����������� �����. (��������� �� YNS)
alter session set container = YNS_PDB;
grant connect, create table, create view, create sequence, create cluster,
create synonym, create public synonym, create materialized view TO U1_YNS_PDB;

-- 2.	�������� ������������������ S1 (SEQUENCE), �� ���������� ����������������: ��������� �������� 1000; ���������� 10;
-- ��� ������������ ��������; ��� ������������� ��������; �� �����������; �������� �� ���������� � ������; ���������� �������� 
-- �� �������������. (�� ��������� �� U1_YNS_PDB)
drop sequence U1_YNS_PDB.S1;

create sequence U1_YNS_PDB.S1
start with 1000 -- ��������� ��������
increment by 10 -- ����������
nominvalue  -- ��� ������������ ��������
nomaxvalue  -- ��� ������������� ��������
nocycle -- �� �����������
nocache -- �� ����������
noorder;    -- ���������� �� �������������
-- �������� ��������� �������� ������������������. �������� ������� �������� ������������������.
select u1_yns_pdb.s1.nextval from dual;
select u1_yns_pdb.s1.nextval from dual;
select u1_yns_pdb.S1.currval from dual;


-- 3-4.	�������� ������������������ S2 (SEQUENCE), �� ���������� ����������������: ��������� �������� 10;
-- ���������� 10; ������������ �������� 100; �� �����������. �������� ��� �������� ������������������. 
-- ����������� �������� ��������, ��������� �� ������������ ��������.
drop sequence U1_YNS_PDB.S2;

create sequence U1_YNS_PDB.S2
start with 10
increment by 10
maxvalue 100
nocycle;

select u1_yns_pdb.s2.nextval from dual;

-- 5.	�������� ������������������ S3 (SEQUENCE), �� ���������� ����������������: ��������� �������� 10; ���������� -10; 
-- ����������� �������� -100; �� �����������; ������������� ���������� ��������. �������� ��� �������� ������������������. 
-- ����������� �������� ��������, ������ ������������ ��������.
drop sequence U1_YNS_PDB.S3;

create sequence u1_yns_pdb.s3 
start with 10
increment by -10
minvalue -100
maxvalue 10
nocycle
order;

select u1_yns_pdb.s3.nextval from dual;

-- 6.	�������� ������������������ S4 (SEQUENCE), �� ���������� ����������������: ��������� �������� 1; ���������� 1;
-- ����������� �������� 10; �����������; ���������� � ������ 5 ��������; ���������� �������� �� �������������.
-- ����������������� ����������� ��������� �������� ������������������� S4.
drop sequence U1_YNS_PDB.S4;

create sequence u1_yns_pdb.s4
start with 1
increment by 1
maxvalue 10
cycle
cache 5
noorder;

select u1_yns_pdb.s4.nextval from dual;

-- 7.	�������� ������ ���� ������������������� � ������� ���� ������, ���������� ������� �������� ������������ XXX.
select * from all_sequences where sequence_owner like 'U1_YNS_PDB';

-- 8.	�������� ������� T1, ������� ������� N1, N2, N3, N4, ���� NUMBER (20), ���������� � ������������� � �������� ���� KEEP.
-- � ������� ��������� INSERT �������� 7 �����, �������� �������� ��� �������� ������ ������������� 
-- � ������� ������������������� S1, S2, S3, S4.
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

-- 9.	�������� ������� ABC, ������� hash-��� (������ 200) � ���������� 2 ����: X (NUMBER (10)), V (VARCHAR2(12)).
create cluster u1_yns_pdb.abc 
(
    x number(10),
    v varchar2(12)
)
hashkeys 200 
tablespace yns_pdb_sys_ts;

-- 10.	�������� ������� A, ������� ������� XA (NUMBER (10)) � VA (VARCHAR2(12)),
-- ������������� �������� ABC, � ����� ��� ���� ������������ �������.
create table a
(
    xa number(10),
    va varchar(12),
    title varchar(200)
)
cluster u1_yns_pdb.abc(xa, va);

-- 11.	�������� ������� B, ������� ������� XB (NUMBER (10)) � VB (VARCHAR2(12)), ������������� �������� ABC, 
-- � ����� ��� ���� ������������ �������.
create table b
(
    xb number(10),
    vb varchar(12),
    album varchar(200)
)
cluster u1_yns_pdb.abc(xb, vb);

-- 12.	�������� ������� �, ������� ������� X� (NUMBER (10)) � V� (VARCHAR2(12)), ������������� �������� ABC,
-- � ����� ��� ���� ������������ �������. 
create table c
(
    xc number(10),
    vc varchar(12),
    artist varchar(200)
)
cluster u1_yns_pdb.abc(xc, vc);

-- 13.	������� ��������� ������� � ������� � �������������� ������� Oracle.
select * from dba_segments
where segment_type = 'CLUSTER';

select * from user_tables
where cluster_name = 'ABC';

-- 14.	�������� ������� ������� ��� ������� XXX.� � ����������������� ��� ����������.
create synonym artist_table_synonym for c;
select * from artist_table_synonym;
drop synonym artist_table_synonym;

-- 15.	�������� ��������� ������� ��� ������� XXX.B � ����������������� ��� ����������.
create public synonym artist_table_synonym for b;
select * from artist_table_synonym;
drop public synonym artist_table_synonym;

-- 16.	�������� ��� ������������ ������� A � B (� ��������� � ������� �������), ��������� �� �������, 
-- �������� ������������� V1, ���������� �� SELECT... FOR A inner join B. ����������������� ��� �����������������.
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

-- 17.	�� ������ ������ A � B �������� ����������������� ������������� MV, 
-- ������� ����� ������������� ���������� 2 ������. ����������������� ��� �����������������.
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
