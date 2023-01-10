/* ---- 오라클 뷰(view) ----*/
--[1] 기본 테이블 생성
-- (1) DEPT 테이블을 복사한 DEPT_COPY 테이블을 생성해서 사용하도록 함
create table dept_copy as select * from dept;

-- (2) EMP 테이블을 복사한 EMP_COPY 테이블을 생성해서 사용하도록 함.
create table emp_copy as select * from emp;

--[2] 뷰 정의하기
-- ex) 만일 30번 부서에 소속된 사원들의 사번, 이름, 부서번호를 자주 검색한다고 가정하면
create view emp_view30
as select empno, ename, deptno from emp_copy
where deptno = 30;

-- view를 생성할 수 있는 권한 부여
-- cmd에서 sqlplus system/admin1234 연결
-- grant create view to scott;

--[문제] 기본테이블은 emp_copy. 20번 부서에 소속된 사원들의 사번과 이름, 부서번호, 상관의 사번을 출력하기 
-- 위한 select 문을 emp_view20이라는 이름의 뷰로 정의
create view emp_view20
as select ename, deptno, mgr from emp_copy where deptno = 20;

--[3] 뷰의 내부 구조와 user_views 데이터 딕셔너리
desc user_views;
select view_name, text from user_views;

--[4] 뷰의 동작 원리(pdf)
--[5] 뷰와 기본 테이블 관계 파악
-- (1) 뷰를 통한 데이터 저장이 가능한지?
insert into emp_view30 values(8000, 'ANGEL', 30);
select * from emp_view30;
select * from emp_copy;
desc emp;

-- (2) insert문에 뷰(emp_view30)를 사용했지만, 뷰는 쿼리문에 대한 이름일 뿐 새로운 레코드는 기본 테이블(emp_copy)에 실질적으로 추가된다.

--[6] 뷰의 특징
-- (1) 단순 뷰(한 개의 테이블)에 대한 데이터 조직
insert into emp_view30 values(8010, 'cheolsoo', 30);
select * from emp_view30;
select * from emp_copy;

--  (1) 단순 뷰의 컬럼에 별칭 부여하기
create view emp_view_copy(사원번호, 사원명, 급여, 부서번호) as
select empno, ename, sal, deptno from emp_copy;

select * from emp_view_copy
where 부서번호 = 30;

select * from emp_view_copy;

--  (2) 그룹 함수를 사용한 단순 뷰
create view view_sal as
select deptno, sum(sal) as salSum, avg(sal) as salAvg
from emp_copy
group by deptno;

select * from view_sal;

create view view_sal_year as
select ename, sal * 12 SalYear from emp_copy;

insert into view_sal_year values('miae', 12000);

-- (2) 복합 뷰(두개 이상의 테이블)
create view emp_view_dept as
select empno, ename, sal, e.deptno, dname, loc from emp e, dept d
where e.deptno = d.deptno
order by empno desc;

--[7] 뷰 삭제
drop view emp_view_dept;

--[8] 뷰 생성에 사용되는 다양한 옵션 (or replace)
create or replace view emp_view30 as
select empno, ename, comm, deptno from emp_copy
where deptno = 30;

select * from emp_view30;

--[9] 뷰 생성에 사용되는 다양한 옵션 (force/noforce)
create or replace force view employees_view as
select empno, ename, deptno from employees
where deptno = 30;

select view_name, text from user_views;

--[10] 뷰 생성에 사용되는 다양한 옵션 (with check option)
create or replace view emp_view30 as
select empno, ename, sal, comm, deptno from emp_copy
where deptno = 30;

select * from emp_copy;
-- 예시) 30번 부서에 소속된 사원 중에 급여가 1200 이상인 사원은 20번 부서로 이동
update emp_view30 set deptno = 20
where sal >= 1200;

create or replace view view_chk30 as
select empno, ename, sal, comm, deptno from emp_copy
where deptno = 30 with check option;

select * from view_chk30;

update view_chk30 set deptno = 20
where sal >= 600; -- error

--[11] 뷰 생성에 사용되는 다양한 옵션 (with read option)
create table emp_copy30 as
select * from emp;

create or replace view view_read30 as
select empno, ename, sal, comm, deptno from emp_copy30
where deptno = 30 with read only;

select * from view_read30;

update view_read30
set comm = 2000; -- error

--[12] Top 쿼리
select rownum, empno, ename, sal from emp;

select rownum, empno, ename, sal from emp
order by sal;

create or replace view view_sal as
select empno, ename, sal from emp
order by sal;

select rownum, empno, ename, sal from view_sal;

-- (1) rownum 이용
select rownum, empno, ename, sal from view_sal
where rownum <= 5;

-- (2) inline view 이용
select rownum, empno, ename, sal from(
select empno, ename, sal from emp
order by sal)
where rownum <= 10;

--[문제] 3 ~ 7 사이의 범위에 들어오는 사원 정보를 출력
select rownum, rnum, empno, ename, sal from(
select rownum rnum, empno, ename, sal from (
select * from emp order by sal)
)
where rnum between 3 and 7;

--[문제] 사원 중에서 급여를 가장 많이 받는 사원 7명만을 출력 (인라인 뷰)
select rownum, empno, ename, sal from (
select * from emp order by sal desc)
where rownum <= 7;

--[문제] 입사일자를 기준으로 내림차순 정렬, 5와 10사이의 사원
select rnum 순위, empno, ename, sal, hiredate from(
select rownum rnum, empno, ename, sal, hiredate from (
select * from emp order by hiredate desc)
)
where rnum between 5 and 10;

