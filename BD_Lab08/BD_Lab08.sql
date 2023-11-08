alter session set container = XEPDB1;

-- drop table faculty
CREATE TABLE FACULTY
  (
   FACULTY      CHAR(20)      NOT NULL,
   FACULTY_NAME VARCHAR2(200), 
   CONSTRAINT PK_FACULTY PRIMARY KEY(FACULTY) 
  );
     
insert into FACULTY   (FACULTY,   FACULTY_NAME )
             values  ('ИДиП',   'Издателькое дело и полиграфия');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ХТиТ',   'Химическая технология и техника');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ЛХФ',     'Лесохозяйственный факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИЭФ',     'Инженерно-экономический факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТТЛП',    'Технология и техника лесной промышленности');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТОВ',     'Технология органических веществ');
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
             values  ('ИСиТ',    'Иформационный систем и технологий ',                         'ИДиП'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('ПОиСОИ', 'Полиграфического оборудования и систем обработки информации ', 'ИДиП'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
              values  ('ЛВ',      'Лесоводства',                                                 'ЛХФ') ;         
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ОВ',      'Охотоведения',                                                 'ЛХФ') ;   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ЛУ',      'Лесоустройства',                                              'ЛХФ');           
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ЛЗиДВ',   'Лесозащиты и древесиноведения',                               'ЛХФ');                
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ЛПиСПС',  'Ландшафтного проектирования и садово-паркового строительства','ЛХФ');                  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ТЛ',     'Транспорта леса',                                              'ТТЛП');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ЛМиЛЗ',  'Лесных машин и технологии лесозаготовок',                      'ТТЛП');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('ОХ',     'Органической химии',                                           'ТОВ');            
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                              FACULTY)
             values  ('ТНХСиППМ','Технологии нефтехимического синтеза и переработки полимерных материалов','ТОВ');             
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии ','ХТиТ');                    
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                                         FACULTY)
             values  ('ХТЭПиМЭЕ','Химии, технологии электрохимических производств и материалов электронной техники', 'ХТиТ');
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('ЭТиМ',    'экономической теории и маркетинга',                              'ИЭФ');   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('МиЭП',   'Менеджмента и экономики природопользования',                      'ИЭФ');    
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
                       values  ('СМЛВ',    'Смелов Владимир Владиславович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('АКНВЧ',    'Акунович Станислав Иванович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('КЛСНВ',    'Колесников Леонид Валерьевич',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ГРМН',    'Герман Олег Витольдович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ЛЩНК',    'Лащенко Анатолий Пвалович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('БРКВЧ',    'Бракович Андрей Игорьевич',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ДДК',     'Дедко Александр Аркадьевич',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('КБЛ',     'Кабайло Александр Серафимович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('УРБ',     'Урбанович Павел Павлович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('РМНК',     'Романенко Дмитрий Михайлович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ПСТВЛВ',  'Пустовалова Наталия Николаевна', 'ИСиТ' );
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('?',     'Неизвестный',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                      values  ('ГРН',     'Гурин Николай Иванович',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ЖЛК',     'Жиляк Надежда Александровна',  'ИСиТ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('БРТШВЧ',   'Барташевич Святослав Александрович',  'ПОиСОИ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ЮДНКВ',   'Юденков Виктор Степанович',  'ПОиСОИ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('БРНВСК',   'Барановский Станислав Иванович',  'ЭТиМ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('НВРВ',   'Неверов Александр Васильевич',  'МиЭП');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('РВКЧ',   'Ровкач Андрей Иванович',  'ОВ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ДМДК', 'Демидко Марина Николаевна',  'ЛПиСПС');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('МШКВСК',   'Машковский Владимир Петрович',  'ЛУ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ЛБХ',   'Лабоха Константин Валентинович',  'ЛВ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ЗВГЦВ',   'Звягинцев Вячеслав Борисович',  'ЛЗиДВ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('БЗБРДВ',   'Безбородов Владимир Степанович',  'ОХ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ПРКПЧК',   'Прокопчук Николай Романович',  'ТНХСиППМ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('НСКВЦ',   'Насковец Михаил Трофимович',  'ТЛ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('МХВ',   'Мохов Сергей Петрович',  'ЛМиЛЗ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ЕЩНК',   'Ещенко Людмила Семеновна',  'ТНВиОХТ'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
                       values  ('ЖРСК',   'Жарский Иван Михайлович',  'ХТЭПиМЭЕ'); 
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
                       values ('СУБД',   'Системы управления базами данных',                   'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT)
                       values ('БД',     'Базы данных',                                        'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ИНФ',    'Информацтонные технологии',                          'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОАиП',  'Основы алгоритмизации и программирования',            'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПЗ',     'Представление знаний в компьютерных системах',       'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПСП',    'Пограммирование сетевых приложений',                 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('МСОИ',     'Моделирование систем обработки информации',        'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПИС',     'Проектирование информационных систем',              'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('КГ',      'Компьютерная геометрия ',                           'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПМАПЛ',   'Полиграфические машины, автоматы и поточные линии', 'ПОиСОИ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('КМС',     'Компьютерные мультимедийные системы',               'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОПП',     'Организация полиграфического производства',         'ПОиСОИ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                            PULPIT)
               values ('ДМ',   'Дискретная матеатика',                     'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('МП',   'Математисеское программирование',          'ИСиТ');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('ЛЭВМ', 'Логические основы ЭВМ',                     'ИСиТ');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,                             PULPIT )
               values ('ООП',  'Объектно-ориентированное программирование', 'ИСиТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ЭП',     'Экономика природопользования',                       'МиЭП');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ЭТ',     'Экономическая теория',                               'ЭТиМ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('БЛЗиПсOO','Биология лесных зверей и птиц с осн. охотов.',      'ОВ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОСПиЛПХ','Основы садовопаркового и лесопаркового хозяйства',  'ЛПиСПС');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ИГ',     'Инженерная геодезия ',                              'ЛУ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ЛВ',    'Лесоводство',                                        'ЛЗиДВ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ОХ',    'Органическая химия',                                 'ОХ');   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ТРИ',    'Технология резиновых изделий',                      'ТНХСиППМ'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ВТЛ',    'Водный транспорт леса',                             'ТЛ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ТиОЛ',   'Технология и оборудование лесозаготовок',           'ЛМиЛЗ'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ТОПИ',   'Технология обогащения полезных ископаемых ',        'ТНВиОХТ');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ПЭХ',    'Прикладная электрохимия',                           'ХТЭПиМЭЕ');   
commit;

select * from subject;

--------------------------------------------------------------------------------------------------------------------------------

create table AUDITORIUM_TYPE 
(
  AUDITORIUM_TYPE   char(20) constraint AUDITORIUM_TYPE_PK  primary key,  
  AUDITORIUM_TYPENAME  varchar2(60) constraint AUDITORIUM_TYPENAME_NOT_NULL not null         
);

insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛК',   'Лекционная');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛБ-К',   'Компьютерный класс');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛК-К', 'Лекционная с уст. компьютерами');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛБ-X', 'Химическая лаборатория');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('ЛБ-СК', 'Спец. компьютерный класс');
commit;

select * from auditorium_type;

--------------------------------------------------------------------------------------------------------------------------------

create table AUDITORIUM 
(
 AUDITORIUM           char(20) primary key,  -- код аудитории
 AUDITORIUM_NAME      varchar2(200),          -- аудитория 
 AUDITORIUM_CAPACITY  number(4),              -- вместимость
 AUDITORIUM_TYPE      char(20) not null      -- тип аудитории
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE)  
);

insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('206-1',   '206-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
                       values  ('301-1',   '301-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('236-1',   '236-1', 'ЛК',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('313-1',   '313-1', 'ЛК',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('324-1',   '324-1', 'ЛК',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('413-1',   '413-1', 'ЛБ-К', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('423-1',   '423-1', 'ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('408-2',   '408-2', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('103-4',   '103-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('105-4',   '105-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('107-4',   '107-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('110-4',   '110-4', 'ЛК',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('111-4',   '111-4', 'ЛК',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                      values  ('114-4',   '114-4', 'ЛК-К',  90 );
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('132-4',   '132-4', 'ЛК',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('02Б-4',   '02Б-4', 'ЛК',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('229-4',   '229-4', 'ЛК',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('304-4',   '304-4','ЛБ-К', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('314-4',   '314-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('320-4',   '320-4', 'ЛК',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('429-4',   '429-4', 'ЛК',  90);
commit;

select * from auditorium;

--------------------------------------------------------------------------------------------------------------------------------

-- 1.	Разработайте простейший анонимный блок PL/SQL (АБ), не содержащий операторов
begin
  null;
end;

-- 2.	Разработайте АБ, выводящий «Hello World!». Выполните его в SQLDev и SQL+.
begin
  dbms_output.put_line('Hello World!');
end;
-- set serveroutput on;
-- /

-- 3.	Продемонстрируйте работу исключения и встроенных функций sqlerrm, sqlcode
declare
  a number := 100;
begin
  a := a / 0;
exception
  when others then
    dbms_output.put_line('Ошибка: ' || sqlerrm);
    dbms_output.put_line('Код ошибки: ' || sqlcode);
end;

-- 4.	Разработайте вложенный блок. Продемонстрируйте принцип обработки исключений во вложенных блоках.
declare
  v_num1 number := 10;
  v_num2 number := 0;
begin
    begin
      dbms_output.put_line('Результат: ' || v_num1 / v_num2);
    exception
      when zero_divide then
        dbms_output.put_line('Ошибка во вложенном блоке: деление на ноль');
    end;
    dbms_output.put_line('Операция успешно выполнена');
  exception
    when others then
      dbms_output.put_line('Ошибка во внешнем блоке: ' || sqlerrm);
end;

-- 5.	Выясните, какие типы предупреждения компилятора поддерживаются в данный момент.
-- all
-- perfomance
-- informational
-- severe
-- specific error
alter system set plsql_warnings = 'enable:informational';
show parameter plsql_warnings;

-- 6.	Разработайте скрипт, позволяющий просмотреть все спецсимволы PL/SQL.
select keyword from v$reserved_words
where length = 1

-- 7.	Разработайте скрипт, позволяющий просмотреть все ключевые слова  PL/SQL.
select keyword from v$reserved_words 
order by keyword

-- 8.	Разработайте скрипт, позволяющий просмотреть все параметры Oracle Server, связанные с PL/SQL. 
-- Просмотрите эти же параметры с помощью SQL+-команды show.
select name, value
from v$parameter
where name like '%plsql%'

show parameter plsql

-- 9.	Разработайте анонимный блок, демонстрирующий (выводящий в выходной серверный поток результаты):
-- 10.	объявление и инициализацию целых number-переменных;
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

-- 11.	арифметические действия над двумя целыми number-переменных, включая деление с остатком;
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

-- 12.	объявление и инициализацию number-переменных с фиксированной точкой;
declare
  v_number1 number(8,2) := 1234.56; 
  v_number2 number(6,3) := 45.678; 
begin
  dbms_output.put_line('Number 1: ' || v_number1);
  dbms_output.put_line('Number 2: ' || v_number2);
end;

-- 13.	объявление и инициализацию number-переменных с фиксированной точкой и отрицательным масштабом (округление); 
declare
  num1 number := 3.33333;
  num2 number := 2.55555;
  rounded_num1 number;
  rounded_num2 number;
begin
  rounded_num1 := round(num1, 2);
  rounded_num2 := round(num2); 

  dbms_output.put_line('Результат округления num1: ' || rounded_num1);
  dbms_output.put_line('Результат округления num2: ' || rounded_num2); 
end;

-- 14.	объявление и инициализацию BINARY_FLOAT-переменной;
declare
  v_binary_float binary_float := 3.14; 
begin
  dbms_output.put_line('Value of v_binary_float: ' || v_binary_float); 
end;

-- 15.	объявление и инициализацию BINARY_DOUBLE-переменной;
declare
  v_binary_double binary_double := 3.14;
begin
  dbms_output.put_line('Value of v_binary_double: ' || v_binary_double);
end;

-- 16.	объявление number-переменных с точкой и применением символа E (степень 10) при инициализации/присвоении;
declare
  v_number1 number := 1.23E+2; 
  v_number2 number;
begin
  v_number2 := 4.56E-3;
  
  dbms_output.put_line('Number 1: ' || v_number1);
  dbms_output.put_line('Number 2: ' || v_number2);
end;

-- 17.	объявление и инициализацию BOOLEAN-переменных. 
declare
  v_boolean1 boolean := true; 
  v_boolean2 BOOLEAN := false; 
begin
  dbms_output.put_line('Value of v_boolean1: ' || case when v_boolean1 then 'true' else 'false' end);
  dbms_output.put_line('Value of v_boolean2: ' || case when v_boolean2 then 'true' else 'false' end);
end;

-- 18.	Разработайте анонимный блок PL/SQL содержащий объявление констант (VARCHAR2, CHAR, NUMBER).
-- Продемонстрируйте  возможные операции константами.  
declare
  v_const_varchar2 constant varchar2(20) := 'Hello, World!';
  v_const_char constant char(6) := 'PL/SQL';
  v_const_number constant number := 123.45;
  
  v_result number;
begin
  v_result := v_const_number + 10; -- Сложение константы с числом
  
  dbms_output.put_line('Constant varchar2: ' || v_const_varchar2);
  dbms_output.put_line('Constant char: ' || v_const_char);
  dbms_output.put_line('Constant number: ' || v_const_number);
  dbms_output.put_line('Result: ' || v_result);
end;

-- 19.	Разработайте АБ, содержащий объявления с опцией %TYPE. Продемонстрируйте действие опции.
declare
  v_faculty faculty.faculty%TYPE;
  v_faculty_name faculty.faculty_name%TYPE;
begin  
  select faculty, faculty_name 
  into v_faculty, v_faculty_name 
  from faculty 
  where faculty = 'ТОВ';
  
  dbms_output.put_line('Faculty: ' || v_faculty);
  dbms_output.put_line('Faculty_name: ' || v_faculty_name);
end;

-- 20.	Разработайте АБ, содержащий объявления с опцией %ROWTYPE. Продемонстрируйте действие опции.
declare
  faculty_rec   faculty%rowtype;
begin
  faculty_rec.faculty := 'ИДиП';
  faculty_rec.faculty_name := 'Факультет издательского дела и полиграфии';
  dbms_output.put_line(rtrim(faculty_rec.faculty)||': '||faculty_rec.faculty_name);
end;
  
-- 21-22.	Разработайте АБ, демонстрирующий все возможные конструкции оператора IF .
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

-- 23.	Разработайте АБ, демонстрирующий работу оператора CASE.
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

-- 24-25-26.	Разработайте АБ, демонстрирующий работу оператора LOOP.
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


  
  









