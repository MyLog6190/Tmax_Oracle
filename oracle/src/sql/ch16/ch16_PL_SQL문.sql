 set serveroutput on
 
  /* 데이타 타입 */
  1  declare
  2  v_empno number(4) :=7839;
  3  v_ename varchar2(10);
  4  v_job  varchar2(10);
  5  begin
  6  v_ename :='KING';
  7  v_job :='PRESIDENT';
  8  dbms_output.put_line('v_empno:'||v_empno);
  9  dbms_output.put_line('v_ename:'||v_ename);
 10  dbms_output.put_line('v_job: '||v_job);
 11* end;
SQL> /
v_empno:7839
v_ename:KING
v_job: PRESIDENT
/*-----------------------------------------------------*/
PL/SQL procedure successfully completed.

  1  declare
  2  v_tax constant number(1) :=3;
  3  begin
  4  dbms_output.put_line('v_tex:'||v_tax);
  5* end;
SQL> /
v_tex:3

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
  1  declare
  2  v_tax constant number(1) :=3;
  3  v_sal number(7,2) :=5000;
  4  begin
  5  dbms_output.put_line('v_tex:'||v_sal*(v_tax/100));
  6* end;
SQL> /
v_tex:150

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> declare
  2  v_deptno number(2) default 10;
  3  begin
  4  dbms_output.put_line('v_deptno:'||v_deptno);
  5  end;
  6  /
v_deptno:10

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_deptno number(2) default 10;
  3  begin
  4  v_deptno :=20;
  5  dbms_output.put_line('v_deptno:'||v_deptno);
  6* end;
SQL> /
v_deptno:20

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_deptno number(2) not null :=10;
  3  begin
  4  dbms_output.put_line('v_deptno:'||v_deptno);
  5* end;
  6  /
v_deptno:10

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/


SQL> ed
Wrote file afiedt.buf

  1  declare
  2  --v_deptno number(2) :=50;
  3* v_deptno dept.deptno%type :=50;
  4  begin
  5  dbms_output.put_line('v_deptno: '||v_deptno);
  6  end;
  7  /
v_deptno: 50

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> declare
  2  v_dept_row dept%rowtype;
  3  begin
  4  select deptno, dname, loc into v_dept_row
  5    from dept
  6   where deptno = 40;
  7  dbms_output.put_line('deptno:'||v_dept_row.deptno);
  8  dbms_output.put_line('dname:'||v_dept_row.dname);
  9  dbms_output.put_line('loc:'||v_dept_row.loc);
 10  end;
 11  /
deptno:40
dname:OPERATIONS
loc:BOSTON

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_dept_row dept%rowtype;
  3  begin
  4  select deptno, dname, loc into v_dept_row
  5    from dept
  6   where deptno = 40;
  7  dbms_output.put_line('deptno:'||v_dept_row.deptno);
  8  dbms_output.put_line('dname:'||v_dept_row.dname);
  9  dbms_output.put_line('loc:'||v_dept_row.loc);
 10* end;


SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_name dept.dname%type;
  3  begin
  4  select dname into v_name
  5    from dept
  6   where deptno = 40;
  7  --dbms_output.put_line('deptno:'||v_dept_row.deptno);
  8  dbms_output.put_line('dname:'||v_name );
  9  --dbms_output.put_line('loc:'||v_dept_row.loc);
 10* end;
SQL> /
dname:OPERATIONS

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> declare
  2  v_number number :=13;
  3  begin
  4   if mod(v_number,2) =1 then
  5      dbms_output.put_line('v_number는 다.');
  6  end if;
  7  end;
  8  /
v_number는 다.


PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_number number :=13;
  3  begin
  4   if mod(v_number,2) =1 then
  5      dbms_output.put_line('v_number는 홀수입니다.');
  6  end if;
  7* end;
SQL> /
v_number는 홀수입니다.

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_number number :=14;
  3  begin
  4   if mod(v_number,2) =0 then
  5      dbms_output.put_line(v_number||'는 짝수입니다.');
  6  end if;
  7* end;
SQL> /
14는 짝수입니다.

PL/SQL procedure successfully completed.

/*-----------------------------------------------------*/


