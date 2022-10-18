/* 과제 7-8-9*/
/* 7-1.
 * emp테이블 부서번호,평균급여,최고급여,최저급여,사원수 */
select deptno,round(avg(sal)),max(sal),min(sal),count(*)
  from emp
 group by deptno;
 
/*7-2  같은 직책(job)에 종사하는 사원이 3명 이상인 직책과 인원수 */
select job, count(*)
 from emp
group by job
having count(*) >=3
;

/* 7-3. 입사년도기준 부서별 입사인원 */
select to_char(hiredate,'yyyy'),
       deptno,
       count(*)
  from emp
 group by to_char(hiredate,'yyyy'),deptno
 order by to_char(hiredate,'yyyy') desc,deptno desc
 ;

/* 7-4. comm  */ 
/*select nvl(to_char(comm),'X')
  from emp;
  */
select nvl2(to_char(comm),'O','X'),
       count(*)
  from emp
 group by nvl2(to_char(comm),'O','X')
 ;
  
/* 7-5. 각 부서 입사 연도별 사원수, 최고급여, 급여합, 평균급여 */
select deptno,
       to_char(hiredate,'yyyy'),
       count(*),
       max(sal),
       min(sal),
       sum(sal),
       avg(sal)
  from emp
 group by rollup(deptno,to_char(hiredate,'yyyy') )
 ;
 

 /* 8-1. sal 2000 초과인 사원들의 부서 정보, 사원정보 출력 */
 /* SQL-99 이전 */
select emp.deptno, dname, empno, ename, sal
  from emp, dept
 where emp.deptno = dept.deptno
   and sal >2000
 order by emp.deptno, dname, empno, ename, sal
 ;
 /* SQL-99 이후 */ 
select deptno, dname, empno, ename, sal
  from emp natural join dept
 where sal >2000
 ;
  
/* 8-2. 부서별 평균급여,최대급여,최소급여, 사원수 */
/* SQL-99 이전 */ 
select emp.deptno, min(dname), round(avg(sal)), max(sal), 
       min(sal), count(*)
  from emp, dept
 where emp.deptno=dept.deptno
 group by emp.deptno;
 
 /* SQL-99 이후 */
select deptno, min(dname) dname, round(avg(sal)) avg_sal, 
       max(sal) max_sal, min(sal) min_sal, count(*) cnt
  from emp natural join dept
 group by deptno
 order by deptno
 ;
  
/* 8-3 */ 
 /* SQL-99 이전 */
 select dept.deptno, dname, empno,ename, job, sal
  from emp, dept
 where emp.deptno(+) = dept.deptno
 order by dept.deptno;
/* SQL-99 */ 
 select dept.deptno, dname, empno,ename, job, sal
  from emp right outer join dept on (emp.deptno=dept.deptno)
 order by dept.deptno; 
 

/* 8-4. 부서정보, 급여정보, 직속상관 정보 */ 
/* SQL-99 이전 */ 
select d.deptno, dname, e.empno, e.ename, e.mgr,e.sal,
       e.deptno,s.losal,s.hisal,s.grade, 
       e2.empno mgr_empno,e2.ename mgr_ename 
  from emp e, dept d, salgrade s, emp e2
 where e.deptno(+) = d.deptno
   and e.sal between s.losal(+) and s.hisal(+)
   and e.mgr = e2.empno(+)
 order by d.deptno, e.empno
;
/* SQL-99 이후 */
select d.deptno, dname, e.empno, e.ename, e.mgr,e.sal,
       e.deptno,s.losal,s.hisal,s.grade, 
       e2.empno mgr_empno,e2.ename mgr_ename 
  from emp e right outer join dept d on (e.deptno = d.deptno) 
             left outer join salgrade s on (e.sal between s.losal and s.hisal)
             left outer join emp e2 on (e.mgr = e2.empno)
 order by d.deptno, e.empno
 ;

 /* 9-1. 전체 사원 중 ALLEN과 같은 직책(JOB) 인 사원 */
select job from emp where ename='ALLEN'; 
select job, ename, sal, emp.deptno, dname 
  from emp, dept 
 where emp.deptno = dept.deptno
   and job =(select job from emp where ename='ALLEN');
   
/*9-2*/
select avg(sal) from emp;
select emp.deptno,dname, hiredate, loc, sal,grade 
  from emp, dept, salgrade 
 where emp.deptno = dept.deptno
   and emp.sal between losal and hisal
   and sal > (select avg(sal) from emp)
 order by sal desc, empno asc;
 
/*9-3*/
select distinct job from emp where deptno=30; 
select empno, ename, job, emp.deptno, dname, loc 
  from emp, dept
 where job not in (select distinct job 
                     from emp 
                    where deptno=30)
   and emp.deptno=10
   ;
   
/*9-4*/
select max(sal) from emp where job = 'SALESMAN';  
select sal from emp where job = 'SALESMAN';
/* 다중행 서브쿼리 */
select empno, ename, sal, grade
  from emp, salgrade
 where sal between losal and hisal
   and sal > all (select sal 
                    from emp 
                   where job = 'SALESMAN');
 
/* 다중행 서브쿼리 미사용 */
select empno, ename, sal, grade
  from emp, salgrade
 where sal between losal and hisal
   and sal >  (select max(sal) 
                 from emp 
                where job = 'SALESMAN');