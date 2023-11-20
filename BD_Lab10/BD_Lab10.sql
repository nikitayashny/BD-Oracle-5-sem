alter session set nls_date_format = 'DD-MM-YYYY';

-- 1. �������� � ������� TEACHERS ��� ������� BIRTHDAY� SALARY, ��������� �� ����������.
alter table TEACHER add BIRTHDAY date;
update TEACHER set BIRTHDAY = '12-02-1959' where TEACHER = '����';
update TEACHER set BIRTHDAY = '30-01-1987' where TEACHER = '�����';
update TEACHER set BIRTHDAY = '19-04-1991' where TEACHER = '�����';
update TEACHER set BIRTHDAY = '16-04-1964' where TEACHER = '����';
update TEACHER set BIRTHDAY = '19-11-1988' where TEACHER = '����';
update TEACHER set BIRTHDAY = '05-10-1966' where TEACHER = '�����';
update TEACHER set BIRTHDAY = '10-08-1976' where TEACHER = '���';
update TEACHER set BIRTHDAY = '11-09-1989' where TEACHER = '���';
update TEACHER set BIRTHDAY = '24-12-1983' where TEACHER = '���';
update TEACHER set BIRTHDAY = '03-06-1990' where TEACHER = '����';
update TEACHER set BIRTHDAY = '10-05-1970' where TEACHER = '������';
update TEACHER set BIRTHDAY = '26-10-1999' where TEACHER = '?';
update TEACHER set BIRTHDAY = '30-07-1984' where TEACHER = '���';
update TEACHER set BIRTHDAY = '11-03-1975' where TEACHER = '���';
update TEACHER set BIRTHDAY = '12-07-1969' where TEACHER = '������';
update TEACHER set BIRTHDAY = '26-02-1983' where TEACHER = '�����';
update TEACHER set BIRTHDAY = '13-12-1991' where TEACHER = '������';
update TEACHER set BIRTHDAY = '20-01-1968' where TEACHER = '����';
update TEACHER set BIRTHDAY = '21-12-1969' where TEACHER = '����';
update TEACHER set BIRTHDAY = '28-01-1975' where TEACHER = '����';
update TEACHER set BIRTHDAY = '10-07-1983' where TEACHER = '������';
update TEACHER set BIRTHDAY = '08-10-1988' where TEACHER = '���';
update TEACHER set BIRTHDAY = '30-07-1984' where TEACHER = '�����';
update TEACHER set BIRTHDAY = '16-04-1964' where TEACHER = '������';
update TEACHER set BIRTHDAY = '12-05-1985' where TEACHER = '������';
update TEACHER set BIRTHDAY = '20-10-1980' where TEACHER = '�����';
update TEACHER set BIRTHDAY = '21-08-1990' where TEACHER = '���';
update TEACHER set BIRTHDAY = '13-08-1966' where TEACHER = '����';
update TEACHER set BIRTHDAY = '11-11-1978' where TEACHER = '����';
commit;

alter table TEACHER add SALARY number;
update TEACHER set SALARY = 9999 where TEACHER = '����';
update TEACHER set SALARY = 1030 where TEACHER = '�����';
update TEACHER set SALARY = 980 where TEACHER = '�����';
update TEACHER set SALARY = 1050 where TEACHER = '����';
update TEACHER set SALARY = 590 where TEACHER = '����';
update TEACHER set SALARY = 870 where TEACHER = '�����';
update TEACHER set SALARY = 815 where TEACHER = '���';
update TEACHER set SALARY = 995 where TEACHER = '���';
update TEACHER set SALARY = 1460 where TEACHER = '���';
update TEACHER set SALARY = 1120 where TEACHER = '����';
update TEACHER set SALARY = 1250 where TEACHER = '������';
update TEACHER set SALARY = 333 where TEACHER = '?';
update TEACHER set SALARY = 1520 where TEACHER = '���';
update TEACHER set SALARY = 1430 where TEACHER = '���';
update TEACHER set SALARY = 900 where TEACHER = '������';
update TEACHER set SALARY = 875 where TEACHER = '�����';
update TEACHER set SALARY = 970 where TEACHER = '������';
update TEACHER set SALARY = 780 where TEACHER = '����';
update TEACHER set SALARY = 1150 where TEACHER = '����';
update TEACHER set SALARY = 805 where TEACHER = '����';
update TEACHER set SALARY = 905 where TEACHER = '������';
update TEACHER set SALARY = 1200 where TEACHER = '���';
update TEACHER set SALARY = 1500 where TEACHER = '�����';
update TEACHER set SALARY = 905 where TEACHER = '������';
update TEACHER set SALARY = 715 where TEACHER = '������';
update TEACHER set SALARY = 880 where TEACHER = '�����';
update TEACHER set SALARY = 735 where TEACHER = '���';
update TEACHER set SALARY = 595 where TEACHER = '����';
update TEACHER set SALARY = 850 where TEACHER = '����';
commit;

-- 2. �������� ������ �������������� � ���� ������� �.�.
select regexp_substr(teacher_name,'(\S+)',1, 1)||' '||
    substr(regexp_substr(teacher_name,'(\S+)',1, 2),1, 1)||'.'||
    substr(regexp_substr(teacher_name,'(\S+)',1, 3),1, 1)||'.' as ���
from teacher;

-- 3. �������� ������ ��������������, ���������� � �����������.
select * from teacher
    where TO_CHAR((birthday), 'd') = 2;

-- 4. �������� �������������, � ������� ��������� ������ ��������������, ������� �������� � ��������� ������.
create or replace view NextMonthBirth as
      select *
      from teacher
      where TO_CHAR(birthday, 'mm') = 
      (
        select substr(to_char(trunc(last_day(sysdate)) + 1), 4, 2)
        from dual
      );
      
select * from NextMonthBirth;

-- 5. �������� �������������, � ������� ��������� ���������� ��������������, ������� �������� � ������ ������.
create view NumberMonths as
      select to_char(birthday, 'Month') �����,
             count(*) ����������
      from teacher
      group by to_char(birthday, 'Month')
        having count(*) >= 1
      order by ���������� desc;
    
select * from NumberMonths;

-- 6. ������� ������ � ������� ������ ��������������, � ������� � ��������� ���� ������.
declare
  cursor c_teachers is
   select * from teacher
        where mod((TO_CHAR(sysdate,'yyyy') - TO_CHAR(birthday, 'yyyy') + 1), 10) = 0;
  v_teacher teacher%rowtype;
begin
  open c_teachers;
  loop
    fetch c_teachers into v_teacher;
    exit when c_teachers%notfound;
    dbms_output.put_line(v_teacher.teacher_name || ' ' || v_teacher.birthday);
  end loop;
  close c_teachers;
end;

-- 7. ������� ������ � ������� ������� ���������� ����� �� �������� � ����������� ���� �� �����, 
-- ������� ������� �������� �������� ��� ������� ���������� � ��� ���� ����������� � �����.
declare
  cursor c_avg_salary is
    select P.faculty, T.pulpit, floor(avg(T.salary)) as avg_salary
    from teacher T
    join pulpit P on T.pulpit = P.pulpit
    group by rollup(P.faculty, T.pulpit)
    order by P.faculty, T.pulpit;
  v_faculty pulpit.faculty%type;
  v_pulpit pulpit.pulpit%type;
  v_avg_salary teacher.salary%type;
begin
  open c_avg_salary;
  dbms_output.put_line('Average Salary by Faculty and Pulpit:');
  loop
    fetch c_avg_salary into v_faculty, v_pulpit, v_avg_salary;
    exit when c_avg_salary%notfound;
    if v_pulpit is null then
      dbms_output.put_line('Faculty: ' || v_faculty || ' Average Salary: ' || v_avg_salary);
    else
      dbms_output.put_line('Faculty: ' || v_faculty || ' Pulpit: ' || v_pulpit || ' Average Salary: ' || v_avg_salary);
    end if;
  end loop;
  close c_avg_salary;  
end;


    
-- 8. �������� ����������� ��� PL/SQL-������ (record) � ����������������� ������ � ���.
-- ����������������� ������ � ���������� ��������. ����������������� � ��������� �������� ����������. 
 declare
        type DEGREE is record
        (
          science_degree nvarchar2(100),
          study_degree   nvarchar2(100)
        );
        type PERSON is record
        (
          name teacher.teacher_name%type,
          pulp teacher.pulpit%type,
          person_degree DEGREE
        );
      per1 PERSON;
      per2 PERSON;
    begin
      select teacher_name, pulpit into per1.name, per1.PULP
      from teacher
      where teacher = '����';
      
      per1.person_degree.science_degree := '������';
      per1.person_degree.study_degree := '�������������';
      per2 := per1;
      dbms_output.put_line( per2.name || ' ' || rtrim(per2.pulp) || ': ' ||
                            per2.person_degree.science_degree || ', ' || per2.person_degree.study_degree);
    end;


------------------------

SELECT P.faculty, T.pulpit, FLOOR(AVG(T.salary)) AS avg_salary
FROM teacher T
JOIN pulpit P ON T.pulpit = P.pulpit
GROUP BY ROLLUP(P.faculty, T.pulpit)
ORDER BY P.faculty, T.pulpit;

