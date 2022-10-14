/* DML - insert */
/* 기존테이블로 새로운 테이블 생성 
 * create table 새로운테이블명 as select문 
 * where 거짓 조건 - 빈 테이블만 생성 */
create table dept_temp 
   as 
  select * from dept where 1=0;/**/
select * from dept_temp;

create table dept_temp1 
   as 
  select * from dept;/**/
select * from dept_temp1;  
/* 10번 테이블 */
create table dept_10 
   as 
  select * from dept where deptno = 10 ;
select * from dept_10;

select * from dept_temp;

/* insert into 테이블명(칼럼1,칼럼2,칼럼3) values(값1,값2,값3);*/
insert into dept_temp(deptno,dname,loc) 
  values(10,upper('accounting'),upper('new york'));
  
/* insert into 테이블명 values(값1,값2,값3); */
insert into dept_temp values(20,'RESEARCH','DALLAS');  

/*insert into 테이블명(칼럼3,칼럼1,칼럼2) values(값3,값1,값2);*/
insert into dept_temp(loc,deptno,dname) 
   values('CHICAGO', 30, 'SALES');
   
/* alter table dept_temp modify
 loc varchar2(20)  default 'BOSTON' not null; 
*/   
   
/* insert into 테이블명(칼럼1,칼럼2) values(값1,값2); */
insert into dept_temp(deptno,dname) 
  values(40,'OPERATIONS');  
  
insert into dept_temp(deptno,dname) 
  values(50,'OPERATIONS2'); 
  
insert into dept_temp(deptno,dname,loc) 
  values(60,'OPERATIONS3','NEW YORK');

/* 명시적 null값 저장 */  
insert into dept_temp(deptno,dname) values(70,NULL);  

create table dept_temp2
as
select * from dept;

select * from dept_temp2;
/* 명시적 null값 입력 */
insert into dept_temp2 values (70,'WEB', NULL);
/* 암시적 null값 입력 */
insert into dept_temp2(deptno,dname) 
   values (80,'MOBILE');






