/*---  ch19. 저장 서브 프로그램   ---*/
/*---- 파라미터 없는 프로시져 -----*/
CREATE OR REPLACE PROCEDURE pro_noparam
IS
  v_empno number(4) :=7788;
  v_ename varchar2(10);
BEGIN
	v_ename :='SCOTT';
	DBMS_OUTPUT.PUT_LINE('V_EMPNO :'||v_empno);
	DBMS_OUTPUT.PUT_LINE('V_ENAME :'||v_ename);
END;
/

/****** 프로시져 실행 **********************/
/* 1. sql커맨더에서 실행 */
set serveroutput on
exec pro_noparam;

/*2. 익명블록에서 실행 */
begin
  pro_noparam;
end 

/*------ 프로시저확인   ------------------*/
select * from user_objects where object_type='PROCEDURE';
/* 프로시져 내용 확인 */
select text from user_source where name='PRO_NOPARAM';

/* 프로시저 삭제 */
DROP procedure pro_noparam;


/*------- 파라미터 있는 프로시져 ------*/
create or replace procedure pro_param_in
(
 param1 in number,/* default in */
 param2 number, /* default모드 in */
 param3 number :=3,--값 초기화
 param4 number default 4--default값 지정
)
is
begin
	 dbms_output.put_line('param1 : '||param1);
	 dbms_output.put_line('param2 : '||param2);
	 dbms_output.put_line('param3 : '||param3);
	 dbms_output.put_line('param4 : '||param4);
end;
/

/* 파라미터명으로 접근 param1 =>값 */
EXECUTE pro_param_in(param1 => 10, param2 => 20);


/* out모드 파라미터 프로시져 */
create or replace procedure pro_param_out
( 
  in_empno in emp.empno%type,/* 값을 받는 변수*/
  out_ename out emp.ename%type,/* 프로시져 실행 후 값을 출력변수*/
  out_sal out emp.sal%type/* 프로시져 실행 후 값을 출력변수*/
)
as
begin
	select ename, sal 
	  into out_ename, out_sal
	  from emp
	 where empno =in_empno; 
end pro_param_out;
/


/*----  out모드의 파라미터 출력용 변수 선언 하여 실행결과 출력 ------*/
declare
v_ename emp.ename%type;
v_sal emp.sal%type;
begin
pro_param_out(7788,v_ename,v_sal);
dbms_output.put_line('ename:'||v_ename);
dbms_output.put_line('sal:'||v_sal);
end;
/

/* IN OUT 모드 파라미터 */
CREATE OR REPLACE PROCEDURE pro_param_input
( input_no IN OUT number )
is
begin
	input_no := input_no * 2;
end pro_param_input;
/

/* IN OUT 모드 파라미터 있는 프로시저 실행 */
declare
in_no number;/* IN OUT용 변수 선언*/
begin
  in_no :=5;
 pro_param_inout(in_no);
dbms_output.put_line('no:'||in_no);
end;
/
/*---------------  컴파일 에러 확인 ------------------*/
select * from user_Errors;


/*============= 함수(FUNCTION) ======================*/
CREATE OR REPLACE FUNCTION func_aftertax
( sal number )
return number
is
  tax number :=0.05;
begin
	return round(sal-(sal*tax));
end func_aftertax;
/


/* sql에서 호출하기 */
select empno, ename, sal, func_aftertax(sal)
  from emp
 order by empno;
 
/*--- 익명블럭에서 실행 ----*/ 
declare
aftertax number;
begin
 aftertax :=func_aftertax(3000);
dbms_output.put_line('after-tax income :'||aftertax); 
end;
/


/* 패키지 생성 */
create or replace package pkg_example
is
 spec_no number :=10;
 function func_aftertax(sal number) return number;
 procedure pro_emp(in_empno in emp.empno%type);
 procedure pro_dept(in_deptno in dept.deptno%type);
end;
/

/* body 생성 */
create or replace package body pkg_example
is
 body_no number :=10;
 function func_aftertax(sal number) return number
 is
 tax number :=0.05;
 begin
	 return round(sal-(sal*tax));
 end func_aftertax;
 procedure pro_emp(in_empno in emp.empno%type)
 is
  out_name emp.ename%type;
  out_sal emp.sal%type;
  begin
	  select ename, sal 
	    into out_name, out_sal
	    from emp
	   where empno = in_empno;
	   dbms_output.put_line('ename: '||out_name);
	   dbms_output.put_line('sal: '||out_sal);
  end pro_emp;
procedure pro_dept(in_deptno in dept.deptno%type)
is
out_dname dept.dname%type;
out_loc dept.loc%type;
begin
	select dname,loc
	  into out_dname,out_loc
	  from dept
	 where deptno = in_deptno;
	 dbms_output.put_line('dname: '||out_dname);
	dbms_output.put_line('loc: '||out_loc);
end pro_dept;
end;
/

/** 실행 패키지명.서브프로그램 */
begin
  dbms_output.put_line('----pkg_example.function');
  dbms_output.put_line('aftertax:'||pkg_example.func_aftertax(3000));
  
end ;
/


/* 트리거용 테이블 생성
 */
create table emp_trg
as
select * from emp;
commit;

select * from emp_trg;

select to_char(sysdate,'dy') from dual;

/*------- 트리거 ------------------*/
create or replace trigger trg_emp_nodml_weekend
before
insert or update or delete on emp_trg
begin
   if to_char(sysdate,'DY') in ('토','일') then
     if INSERTING THEN
        raise_application_error(-20000,'주말 사원정보 추가 불가');
     elsif updating then
        raise_application_error(-20001,'주말 사원정보 수정 불가');
     elsif deleting then
        raise_application_error(-20002,'주말 사원정보 삭제 불가');
     else
        raise_application_error(-20003,'주말 사원정보 변경 불가');
     end if;
   end if; 
end;
/

/*********** 트리거 조회 ***************************/
select * from user_triggers;
select * from user_objects where object_type='TRIGGER';



select * from emp_trg;

insert into emp_trg
values (9999,'홍길동','MANAGER',NULL,sysdate,5000,null,10);

commit;


/* */
create table emp_trg_log(
tablename varchar2(10),
dml_type varchar2(10),
empno number(4),
user_name varchar2(30),
change_date date
);


/*트리거 생성 */
create or replace trigger trg_emp_log
after
insert or update or delete on emp_trg
for each row
begin
  if inserting then
     insert into emp_trg_log
     values('EMP_TRG', 'INSERT', :new.empno,/*:old-null, :new-입력값*/
             sys_context('USERENV','SESSION_USER'),sysdate);
             
  elsif updating then
     insert into emp_trg_log
     values('EMP_TRG', 'UPDATE', :old.empno,/*:old-수정전,:new-수정후값*/
             sys_context('USERENV','SESSION_USER'),sysdate);
     
  
  elsif deleting then
     insert into emp_trg_log
     values('EMP_TRG', 'DELETING', :old.empno,/*:old-삭제전,:new-null*/
             sys_context('USERENV','SESSION_USER'),sysdate);
  
  end if;
end;
/

alter trigger trg_emp_log disable;

update emp_trg 
   set sal = sal+sal*0.10;
  where empno=7788;

select * from emp_trg_log;  


/**/
create table emp_trg_log2
as
select empno , sal as fromsal, sal tosal, sysdate chg_date
  from emp
 where 1=0;
 
 select * from emp_trg_log2;
 

create or replace trigger trg_emp_log2
after
 update on emp_trg
for each row
begin
  if updating then
     insert into emp_trg_log
     values(:old.empno, :old.sal, :new.sal, sysdate);
  end if;
end;
/


select * from user_triggers;

update emp_trg
   set sal = sal+sal*0.05
 where empno=7788;
 
select * from emp_trg where empno=7788;

select * from emp_trg_log2;
