alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';

-- 1.	�������� �������, ������� ��������� ���������, ���� �� ������� ��������� ����.
create table SEMESTER_5 
(
    SUBJECT varchar(200) primary key, 
    EXAMS varchar(100)
);

-- 2.	��������� ������� �������� (10 ��.).
insert into SEMESTER_5 values ('���', '�������');
insert into SEMESTER_5 values ('��',   '�������');
insert into SEMESTER_5 values ('��',  '�������');
insert into SEMESTER_5 values ('���������',  '�������');
insert into SEMESTER_5 values ('����������',  '�������');
insert into SEMESTER_5 values ('��', '�����');
insert into SEMESTER_5 values ('����',  '�����');
insert into SEMESTER_5 values ('���', '�����');
insert into SEMESTER_5 values ('���', '�����');

insert into SEMESTER_5 values ('���', '�������');
update SEMESTER_5 set EXAMS = '�����' where SUBJECT = '���';
delete SEMESTER_5 where SUBJECT = '���';

select * from SEMESTER_5;
select * from AUDITS;

-- 3.	�������� BEFORE � ������� ������ ��������� �� ������� INSERT, DELETE � UPDATE. 
create or replace trigger INSERT_TRIGGR_BEFORE_STATEMENT
before insert on SEMESTER_5
begin DBMS_OUTPUT.PUT_LINE('Before Trigger Operator Insert'); 
end;
    
create or replace trigger UPDATE_TRIGGR_BEFORE_STATEMENT
before update on SEMESTER_5
begin DBMS_OUTPUT.PUT_LINE('Before Trigger Operator Update'); 
end;
    
create or replace trigger DELETE_TRIGGR_BEFORE_STATEMENT
before delete on SEMESTER_5
begin DBMS_OUTPUT.PUT_LINE('Before Trigger Operator Delete'); 
end;

-- 4.	���� � ��� ����������� �������� ������ �������� ��������� �� ��������� ������� (DMS_OUTPUT) �� ����� ����������� ������. 
-- ��

-- 5.	�������� BEFORE-������� ������ ������ �� ������� INSERT, DELETE � UPDATE.
create or replace trigger INSERT_TRIGGER_BEFORE_ROW
before insert on SEMESTER_5
for each row
    begin DBMS_OUTPUT.PUT_LINE('Before Trigger Row Insert'); 
end;

create or replace trigger UPDATE_TRIGGER_BEFORE_ROW
before update on SEMESTER_5
for each row
    begin DBMS_OUTPUT.PUT_LINE('Before Trigger Row Update'); 
end;

create or replace trigger DELETE_TRIGGER_BEFORE_ROW
before delete on SEMESTER_5
for each row
    begin DBMS_OUTPUT.PUT_LINE('Before Trigger Row Delete');
end;

-- 6.	��������� ��������� INSERTING, UPDATING � DELETING.
create or replace trigger TRIGGER_DML
before insert or update or delete on SEMESTER_5
begin
if INSERTING then
    DBMS_OUTPUT.PUT_LINE('Before Trigger DML Insert');
ELSIF UPDATING then
    DBMS_OUTPUT.PUT_LINE('Before Trigger DML Update');
ELSIF DELETING then
    DBMS_OUTPUT.PUT_LINE('Before Trigger DML Delete');
end if;
end;  

-- 7.	������������ AFTER-�������� ������ ��������� �� ������� INSERT, DELETE � UPDATE.
create or replace trigger INSERT_TRIGGER_AFTER_STATEMENT
after insert on SEMESTER_5
begin DBMS_OUTPUT.PUT_LINE('After Trigger Operator Insert'); 
end;

create or replace trigger UPDATE_TRIGGER_AFTER_STATEMENT
after update on SEMESTER_5
begin DBMS_OUTPUT.PUT_LINE('After Trigger Operator Update'); 
end;
    
create or replace trigger DELETE_TRIGGER_AFTER_STATEMENT
after delete on SEMESTER_5
begin DBMS_OUTPUT.PUT_LINE('After Trigger Operator Delete'); 
end;

-- 8.	������������ AFTER-�������� ������ ������ �� ������� INSERT, DELETE � UPDATE.
create or replace trigger INSERT_TRIGGER_AFTER_ROW
after insert on SEMESTER_5
for each row
    begin DBMS_OUTPUT.PUT_LINE('After Trigger Row Insert'); 
end;
    
create or replace trigger UPDATE_TRIGGER_AFTER_ROW
after update on SEMESTER_5
for each row
    begin DBMS_OUTPUT.PUT_LINE('After Trigger Row Update'); 
end;

create or replace trigger DELETE_TRIGGER_AFTER_ROW
after delete on SEMESTER_5
for each row
    begin DBMS_OUTPUT.PUT_LINE('After Trigger Row Delete'); 
end;

-- 9.	�������� ������� � ������ AUDIT. ������� ������ ��������� ����: 
-- OperationDate, 
-- OperationType (�������� �������, ���������� � ��������),
-- TriggerName(��� ��������),
-- Data (������ � ���������� ����� �� � ����� ��������).
create table AUDITS
(
    OPERATIONDATE timestamp, 
    OPERATIONTYPE varchar2(50), 
    TRIGGERNAME varchar2(30),
    DATA varchar2(300)   
);

-- 10.	�������� �������� ����� �������, ����� ��� �������������� ��� �������� � �������� �������� � ������� AUDIT.
create or replace trigger TRIGGER_DML_AUDIT
    before insert or update or delete on SEMESTER_5
    for each row
    begin
        if INSERTING then
            DBMS_OUTPUT.PUT_LINE('Before Trigger DML Insert (Audit)');
            insert into AUDITS(OPERATIONDATE, OPERATIONTYPE, TRIGGERNAME, data) values
            (
                localtimestamp,
                'Insert', 
                'TRIGGER_DML_AUDIT',
                :new.SUBJECT || ' ' || :new.EXAMS
            );
        elsif UPDATING then
            DBMS_OUTPUT.PUT_LINE('Before Trigger DML Update (Audit)');
            insert into AUDITS(OPERATIONDATE, OPERATIONTYPE, TRIGGERNAME, DATA)
            values
            (
                localtimestamp, 
                'Update', 
                'TRIGGER_DML_AUDIT',
                :old.SUBJECT || ' ' ||  :old.EXAMS || ' -> ' || :new.SUBJECT || ' ' ||  :new.EXAMS
            );
            
        elsif DELETING then
            DBMS_OUTPUT.PUT_LINE('Before Trigger DML Delete (Audit)');
            insert into AUDITS(OPERATIONDATE, OPERATIONTYPE, TRIGGERNAME, data)
            values
            (
                localtimestamp, 
                'Delete', 
                'TRIGGER_DML_AUDIT',
                :old.SUBJECT || ' ' ||  :old.EXAMS
            );
        end if;
    end;
    
-- 11.	��������� ��������, ���������� ����������� ������� �� ���������� �����. 
-- ��������, ��������������� �� ������� ��� �������. ��������� ���������.
insert into SEMESTER_5 values ('���', '�������');
-- before trigger ���������������
-- after trigger ���    

-- 12.	������� (drop) �������� �������. ��������� ���������. 
drop table SEMESTER_5;
-- ��� �������� ���������

-- �������� �������, ����������� �������� �������� �������.
create or replace trigger TRIGGER_PREVENT_TABLE_DROP
    before drop on SYSTEM.schema
    begin
        if DICTIONARY_OBJ_NAME = 'SEMESTER_5'
        then
          RAISE_APPLICATION_ERROR (-20000, '������� SEMESTER_5 ������ �������');
        end if;
    end; 

-- 13.	������� (drop) ������� AUDIT. ����������� ��������� ��������� � ������� SQL-DEVELOPER. 
-- ��������� ���������. �������� ��������.
drop table AUDITS;
-- ������� �������, �� � �������

-- 14.	�������� ������������� ��� �������� ��������. 
create view VIEW_SEMESTER_5 as 
    select * 
    from SEMESTER_5;
    
-- ������������ INSTEADOF INSERT-�������. ������� ������ ��������� ������ � �������.
create or replace trigger TRIGGER_INSTEAD_OF_INSERT
    instead of insert on VIEW_SEMESTER_5
    begin
        if INSERTING then
            DBMS_OUTPUT.PUT_LINE('Instead of Insert trigger');
            insert into SEMESTER_5 values ('���', '�����');
        end if;
    end TRIGGER_INSTEAD_OF_INSERT;

insert into VIEW_SEMESTER_5 values('���-��', '�����');
select * from VIEW_SEMESTER_5;

-- 15.	�����������������, � ����� ������� ����������� ��������.
-- ��

commit;
