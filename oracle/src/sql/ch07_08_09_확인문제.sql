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
 

 /**/
 
  