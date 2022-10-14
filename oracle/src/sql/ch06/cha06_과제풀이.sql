/* 과제 chaap06 */
/* 1. emp테이블의 empno 세번째부터 *로 마스킹, 이름 두번째부터 *로 마스킹 
 * length(ename) >=5 and length(ename) < 6
 * */
select empno,
       rpad(substr(empno,1,2),length(empno),'*') as masking_empno,
       ename,
       rpad(substr(ename,1,1),length(ename),'*') as masking_ename
  from emp
 where length(ename) >=5 and length(ename) < 6; 
 

 /*2. 월 평균 근무 일수 21.5일 하루 8시간 근무, 하루급여(day_pay)와 시급(time_pay) 
  * 하루급여는 소수점 세번째 자리에서 버리고 truc(데이터,2),
  * 시급은 두번째 소수점에서 반올림rond(데이타,1)
  */
select empno,
       ename,
       sal,
       trunc(sal/21.5,2) as day_pay,
       round(sal/21.5/8, 1) as time_pay
  from emp;
  
/*3. 입사일 기준으로 3개월이 지난 후(add_months()) 첫 월요일(next_day('월요일') 정직원이 됨. 
 *R_JOB to_char(데이타,'YYYY-MM-DD'), COMM이 없는 사원(nvl) N/A
 * */
select empno,
       ename,
       hiredate,
       to_char(hiredate,'yyyy/mm/dd'),
       add_months(hiredate,3),
       next_day(add_months(hiredate,3),'월요일'),
       to_char(next_day(add_months(hiredate,3),'월요일'),'yyyy-mm-dd') as R_JOB,
       nvl(to_char(comm),'N/A') AS COMM
  from emp;
  
/*4. 직속상관 여부 없을때 '0000', 75->'5555', 76->'6666', 77->'7777',78->'8888',
 * 그 외는 직속상관 번호 그대로 출력 */  
select empno, ename, mgr,
       substr(mgr,1,2),
       decode(substr(mgr,1,2),'75','5555',
                              '76','6666',
                              '77','7777',
                              '78','8888',
                              nvl(to_char(mgr),'0000'))
 from emp;
  
select empno, ename, mgr,
       case substr(mgr,1,2) 
       when '75' then '5555'
       when '76' then '6666'
       when '77' then '7777'
       when '78' then '8888'
       else nvl(to_char(mgr),'0000')
       end as chg_mgr
 from emp;
 
 
select empno, ename, mgr,
       case  
       when substr(mgr,1,2)='75' then '5555'
       when substr(mgr,1,2)='76' then '6666'
       when substr(mgr,1,2)='77' then '7777'
       when substr(mgr,1,2)='78' then '8888'
       else nvl(to_char(mgr),'0000')
       end as chg_mgr
 from emp;  
  
 select empno, ename, mgr,
       case  
       when mgr is null then '0000'
       when substr(mgr,1,2)='75' then '5555'
       when substr(mgr,1,2)='76' then '6666'
       when substr(mgr,1,2)='77' then '7777'
       when substr(mgr,1,2)='78' then '8888'
       else to_char(mgr)
       end as chg_mgr
 from emp;  
       
       
       
       
       
       