--1. Разработайте локальную процедуру GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE) 
-- Процедура должна выводить список преподавателей из таблицы TEACHER (в стандартный серверный вывод),
-- работающих на кафедре заданной кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
create or replace procedure GET_TEACHERS (pcode teacher.pulpit%type) is
  cursor my_curs is
    select teacher_name, teacher 
    from teacher 
    where pulpit = pcode;
  t_name teacher.teacher_name%type;
  t_code teacher.teacher%type;
begin
  open my_curs;
  loop
    dbms_output.put_line(t_code||' '||t_name);
    fetch my_curs into t_name, t_code;
    exit when my_curs%notfound;
  end loop;
  close my_curs;
end;

begin
    GET_TEACHERS('ИСиТ');
end;

-- 2-3. Разработайте локальную функцию GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE) RETURN NUMBER
-- Функция должна выводить количество преподавателей из таблицы TEACHER, работающих на кафедре заданной кодом в параметре. 
-- Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
create or replace function GET_NUM_TEACHERS(PCODE TEACHER.PULPIT%type)
  return number is
    tcount number;
begin
  select count(*) 
  into tcount 
  from teacher 
  where pulpit = pcode;
  
  return tcount;
end;

begin
  dbms_output.put_line(GET_NUM_TEACHERS('ИСиТ'));
end;

-- 4. Разработайте процедуры:
-- GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
-- Процедура должна выводить список преподавателей из таблицы TEACHER (в стандартный серверный вывод), работающих на факультете,
-- заданным кодом в параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
create or replace procedure GET_TEACHERS(fcode faculty.faculty%type) is
  cursor my_curs is
    select t.teacher_name
    from teacher t
    join pulpit p
      on t.pulpit = p.pulpit
    where p.faculty = fcode;
  t_name teacher.teacher_name%type;
begin
  open my_curs;
  loop
    dbms_output.put_line(t_name);
    fetch my_curs into t_name;
    exit when my_curs%notfound;
  end loop;
  close my_curs;
end;

begin
    GET_TEACHERS('ХТиТ');
end;
-- GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
-- Процедура должна выводить список дисциплин из таблицы SUBJECT, закрепленных за кафедрой, заданной кодом кафедры в параметре.
-- Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
create or replace procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%type) is
  cursor my_curs is
    select subject_name
    from subject S
    where s.pulpit = pcode;
  s_subject_name subject.subject_name%type;
begin
  open my_curs;
  loop
    dbms_output.put_line(s_subject_name);
    fetch my_curs into s_subject_name;
    exit when my_curs%notfound;
  end loop;
  close my_curs;
end;

begin
  GET_SUBJECTS('ИСиТ');
end;

-- 5. Разработайте локальную функцию GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER 
-- Функция должна выводить количество преподавателей из таблицы TEACHER, работающих на факультете, заданным кодом в параметре. 
-- Разработайте анонимный блок и продемонстрируйте выполнение процедуры.
create or replace function GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%type)
  return number is
    tcount number;
begin
  select count(*) 
  into tcount 
  from teacher T
  join pulpit P
    on t.pulpit = p.pulpit
  where p.faculty = fcode;
  
  return tcount;
end;

begin
  dbms_output.put_line('Кол-во преподавателей на факультете: ' || GET_NUM_TEACHERS('ИДиП'));
end;
-- GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER Функция должна выводить количество дисциплин из таблицы SUBJECT, 
-- закрепленных за кафедрой, заданной кодом кафедры параметре. Разработайте анонимный блок и продемонстрируйте выполнение процедуры. 
create or replace function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%type)
  return number is
    tcount number := 0;
begin
    select count(*) 
    into tcount
    from subject
    where subject.pulpit = pcode;
    
    return tcount;
end;

begin
  dbms_output.put_line('Кол-во предметов на кафедре: ' || GET_NUM_SUBJECTS('ИСиТ'));
end;

-- 6. Разработайте пакет TEACHERS, содержащий процедуры и функции:
-- GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
-- GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
-- GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER 
-- GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER 
create or replace package TEACHERS as
  FCODE FACULTY.FACULTY%type;
  PCODE SUBJECT.PULPIT%type;
  procedure GET_TEACHERS(FCODE FACULTY.FACULTY%type);
  procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%type);
  function GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%type) return number;
  function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%type) return number;
end TEACHERS;

create or replace package body TEACHERS as
procedure GET_TEACHERS(fcode faculty.faculty%type) is
  cursor my_curs is
    select t.teacher_name
    from teacher t
    join pulpit p
      on t.pulpit = p.pulpit
    where p.faculty = fcode;
  t_name teacher.teacher_name%type;
begin
  open my_curs;
  loop
    dbms_output.put_line(t_name);
    fetch my_curs into t_name;
    exit when my_curs%notfound;
  end loop;
  close my_curs;
end GET_TEACHERS;

procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%type) is
  cursor my_curs is
    select subject_name
    from subject S
    where s.pulpit = pcode;
  s_subject_name subject.subject_name%type;
begin
  open my_curs;
  loop
    dbms_output.put_line(s_subject_name);
    fetch my_curs into s_subject_name;
    exit when my_curs%notfound;
  end loop;
  close my_curs;
end GET_SUBJECTS;

function GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%type)
  return number is
    tcount number;
begin
  select count(*) 
  into tcount 
  from teacher T
  join pulpit P
    on t.pulpit = p.pulpit
  where p.faculty = fcode;
  
  return tcount;
end GET_NUM_TEACHERS;

function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%type)
  return number is
    tcount number := 0;
begin
    select count(*) 
    into tcount
    from subject
    where subject.pulpit = pcode;
    
    return tcount;
end GET_NUM_SUBJECTS;
end TEACHERS;

-- 7. Разработайте анонимный блок и продемонстрируйте выполнение процедур и функций пакета TEACHERS.
begin
  dbms_output.put_line('Кол-во преподавателей на факультете: ' || TEACHERS.GET_NUM_TEACHERS('ИДиП'));
  dbms_output.put_line('Кол-во предметов на кафедре: ' || TEACHERS.GET_NUM_SUBJECTS('ИСиТ'));
  TEACHERS.GET_TEACHERS('ИДиП');
  TEACHERS.GET_SUBJECTS('ИСиТ');
end;


