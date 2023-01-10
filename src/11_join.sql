/*---- 오라클 SQL문 : 조인(join) ----*/
select * from dept;
select * from emp;

--[1] 'SCOTT'이 근무하는 부서명, 지역 출력
-- 원하는 정보가 두 개 이상의 테이블에 나뉘어져 있을 때 결과 출력

-- (1) cross join
select * from emp, dept;

-- (2) equi join : 동일 컬럼을 기준으로 조인한다.
-- 컬럼명 앞에 테이블을 기술하여 컬럼 소속을 명확히 밝힐 수 있다.
-- 테이블명에 별칭을 준 후 컬럼 앞에 소속 테이블을 지정하고자 할 때,
-- 반드시 테이블명이 아닌 별칭으로 붙여야 함
select ename, dname, loc from emp, dept
where emp.deptno = dept.deptno and ename = 'SCOTT'; 

-- (3) non-equi join : 동일 컬럼이 없이 다른 조건을 사용하여 조인한다.
select ename, sal, grade from emp, salgrade
where sal between losal and hisal;

-- emp, dept, salgrade 3개의 테이블 join
select ename, sal, grade, dname from emp, salgrade, dept
where emp.deptno = dept.deptno and sal between losal and hisal;

-- (4) self join : 힌 테이블 내에서 조인한다.
select employee.ename, employee.mgr, manager.ename as 사수
from emp employee, emp manager
where employee.mgr = manager.empno;

-- (5) outer join : 조인 조건에 만족하지 않는 행도 나타낸다.
select employee.ename, employee.mgr, manager.ename as 사수
from emp employee, emp manager
where employee.mgr = manager.empno(+);

--[3] ANSI join
-- (1) ANSI cross join
select * from emp cross join dept;

-- (2) ANSI inner join
select ename, dname, loc from emp inner join dept
on emp.deptno = dept.deptno and ename = 'SCOTT';

select ename, dname, loc from emp inner join dept
on emp.deptno = dept.deptno where ename = 'SCOTT';

select ename, dname, loc from emp inner join dept
using (deptno)
where ename = 'SCOTT';

-- (3) ANSI natural join (= equi join)
select ename, dname from emp natural join dept;

-- (4) ANSI outer join
create table dept_ansi
(
    deptno  number(2),
    dname   varchar2(14)
);

insert into dept_ansi values(10, 'accounting');
insert into dept_ansi values(20, 'research');

create table dept_ansi2
(
    deptno number(2),
    dname varchar2(14)
);

insert into dept_ansi2 values(10, 'accounting');
insert into dept_ansi2 values(30, 'sales');

-- 기존 방법(오라클)
select * from dept_ansi, dept_ansi2
where dept_ansi.deptno = dept_ansi2.deptno(+);

-- ANSI 방법
select * from dept_ansi left outer join dept_ansi2
using(deptno);

select * from dept_ansi left outer join dept_ansi2
on dept_ansi.deptno = dept_ansi2.deptno;

select * from dept_ansi right outer join dept_ansi2
on dept_ansi.deptno = dept_ansi2.deptno;

select * from dept_ansi full outer join dept_ansi2
on dept_ansi.deptno = dept_ansi2.deptno;
