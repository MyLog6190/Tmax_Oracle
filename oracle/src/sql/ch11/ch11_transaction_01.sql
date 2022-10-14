/* transaction commi; rollback */
create table dept_tcl as select * from dept;
select * from dept_tcl;

insert into dept_tcl values(50,'DATABASE','SEOUL');
update dept_tcl set loc = 'BUSAN' where deptno=40;
delete from dept_tcl where dname = 'RESEARCH';

select * from dept_tcl;
/* 메모리에서 작업한 내용을 DB에 영구 저장 */
commit;

insert into dept_tcl values(60,'WEB','PANGYO');
update dept_tcl set loc = 'JEJU' where deptno=40;
delete from dept_tcl where dname = 'DATABASE';
select * from dept_tcl;
/* 앞전 commit시점 이후 부터 작업 insert,update,delete작업 
 * 내용을 이전 commit시점을 되돌림 */
ROLLBACK;

update dept_tcl set dname='DATABASE' where deptno=30;