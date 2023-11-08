alter session set container = XEPDB1;

-- drop table faculty
CREATE TABLE FACULTY
  (
   FACULTY      CHAR(20)      NOT NULL,
   FACULTY_NAME VARCHAR2(200), 
   CONSTRAINT PK_FACULTY PRIMARY KEY(FACULTY) 
  );
     
insert into FACULTY   (FACULTY,   FACULTY_NAME )
             values  ('����',   '����������� ���� � ����������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',   '���������� ���������� � �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '����������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������-������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',    '���������� � ������� ������ ��������������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������� ������������ �������');
commit;
            
select * from faculty;

--------------------------------------------------------------------------------------------------------------------------------

-- DROP TABLE PULPIT
CREATE TABLE PULPIT 
(
 PULPIT       CHAR(20)      NOT NULL,
 PULPIT_NAME  VARCHAR2(200), 
 FACULTY      CHAR(20)      NOT NULL, 
 CONSTRAINT FK_PULPIT_FACULTY FOREIGN KEY(FACULTY)   REFERENCES FACULTY(FACULTY), 
 CONSTRAINT PK_PULPIT PRIMARY KEY(PULPIT) 
 ); 
  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('����',    '������������� ������ � ���������� ',                         '����'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('������', '���������������� ������������ � ������ ��������� ���������� ', '����'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
              values  ('��',      '�����������',                                                 '���') ;         
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('��',      '������������',                                                 '���') ;   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('��',      '��������������',                                              '���');           
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('�����',   '���������� � ����������������',                               '���');                
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('������',  '������������ �������������� � ������-��������� �������������','���');                  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('��',     '���������� ����',                                              '����');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('�����',  '������ ����� � ���������� �������������',                      '����');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('��',     '������������ �����',                                           '���');            
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                              FACULTY)
             values  ('��������','���������� ���������������� ������� � ����������� ���������� ����������','���');             
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('�������','���������� �������������� ������� � ����� ���������� ���������� ','����');                    
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                                         FACULTY)
             values  ('��������','�����, ���������� ����������������� ����������� � ���������� ����������� �������', '����');
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('����',    '������������� ������ � ����������',                              '���');   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('����',   '����������� � ��������� ������������������',                      '���');    
commit;

select * from pulpit;

--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TEACHER
 ( 
  TEACHER       CHAR(20) NOT  NULL,
  TEACHER_NAME  VARCHAR2(200), 
  PULPIT        CHAR(20) NOT NULL, 
  CONSTRAINT PK_TEACHER  PRIMARY KEY(TEACHER), 
  CONSTRAINT FK_TEACHER_PULPIT FOREIGN   KEY(PULPIT)   REFERENCES PULPIT(PULPIT)
 ) ;
 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT )
                       values  ('����',    '������ �������� �������������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',    '�������� ��������� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',    '���������� ������ ����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',    '������ ���� �����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',    '������� �������� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',    '�������� ������ ���������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',     '����� ��������� ����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',     '������� ��������� �����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',     '��������� ����� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',     '��������� ������� ����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',  '����������� ������� ����������', '����' );
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('?',     '�����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                      values  ('���',     '����� ������� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',     '����� ������� �������������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '���������� ��������� �������������',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',   '������� ������ ����������',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '����������� ��������� ��������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������� ��������� ����������',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������ ������ ��������',  '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����', '������� ������ ����������',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '���������� �������� ��������',  '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',   '������ ���������� ������������',  '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',   '��������� �������� ���������',  '�����'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '���������� �������� ����������',  '��'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('������',   '��������� ������� ���������',  '��������'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('�����',   '�������� ������ ����������',  '��'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('���',   '����� ������ ��������',  '�����'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������ ������� ���������',  '�������'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('����',   '������� ���� ����������',  '��������'); 
commit;

select * from teacher;

--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE SUBJECT
    (
     SUBJECT      CHAR(20)     NOT NULL, 
     SUBJECT_NAME VARCHAR2(200)  NOT NULL,
     PULPIT       CHAR(20)     NOT NULL,  
     CONSTRAINT PK_SUBJECT PRIMARY KEY(SUBJECT),
     CONSTRAINT FK_SUBJECT_PULPIT FOREIGN  KEY(PULPIT)  REFERENCES PULPIT(PULPIT)
    );
    
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',   '������� ���������� ������ ������',                   '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT)
                       values ('��',     '���� ������',                                        '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '�������������� ����������',                          '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',  '������ �������������� � ����������������',            '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������',       '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '��������������� ������� ����������',                 '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',     '������������� ������ ��������� ����������',        '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',     '�������������� �������������� ������',              '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',      '������������ ��������� ',                           '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('�����',   '��������������� ������, �������� � �������� �����', '������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',     '������������ �������������� �������',               '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',     '����������� ���������������� ������������',         '������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                            PULPIT)
               values ('��',   '���������� ���������',                     '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('��',   '�������������� ����������������',          '����');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('����', '���������� ������ ���',                     '����');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('���',  '��������-��������������� ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '��������� ������������������',                       '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '������������� ������',                               '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('������OO','�������� ������ ������ � ���� � ���. ������.',      '��');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('�������','������ ��������������� � ������������� ���������',  '������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',     '���������� �������� ',                              '��');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',    '�����������',                                        '�����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('��',    '������������ �����',                                 '��');   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '���������� ��������� �������',                      '��������'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '������ ��������� ����',                             '��');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',   '���������� � ������������ �������������',           '�����'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('����',   '���������� ���������� �������� ���������� ',        '�������');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('���',    '���������� ������������',                           '��������');   
commit;

select * from subject;

--------------------------------------------------------------------------------------------------------------------------------

create table AUDITORIUM_TYPE 
(
  AUDITORIUM_TYPE   char(20) constraint AUDITORIUM_TYPE_PK  primary key,  
  AUDITORIUM_TYPENAME  varchar2(60) constraint AUDITORIUM_TYPENAME_NOT_NULL not null         
);

insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��',   '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��-�',   '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��-�', '���������� � ���. ������������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��-X', '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('��-��', '����. ������������ �����');
commit;

select * from auditorium_type;

--------------------------------------------------------------------------------------------------------------------------------

create table AUDITORIUM 
(
 AUDITORIUM           char(20) primary key,  -- ��� ���������
 AUDITORIUM_NAME      varchar2(200),          -- ��������� 
 AUDITORIUM_CAPACITY  number(4),              -- �����������
 AUDITORIUM_TYPE      char(20) not null      -- ��� ���������
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE)  
);

insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('206-1',   '206-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
                       values  ('301-1',   '301-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('236-1',   '236-1', '��',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('313-1',   '313-1', '��',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('324-1',   '324-1', '��',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('413-1',   '413-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('423-1',   '423-1', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('408-2',   '408-2', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('103-4',   '103-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('105-4',   '105-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('107-4',   '107-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('110-4',   '110-4', '��',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('111-4',   '111-4', '��',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                      values  ('114-4',   '114-4', '��-�',  90 );
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('132-4',   '132-4', '��',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('02�-4',   '02�-4', '��',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('229-4',   '229-4', '��',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('304-4',   '304-4','��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('314-4',   '314-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('320-4',   '320-4', '��',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('429-4',   '429-4', '��',  90);
commit;

select * from auditorium;

--------------------------------------------------------------------------------------------------------------------------------

-- 1.	������������ ���������� ��������� ���� PL/SQL (��), �� ���������� ����������
begin
  null;
end;

-- 2.	������������ ��, ��������� �Hello World!�. ��������� ��� � SQLDev � SQL+.
begin
  dbms_output.put_line('Hello World!');
end;
-- set serveroutput on;
-- /

-- 3.	����������������� ������ ���������� � ���������� ������� sqlerrm, sqlcode
declare
  a number := 100;
begin
  a := a / 0;
exception
  when others then
    dbms_output.put_line('������: ' || sqlerrm);
    dbms_output.put_line('��� ������: ' || sqlcode);
end;

-- 4.	������������ ��������� ����. ����������������� ������� ��������� ���������� �� ��������� ������.
declare
  v_num1 number := 10;
  v_num2 number := 0;
begin
    begin
      dbms_output.put_line('���������: ' || v_num1 / v_num2);
    exception
      when zero_divide then
        dbms_output.put_line('������ �� ��������� �����: ������� �� ����');
    end;
    dbms_output.put_line('�������� ������� ���������');
  exception
    when others then
      dbms_output.put_line('������ �� ������� �����: ' || sqlerrm);
end;

-- 5.	��������, ����� ���� �������������� ����������� �������������� � ������ ������.
-- all
-- perfomance
-- informational
-- severe
-- specific error
alter system set plsql_warnings = 'enable:informational';
show parameter plsql_warnings;

-- 6.	������������ ������, ����������� ����������� ��� ����������� PL/SQL.
select keyword from v$reserved_words
where length = 1

-- 7.	������������ ������, ����������� ����������� ��� �������� �����  PL/SQL.
select keyword from v$reserved_words 
order by keyword

-- 8.	������������ ������, ����������� ����������� ��� ��������� Oracle Server, ��������� � PL/SQL. 
-- ����������� ��� �� ��������� � ������� SQL+-������� show.
select name, value
from v$parameter
where name like '%plsql%'

show parameter plsql

-- 9.	������������ ��������� ����, ��������������� (��������� � �������� ��������� ����� ����������):
-- 10.	���������� � ������������� ����� number-����������;
declare
  v_number1 number := 10;
  v_number2 number := 20;
  v_result number;
begin
  v_result := v_number1 + v_number2;

  dbms_output.put_line('Number 1: ' || v_number1);
  dbms_output.put_line('Number 2: ' || v_number2);
  dbms_output.put_line('Result: ' || v_result);
end;

-- 11.	�������������� �������� ��� ����� ������ number-����������, ������� ������� � ��������;
declare
  v_number1 number := 10;
  v_number2 number := 3;
  v_sum number;
  v_difference number;
  v_product number;
  v_quotient number;
  v_remainder number;
begin
  v_sum := v_number1 + v_number2;
  v_difference := v_number1 - v_number2;
  v_product := v_number1 * v_number2;
  v_quotient := v_number1 / v_number2;
  v_remainder := mod(v_number1, v_number2);

  dbms_output.put_line('Number 1: ' || v_number1);
  dbms_output.put_line('Number 2: ' || v_number2);
  dbms_output.put_line('Sum: ' || v_sum);
  dbms_output.put_line('Difference: ' || v_difference);
  dbms_output.put_line('Product: ' || v_product);
  dbms_output.put_line('Quotient: ' || v_quotient);
  dbms_output.put_line('Remainder: ' || v_remainder);
end;

-- 12.	���������� � ������������� number-���������� � ������������� ������;
declare
  v_number1 number(8,2) := 1234.56; 
  v_number2 number(6,3) := 45.678; 
begin
  dbms_output.put_line('Number 1: ' || v_number1);
  dbms_output.put_line('Number 2: ' || v_number2);
end;

-- 13.	���������� � ������������� number-���������� � ������������� ������ � ������������� ��������� (����������); 
declare
  num1 number := 3.33333;
  num2 number := 2.55555;
  rounded_num1 number;
  rounded_num2 number;
begin
  rounded_num1 := round(num1, 2);
  rounded_num2 := round(num2); 

  dbms_output.put_line('��������� ���������� num1: ' || rounded_num1);
  dbms_output.put_line('��������� ���������� num2: ' || rounded_num2); 
end;

-- 14.	���������� � ������������� BINARY_FLOAT-����������;
declare
  v_binary_float binary_float := 3.14; 
begin
  dbms_output.put_line('Value of v_binary_float: ' || v_binary_float); 
end;

-- 15.	���������� � ������������� BINARY_DOUBLE-����������;
declare
  v_binary_double binary_double := 3.14;
begin
  dbms_output.put_line('Value of v_binary_double: ' || v_binary_double);
end;

-- 16.	���������� number-���������� � ������ � ����������� ������� E (������� 10) ��� �������������/����������;
declare
  v_number1 number := 1.23E+2; 
  v_number2 number;
begin
  v_number2 := 4.56E-3;
  
  dbms_output.put_line('Number 1: ' || v_number1);
  dbms_output.put_line('Number 2: ' || v_number2);
end;

-- 17.	���������� � ������������� BOOLEAN-����������. 
declare
  v_boolean1 boolean := true; 
  v_boolean2 BOOLEAN := false; 
begin
  dbms_output.put_line('Value of v_boolean1: ' || case when v_boolean1 then 'true' else 'false' end);
  dbms_output.put_line('Value of v_boolean2: ' || case when v_boolean2 then 'true' else 'false' end);
end;

-- 18.	������������ ��������� ���� PL/SQL ���������� ���������� �������� (VARCHAR2, CHAR, NUMBER).
-- �����������������  ��������� �������� �����������.  
declare
  v_const_varchar2 constant varchar2(20) := 'Hello, World!';
  v_const_char constant char(6) := 'PL/SQL';
  v_const_number constant number := 123.45;
  
  v_result number;
begin
  v_result := v_const_number + 10; -- �������� ��������� � ������
  
  dbms_output.put_line('Constant varchar2: ' || v_const_varchar2);
  dbms_output.put_line('Constant char: ' || v_const_char);
  dbms_output.put_line('Constant number: ' || v_const_number);
  dbms_output.put_line('Result: ' || v_result);
end;

-- 19.	������������ ��, ���������� ���������� � ������ %TYPE. ����������������� �������� �����.
declare
  v_faculty faculty.faculty%TYPE;
  v_faculty_name faculty.faculty_name%TYPE;
begin  
  select faculty, faculty_name 
  into v_faculty, v_faculty_name 
  from faculty 
  where faculty = '���';
  
  dbms_output.put_line('Faculty: ' || v_faculty);
  dbms_output.put_line('Faculty_name: ' || v_faculty_name);
end;

-- 20.	������������ ��, ���������� ���������� � ������ %ROWTYPE. ����������������� �������� �����.
declare
  faculty_rec   faculty%rowtype;
begin
  faculty_rec.faculty := '����';
  faculty_rec.faculty_name := '��������� ������������� ���� � ����������';
  dbms_output.put_line(rtrim(faculty_rec.faculty)||': '||faculty_rec.faculty_name);
end;
  
-- 21-22.	������������ ��, ��������������� ��� ��������� ����������� ��������� IF .
declare
  v_number1 number := 10;
  v_number2 number := 20;
  v_boolean boolean := true;
begin
  if v_number2 > v_number1 then
    dbms_output.put_line('v_number2 is greater than v_number1');
  end if;

  if v_number1 > v_number2 then
    dbms_output.put_line('v_number1 is greater than v_number2');
  else
    dbms_output.put_line('v_number1 is not greater than v_number2');
  end if;

  if v_number1 > v_number2 then
    dbms_output.put_line('v_number1 is greater than v_number2');
  elsif v_number1 < v_number2 then
    dbms_output.put_line('v_number1 is less than v_number2');
  else
    dbms_output.put_line('v_number1 is equal to v_number2');
  end if;
  
  if v_boolean then
    dbms_output.put_line('v_boolean is true');
  else
    dbms_output.put_line('v_boolean is false');
  end if;
end;

-- 23.	������������ ��, ��������������� ������ ��������� CASE.
declare
  v_day_of_week number := 3;
begin
  case v_day_of_week
    when 1 then
      dbms_output.put_line('Monday');
    when 2 then
      dbms_output.put_line('Tuesday');
    when 3 then
      dbms_output.put_line('Wednesday');
    when 4 then
      dbms_output.put_line('Thursday');
    when 5 then
      dbms_output.put_line('Friday');
    when 6 then
      dbms_output.put_line('Saturday');
    when 7 then
      dbms_output.put_line('Sunday');
    else
      dbms_output.put_line('Invalid day of the week');
  end case;
end;

-- 24-25-26.	������������ ��, ��������������� ������ ��������� LOOP.
declare
  v_counter number := 1;
begin

  loop
    dbms_output.put_line('Counter: ' || v_counter);
    v_counter := v_counter + 1;
    
    exit when v_counter > 5;
  end loop;
  
  v_counter := 1;
  
  for v_counter in 1..5
  loop
    dbms_output.put_line('Counter: ' || v_counter);
  end loop;
  
  v_counter := 1;
  
  while (v_counter < 5)
  loop
    v_counter := v_counter + 1;
    dbms_output.put_line('Counter: ' || v_counter);
  end loop;
  
end;


  
  









