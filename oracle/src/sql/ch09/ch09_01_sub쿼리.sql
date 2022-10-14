/* sub쿼리 */
/* 'JONES'사원의 급여보다 많이 받는 사원 출력 */
select sal from emp where ename = 'JONES';
select * from emp where sal > 2975;

/* SUB쿼리 */
select * 
  from emp 
 where sal > (select sal 
                from emp 
               where ename = 'JONES');
               
/* 'SCOTT'사원 보다 입사일자 먼저인 사원들 정보 출려 */
select * from emp where hiredate < '1981-07-13';
select hiredate from emp where ename ='SCOTT';   

/*update emp set hiredate = to_date('1981-07-13') 
 where ename='SCOTT'; */

select * 
  from emp
 where hiredate < (select hiredate 
                     from emp 
                    where ename='SCOTT');

/*  전체 평균급여보다 급여를 많이 받는 사원들 출력 */
select avg(sal) from emp; /* 2073.214285714285714285714285714285714286
 */
select * from emp where sal >  2073.214285714285714285714285714285714286
;                    
/* 집계함수를 이용한 sub쿼리 */
select empno, ename, job, sal
  from emp
 where sal > (select avg(sal) from emp);
 
/* join한 테이블에서 sub쿼리 */ 
select empno, ename, job, sal, dept.deptno, dname,loc
  from emp, dept
 where emp.deptno = dept.deptno
   and sal > (select avg(sal) from emp);
   
/* 다중 행 sub쿼리 */
/* 부서별 최대 급여를 받는 사원들의 정보 출력 */ 
select *
  from emp
 where sal in (2850,3000,5000);
 
/* 다중행 결과는 in()으로 대체가능 */ 
select *
  from emp
 where sal in (select max(sal) from emp group by deptno);
/* 다중 행 = 비교는 = any, =some */ 
select *
  from emp
 where sal = any (select max(sal) from emp group by deptno); 

 select *
  from emp
 where sal = some (select max(sal) from emp group by deptno);  
 
/* 30번 부서의 최대 급여(2850) 보다 적게받는 사원들 정보 출력
 * any(some) 서브쿼리와 비교조건에 하나만 만족해도 true */               
select sal from emp where deptno = 30; 
select *
  from emp
 where sal < some (select sal from emp where deptno = 30);
 
/* 30번 부서의 급여보다 적게받는 사원들 정보 출력
 * all 서브쿼리와 비교조건에서 모두 만족해얃 true */                
select *
  from emp
 where sal < all (select sal from emp where deptno = 30);               
   
/* 30번 부서의 최대급여보다(2850) 많이받는 사원만 출력 ,all */
select *
  from emp
 where sal > all (select sal from emp where deptno = 30);
 
select *
  from emp
 where sal > (select max(sal) from emp where deptno = 30);
 
/* exists 조건에 맞는 결과가 존재하면 true */
select *
  from emp
 where exists (select dname from dept where deptno=10);
 
 select *
  from emp
 where exists (select sysdate from dual);
 
select *
  from emp
 where not exists (select dname from dept where deptno=10);

 /* where 조건에 칼럼 두개 이상 sub쿼리와 비교
  * where (칼럼1,칼럼2,..) in (select 칼럼1, 칼럼2,..) */
select *
  from emp
 where (deptno,sal )in (select deptno, max(sal) 
                          from emp 
                          group by deptno);
                          
                          
select *
  from emp
 where (empno, ename) in (select empno, ename 
                          from emp 
                         where sal=1250
                         );
                    
/* from 절에 sub쿼리 사용하기 */                         
select * from emp where deptno=10;    
select * from dept;

select *
  from (select * from emp where deptno=10) a,
       (select * from dept) b
 where a.deptno = b.deptno
 ;
 
select ename, sal, dname
  from 
(select empno, ename, sal, deptno 
  from emp where deptno=10) a,
(select deptno, dname from dept) b  
where a.deptno = b.deptno
;

/* from절의 sub쿼리 */
select rownum, empno, ename, sal
  from emp
  ;
  
select rownum, empno, ename, sal
  from emp
 where rownum <= 5;
  ;
  
select rownum, empno, ename, sal
  from emp
 where rownum >= 5;
  ;

select *
  from (select rownum as rn, empno, ename, sal
          from emp
        ) a
  where rn >= 5
 ;
  
select *
  from (select rownum as rn, empno, ename, sal
          from emp
        ) a
  /*where rn >= 5 and rn <=10 */
  where rn between 5 and 10
 ;  
/* rownum가상(pseudo)칼럼 에 별칭을 붙여서 다른칼럼으로 사용 */ 
select *
  from (select rownum as rn, empno, ename, sal
          from emp
         where rownum <=10
        ) a
  where rn >=5
 ;
 
/* with절은 select전에 선언  */
with
e10 as (select * from emp where deptno=10),
d as (select * from dept)
select e10.empno, e10.ename,e10.deptno, d.dname,d.loc
 from e10,d
where e10.deptno = d.deptno
;

/* 칼럼에 사용되는 sub쿼리 */
select empno, ename, job, sal,
(select grade 
   from salgrade 
  where e.sal between losal and hisal) as salgrade,
(select dname 
   from dept 
  where e.deptno=dept.deptno) as dname
from emp e;
