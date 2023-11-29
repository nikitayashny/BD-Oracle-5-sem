alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';

-- 1.	Создайте таблицу, имеющую несколько атрибутов, один из которых первичный ключ.
create table SEMESTER_5 
(
    SUBJECT varchar(200) primary key, 
    EXAMS varchar(100)
);

-- 2.	Заполните таблицу строками (10 шт.).
insert into SEMESTER_5 values ('ТПО', 'экзамен');
insert into SEMESTER_5 values ('СП',   'экзамен');
insert into SEMESTER_5 values ('ОС',  'экзамен');
insert into SEMESTER_5 values ('Экономика',  'экзамен');
insert into SEMESTER_5 values ('Социология',  'экзамен');
insert into SEMESTER_5 values ('БД', 'зачет');
insert into SEMESTER_5 values ('ПСКП',  'зачет');
insert into SEMESTER_5 values ('КМС', 'зачет');
insert into SEMESTER_5 values ('ТПИ', 'зачет');

insert into SEMESTER_5 values ('БЖЧ', 'экзамен');
update SEMESTER_5 set EXAMS = 'зачет' where SUBJECT = 'БЖЧ';
delete SEMESTER_5 where SUBJECT = 'БЖЧ';

select * from SEMESTER_5;
select * from AUDITS;

-- 3.	Создайте BEFORE – триггер уровня оператора на события INSERT, DELETE и UPDATE. 
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

-- 4.	Этот и все последующие триггеры должны выдавать сообщение на серверную консоль (DMS_OUTPUT) со своим собственным именем. 
-- ок

-- 5.	Создайте BEFORE-триггер уровня строки на события INSERT, DELETE и UPDATE.
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

-- 6.	Примените предикаты INSERTING, UPDATING и DELETING.
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

-- 7.	Разработайте AFTER-триггеры уровня оператора на события INSERT, DELETE и UPDATE.
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

-- 8.	Разработайте AFTER-триггеры уровня строки на события INSERT, DELETE и UPDATE.
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

-- 9.	Создайте таблицу с именем AUDIT. Таблица должна содержать поля: 
-- OperationDate, 
-- OperationType (операция вставки, обновления и удаления),
-- TriggerName(имя триггера),
-- Data (строка с значениями полей до и после операции).
create table AUDITS
(
    OPERATIONDATE timestamp, 
    OPERATIONTYPE varchar2(50), 
    TRIGGERNAME varchar2(30),
    DATA varchar2(300)   
);

-- 10.	Измените триггеры таким образом, чтобы они регистрировали все операции с исходной таблицей в таблице AUDIT.
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
    
-- 11.	Выполните операцию, нарушающую целостность таблицы по первичному ключу. 
-- Выясните, зарегистрировал ли триггер это событие. Объясните результат.
insert into SEMESTER_5 values ('ТПО', 'экзамен');
-- before trigger зарегистрировал
-- after trigger нет    

-- 12.	Удалите (drop) исходную таблицу. Объясните результат. 
drop table SEMESTER_5;
-- все триггеры удалились

-- Добавьте триггер, запрещающий удаление исходной таблицы.
create or replace trigger TRIGGER_PREVENT_TABLE_DROP
    before drop on SYSTEM.schema
    begin
        if DICTIONARY_OBJ_NAME = 'SEMESTER_5'
        then
          RAISE_APPLICATION_ERROR (-20000, 'таблицу SEMESTER_5 нельзя удалять');
        end if;
    end; 

-- 13.	Удалите (drop) таблицу AUDIT. Просмотрите состояние триггеров с помощью SQL-DEVELOPER. 
-- Объясните результат. Измените триггеры.
drop table AUDITS;
-- триггер остался, но с ошибкой

-- 14.	Создайте представление над исходной таблицей. 
create view VIEW_SEMESTER_5 as 
    select * 
    from SEMESTER_5;
    
-- Разработайте INSTEADOF INSERT-триггер. Триггер должен добавлять строку в таблицу.
create or replace trigger TRIGGER_INSTEAD_OF_INSERT
    instead of insert on VIEW_SEMESTER_5
    begin
        if INSERTING then
            DBMS_OUTPUT.PUT_LINE('Instead of Insert trigger');
            insert into SEMESTER_5 values ('БЖЧ', 'зачёт');
        end if;
    end TRIGGER_INSTEAD_OF_INSERT;

insert into VIEW_SEMESTER_5 values('Физ-ра', 'зачет');
select * from VIEW_SEMESTER_5;

-- 15.	Продемонстрируйте, в каком порядке выполняются триггеры.
-- ок

commit;
