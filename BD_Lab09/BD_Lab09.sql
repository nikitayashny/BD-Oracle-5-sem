-- 1. Разработайте АБ, демонстрирующий работу оператора SELECT с точной выборкой. 
declare
  faculty_rec faculty%rowtype;
begin
  select * into faculty_rec from faculty where faculty = 'ИЭФ';
  dbms_output.put_line(rtrim(faculty_rec.faculty) || ': ' || faculty_rec.faculty_name);
exception when others 
    then dbms_output.put_line(sqlerrm);
end;

-- 2. Разработайте АБ, демонстрирующий работу оператора SELECT с неточной точной выборкой. Используйте конструкцию WHEN OTHERS 
-- секции исключений и встроенную функции SQLERRM, SQLCODE для диагностирования неточной выборки. 
declare
  faculty_rec faculty%rowtype;
begin
  select * into faculty_rec from faculty;   
  dbms_output.put_line(rtrim(faculty_rec.faculty) || ': ' || faculty_rec.faculty_name);
exception when others then 
  dbms_output.put_line('[ERROR] When others: ' || sqlerrm || sqlcode);
end;

-- 3. Разработайте АБ, демонстрирующий работу конструкции WHEN TO_MANY_ROWS 
-- секции исключений для диагностирования неточной выборки. 
declare
  faculty_rec faculty%rowtype;
begin
  select * into faculty_rec from faculty; -- та же ошибка, только типизированная
  DBMS_OUTPUT.PUT_LINE(faculty_rec.faculty ||' '||faculty_rec.faculty_name);
  exception
    when too_many_rows
    then DBMS_OUTPUT.PUT_LINE('[ERROR] When too_many_rows: '|| sqlerrm || sqlcode);
end;

-- 4. Разработайте АБ, демонстрирующий возникновение и обработку исключения NO_DATA_FOUND.
-- Разработайте АБ, демонстрирующий применение атрибутов неявного курсора.
declare
  faculty_rec faculty%rowtype;
begin
  select * into faculty_rec from faculty where faculty = 'ИЭФ'; 
  dbms_output.put_line(rtrim(faculty_rec.faculty)||': '||faculty_rec.faculty_name);
  
  if sql%found then
    dbms_output.put_line('%found:     true');
  else
    dbms_output.put_line('%found:     false');
  end if;
  
  if sql%isopen then    -- тут не используется курсор поэтому false
    dbms_output.put_line('$isopen:    true');
  else
    dbms_output.put_line('$isopen:    false');
  end if;
  
  if sql%notfound then
    dbms_output.put_line('%notfound:  true');
  else
    dbms_output.put_line('%notfound:  false');
  end if;
  
  dbms_output.put_line('%rowcount:  '|| sql%rowcount);
  
  exception
    when no_data_found then
      dbms_output.put_line('[ERROR] When no_data_found: ' || sqlerrm || '-' || sqlcode);
    when others then
      dbms_output.put_line(sqlerrm);
end;

-- 5. Разработайте АБ, демонстрирующий применение оператора UPDATE совместно с операторами COMMIT/ROLLBACK. 
-- 6. Продемонстрируйте оператор UPDATE, вызывающий нарушение целостности в базе данных. Обработайте возникшее исключение.
select * from auditorium order by auditorium;
begin
  update AUDITORIUM set 
    auditorium = '502-4',
    auditorium_name = '502-4',
    auditorium_capacity = 60,
    auditorium_type = 1  -- 'ЛК-К'
  where auditorium = '105-4';
  --commit;    
  rollback;
  dbms_output.put_line('[OK] Successfully updated.');
  exception when others then
    dbms_output.put_line('[ERROR] ' || sqlerrm);
end;

-- 7. Разработайте АБ, демонстрирующий применение оператора INSERT совместно с операторами COMMIT/ROLLBACK.
-- 8. Продемонстрируйте оператор INSERT, вызывающий нарушение целостности в базе данных. Обработайте возникшее исключение.
select * from auditorium order by auditorium;
begin
  insert into auditorium(auditorium, auditorium_name, auditorium_capacity, auditorium_type)
  values('505-5', '505-5', 80, 1); -- 'ЛК-К'
  --commit;    
  rollback;
  exception when others then
    dbms_output.put_line('[ERROR] ' || sqlerrm);
end;

-- 9. Разработайте АБ, демонстрирующий применение оператора DELETE совместно с операторами COMMIT/ROLLBACK.
-- 10. Продемонстрируйте оператор DELETE, вызывающий нарушение целостности в базе данных. Обработайте возникшее исключение.
select * from auditorium order by auditorium;
begin
  delete from auditorium where auditorium = '110-5';
  if(sql%rowcount = 0) then
    raise no_data_found;
  end if;
  --commit;
  rollback;
  exception when others then
    dbms_output.put_line('[ERROR] ' || sqlerrm);
end;

-- 11. Создайте анонимный блок, распечатывающий таблицу TEACHER с применением явного курсора LOOP-цикла. 
-- Считанные данные должны быть записаны в переменные, объявленные с применением опции %TYPE.
declare
  cursor curs_teacher is 
    select teacher, teacher_name, pulpit 
    from teacher;
  m_teacher teacher.teacher%type;
  m_teacher_name teacher.teacher_name%type;
  m_pulpit teacher.pulpit%type;
begin
  open curs_teacher;
    loop
    fetch curs_teacher into m_teacher, m_teacher_name, m_pulpit;
    exit when curs_teacher%notfound;
      dbms_output.put_line(' '||curs_teacher%rowcount||' '
      ||m_teacher||' '
      ||m_teacher_name||' '
      ||m_pulpit);
    end loop;
  close curs_teacher;
exception when others then
  dbms_output.put_line(sqlerrm);
end;

-- 12. Создайте АБ, распечатывающий таблицу SUBJECT с применением явного курсора иWHILE-цикла. 
-- Считанные данные должны быть записаны в запись (RECORD), объявленную с применением опции %ROWTYPE.
declare
  cursor curs_subject is
    select subject, subject_name, pulpit 
    from subject;
  rec_subject subject%rowtype;
begin
  open curs_subject;
  fetch curs_subject into rec_subject;
  while (curs_subject%found)
  loop
    dbms_output.put_line(' '||curs_subject%rowcount||' '
    ||rec_subject.subject||' '
    ||rec_subject.subject_name||' '
    ||rec_subject.pulpit);
    fetch curs_subject into rec_subject;
  end loop;
  close curs_subject;
  exception when others then
   dbms_output.put_line(sqlerrm);
end;

-- 13. Создайте АБ, распечатывающий все кафедры (таблица PULPIT) и фамилии всех преподавателей (TEACHER) использовав,
-- соединение (JOIN) PULPIT и TEACHER и с применением явного курсора и FOR-цикла.
declare
  cursor curs_pulpit is
    select pulpit.pulpit, teacher.teacher_name 
    from pulpit join teacher 
    on pulpit.pulpit = teacher.pulpit;
  rec_pulpit curs_pulpit%rowtype;
begin
  for rec_pulpit in curs_pulpit
  loop
    dbms_output.put_line(' ' ||curs_pulpit%rowcount||' '
    ||rec_pulpit.pulpit||' '
    ||rec_pulpit.teacher_name);
  end loop;
  exception when others then 
    dbms_output.put_line(sqlerrm);
end;

-- 14. Создайте АБ, распечатывающий следующие списки аудиторий: все аудитории (таблица AUDITORIUM) с вместимостью меньше 20, от 
-- 21-30, от 31-60, от 61 до 80, от 81 и выше. Примените курсор с параметрами и три способа организации цикла по строкам курсора
declare
  cursor curs_auditorium(minCapacity number, maxCapacity number) is 
    select auditorium, auditorium_capacity 
    from auditorium
    where auditorium_capacity >= minCapacity 
    and auditorium_capacity <= maxCapacity;
  curs_row curs_auditorium%rowtype;
begin
  dbms_output.put_line('CAPACITY < 20');
  for aum in curs_auditorium(0,20)
  loop
    dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;
  
  dbms_output.put_line('CAPACITY between 21 and 30');
  for aum in curs_auditorium(21,30)
  loop
    dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;
  
  dbms_output.put_line('CAPACITY between 31 and 60 ');
  for aum in curs_auditorium(31,60)
  loop
    dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;
  
  dbms_output.put_line('CAPACITY between 61 and 80 ');
  for aum in curs_auditorium(61,80)
  loop
    dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;
  
  dbms_output.put_line('CAPACITY > 81 ');
  for aum in curs_auditorium(81,1000)
  loop
    dbms_output.put_line(' '||aum.auditorium||' '||aum.auditorium_capacity);
  end loop;
  
  exception when others then
    dbms_output.put_line(sqlerrm);
end;

-- 15. Создайте AБ. Объявите курсорную переменную с помощью системного типа refcursor.
-- Продемонстрируйте ее применение для курсора c параметрами. 
declare
  type auditorium_ref is ref cursor return auditorium%rowtype ;
  xcurs auditorium_ref ;
  xcurs_row xcurs%rowtype;
begin
  open xcurs for select * from auditorium where auditorium_capacity < 50;
  fetch xcurs into xcurs_row;
  while (xcurs%found)
    loop
    dbms_output.put_line(' '||xcurs_row.auditorium||' '||xcurs_row.auditorium_capacity);
    fetch xcurs into xcurs_row;
  end loop;
  close xcurs;
  
  exception when others then
    dbms_output.put_line(sqlerrm);
end;

-- 16. Создайте AБ. Продемонстрируйте понятие курсорный подзапрос?
declare
  cursor curs_aut
  is 
    select auditorium_type, cursor
    (
      select auditorium
      from auditorium aum
      where aut.auditorium_type = aum.auditorium_type
    )
    from auditorium_type aut;
  curs_aum sys_refcursor;   
  aut auditorium_type.auditorium_type%type;
  txt varchar2(1000);
  aum auditorium.auditorium%type;
begin
  open curs_aut;
  fetch curs_aut into aut, curs_aum;
  while(curs_aut%found)
  loop
    txt:=rtrim(aut)||': ';
    
    loop
      fetch curs_aum into aum;
      exit when curs_aum%notfound;
      txt := txt||rtrim(aum)||'; ';
    end loop;
    
    dbms_output.put_line(txt);
    fetch curs_aut into aut, curs_aum;
  end loop;
  
  close curs_aut;
  exception when others then
    dbms_output.put_line(sqlerrm);
end;

-- 17. Создайте AБ. Уменьшите вместимость всех аудиторий (таблица AUDITORIUM) вместимостью от 40 до 80 на 10%. 
-- Используйте явный курсор с параметрами, цикл FOR, конструкцию UPDATE CURRENT OF. 
select * from auditorium order by auditorium;
declare
  cursor curs_auditorium(capacity auditorium.auditorium%type, capac auditorium.auditorium%type)
  is 
    select auditorium, auditorium_capacity 
    from auditorium
    where auditorium_capacity > capacity 
    and AUDITORIUM_CAPACITY < capac
    for update;
  aum auditorium.auditorium%type;
  cty auditorium.auditorium_capacity%type;
begin
  open curs_auditorium(40,80);
  fetch curs_auditorium into aum, cty;

  while(curs_auditorium%found)
  loop
    cty := cty * 0.9;
      update auditorium set auditorium_capacity = cty 
      where current of curs_auditorium;
    dbms_output.put_line(' '||aum||' '||cty);
    fetch curs_auditorium into aum, cty;
  end loop;
  
  close curs_auditorium;
  rollback;
  exception when others then
   dbms_output.put_line(sqlerrm);
end;
    
-- 18. Создайте AБ. Удалите все аудитории (таблица AUDITORIUM) вместимостью от 0 до 20. 
-- Используйте явный курсор с параметрами, цикл WHILE, конструкцию UPDATE CURRENT OF. 
select * from auditorium order by auditorium;
declare
  cursor curs_auditorium(minCapacity auditorium.auditorium%type, maxCapacity auditorium.auditorium%type)
  is 
    select auditorium, auditorium_capacity 
    from auditorium
    where auditorium_capacity >= minCapacity 
    and AUDITORIUM_CAPACITY <= maxCapacity 
    for update;
  aum auditorium.auditorium%type;
  cty auditorium.auditorium_capacity%type;
begin
  open curs_auditorium(0,20);
  fetch curs_auditorium into aum, cty;
  
  while(curs_auditorium%found)
  loop
    dbms_output.put_line(' '||aum||' '||cty);
    delete auditorium 
    where current of curs_auditorium;
    fetch curs_auditorium into aum, cty;
  end loop;
  close curs_auditorium;
  
  rollback;
  exception
  when others then
    dbms_output.put_line(sqlerrm);
end;

-- 19. Создайте AБ. Продемонстрируйте применение псевдостолбца ROWID в операторах UPDATE и DELETE. 
select * from auditorium order by auditorium;
declare
  cursor curs_auditorium(capacity auditorium.auditorium%type)
  is 
    select auditorium, auditorium_capacity, rowid 
    from auditorium
    where auditorium_capacity >= capacity

    for update;
  aum auditorium.auditorium%type;
  cty auditorium.auditorium_capacity%type;
begin
  for aud in curs_auditorium(20)
  loop
    case
      when aud.auditorium_capacity >= 60 then
        dbms_output.put_line('deleted'||' '||rtrim(aud.auditorium) || '   ' || rtrim(aud.auditorium_capacity) || '   ' || aud.rowid);
        delete auditorium where rowid = aud.rowid;
      when aud.auditorium_capacity >=20 then
        dbms_output.put_line('updated'||' '||rtrim(aud.auditorium) || '   ' || rtrim(aud.auditorium_capacity) || '   ' || aud.rowid);
        update auditorium 
        set auditorium_capacity = auditorium_capacity+10
        where rowid = aud.rowid;
    end case;
  end loop;
  
  rollback;
  exception when others then
    dbms_output.put_line(sqlerrm);
end;

-- 20. Распечатайте в одном цикле всех преподавателей (TEACHER), разделив группами по три (отделите группы линией -------------)
declare
  cursor curs_teacher is
    select teacher_name 
    from teacher;
  m_teacher_name teacher.teacher_name%type;
  k integer :=1;
begin
  open curs_teacher;
  loop
    fetch curs_teacher into m_teacher_name;
    exit when curs_teacher%notfound;
    dbms_output.put_line(' '|| m_teacher_name);
    if (k mod 3 = 0) then dbms_output.put_line('-------------------------------------------'); end if;
    k:=k+1;
  end loop;
  close curs_teacher;
  
  exception when others then
    dbms_output.put_line(sqlerrm);
end;























