alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';

-- создание таблиц 
create table teacher_backup (
  teacher      char(20),
  teacher_name nvarchar2(50),
  pulpit       char(20),
  salary      number
);

create table teacher_backup2 (
  teacher      char(20),
  teacher_name nvarchar2(50),
  pulpit       char(20),
  salary      number
);

create table job_status (
  status   nvarchar2(50),
  datetime timestamp default current_timestamp
);

-- Пакет DBMS_JOB

-- Копирование части данных по условию из одной таблицы в другую, после чего эти данные из первой таблицы удаляются
create or replace procedure jobprocedure is
  cursor teachercursor is select * from teacher where salary > 1000;
  begin
    for n in teachercursor
      loop
        insert into teacher_backup (teacher, teacher_name, pulpit, salary)
        values (n.teacher, n.teacher_name, n.pulpit, n.salary); 
      end loop;
    delete from teacher where salary > 1000;
    insert into job_status (status) values ('SUCCESS');
    commit;
    exception when others then 
        insert into job_status (status) values ('FAIL');
        raise;
end;

begin
  jobprocedure();
end;

select * from teacher_backup;
select * from teacher;
select * from job_status;

-- Создание задания которое выполняется раз в неделю
declare v_job number;
begin
  SYS.dbms_job.submit(
      job => v_job,
      what => 'BEGIN jobprocedure(); END;',
      next_date => SYSDATE + INTERVAL '1' HOUR,
      interval => 'TRUNC(SYSDATE, ''IW'') + INTERVAL ''7'' DAY');
  commit;
end;

select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

-- запустить немедленно
begin
  dbms_job.run(2);
end;
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

-- разрешение задания
begin
  dbms_job.broken(2, broken => false);
end;
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

-- удалить задание из очереди
begin
  dbms_job.remove(2);
end;
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

--создать задание с номером
begin
  dbms_job.isubmit(2, 
  'BEGIN jobprocedure(); END;', 
  sysdate, 
  'sysdate + 60/86400');
  commit;
end;
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

-- Пакет DBMS_SHEDULER

-- копирование части данных по условию из одной таблицы в другую, после чего эти данные из первой таблицы удаляются
create or replace procedure jobprocedure2 is
  cursor teachercursor2 is select * from teacher where salary < 1000;
  begin
    for n in teachercursor2
      loop
        insert into teacher_backup2 (teacher, teacher_name, pulpit, salary)
        values (n.teacher, n.teacher_name, n.pulpit, n.salary); 
      end loop;
    delete from teacher where salary < 1000;
    insert into job_status (status) values ('SUCCESS');
    commit;
    exception when others then 
        insert into job_status (status) values ('FAIL');
        raise;
end;

begin
  jobprocedure2();
end;

select * from teacher_backup2;
select * from teacher;
select * from job_status;

-- Создание задания которое выполняется раз в неделю
begin
  dbms_scheduler.create_job(
      job_name => 'jsh_2',
      job_type => 'STORED_PROCEDURE',
      job_action => 'procedure',
      start_date => sysdate,
      repeat_interval => 'FREQ=DAILY; INTERVAL=7;BYHOUR=9; BYMINUTE=30;BYSECOND=30',
      enabled => true
  );
end;

select job_name, job_type, job_action, start_date, repeat_interval, next_run_date, enabled from user_scheduler_jobs;
select job_name, state from  user_scheduler_jobs;

begin
  dbms_scheduler.drop_job('jsh_2', true);
end;

begin
  dbms_scheduler.RUN_JOB(JOB_NAME => 'JSH_2'); -- не работает
end;

SELECT job_name FROM dba_scheduler_jobs where job_name = 'JSH_2'; -- а это работает














































--begin
--  dbms_scheduler.create_schedule(
--      schedule_name => 'Sch_2',
--      start_date => sysdate,
--      repeat_interval => 'FREQ=DAILY;',
--      comments => 'Sch_2 DAILY at 10:00'
--  );
--end;

--select * from user_scheduler_schedules;

--begin
--  dbms_scheduler.create_program(
--      program_name => 'Pr_2',
--      program_type => 'STORED_PROCEDURE',
--      program_action => 'up_job',
--      number_of_arguments => 0,
--      enabled => false,
--      comments => 'Sch_2 DAILY at 10:00'
--  );
--end;

--select * from user_scheduler_programs;


