------------- ch 17 -------------

-- 1
CREATE TABLE EMP_RECODE AS SELECT * FROM EMP WHERE 1=0;

SET SERVEROUTPUT ON;
DECLARE
	TYPE EMP_COLUMN IS RECORD(
		EMPNO EMP.EMPNO%TYPE
		ENAME EMP.ENAME%TYPE
		JOB EMP.JOB%TYPE
		MGR EMP.MGR%TYPE
		HIREDATE EMP.HIREDATE%TYPE
		SAL EMP.SAL%TYPE
		COMM EMP.COMM%TYPE
		DEPT EMP.DEPT%TYPE
	);
	RECORD_EMP EMP_COLUMN
BEGIN
	EMPNO := 1111;
	ENAME := TEST_USER;
	JOB := TEST_JOB;
	HIREDATE := 18/03/01;
	COMM := 3000;
	DEPT := 40;
	
	insert into EMP_RECORD
	values RECORD_EMP;
END;
/

-- 2

DECLARE
	TYPE EMP_COLUMN IS RECORD(
		EMPNO EMP.EMPNO%TYPE
		ENAME EMP.ENAME%TYPE
		JOB EMP.JOB%TYPE
		MGR EMP.MGR%TYPE
		HIREDATE EMP.HIREDATE%TYPE
		SAL EMP.SAL%TYPE
		COMM EMP.COMM%TYPE
		DEPT EMP.DEPT%TYPE
	);
	RECORD_EMP EMP_COLUMN
	
	TYPE ITAB_EX IS TABLE RECORD_EMP
	INDEX BY PLS_INTEGER;
	
	EMP_ARR ITAB_EX;
    IDX PLS_INTEGER := 0;
BEGIN
	   FOR I IN (select deptno, dname from EMP) LOOP
	   idx := idx+1;
	   EMP_ARR[IDX] := I.EMPNO
	   
	end loop;
END;
/
