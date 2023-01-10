[문제1] 기본테이블은 EMP_COPY로 합니다. 20번 부서에 소속된 사원들의 사번과  이름, 부서번호와 상관의 사번을 출력하기 위한 select문을 emp_view20이라는 이름의 뷰로 정의해 보세요.
create view emp_view20 as select empno, ename, deptno from emp_copy
where deptno = 20;
select * from emp_view20;

select * from emp_view20;

[문제2] 각 부서별 최대 급여와 최소 급여를 출력하는 뷰를 sal_view 라는 이름으로 작성하세요.
create or replace view sal_view as
select max(sal) salMax, min(sal) salMin from emp_copy;
 
select * from sal_view;
 
[문제3] 인라인뷰를 이용하여 급여를 많이 받는 순서대로 3명만 출력하는 뷰(sal_top3_view)를 작성하세요.
create or replace view sal_top3_view as
select rownum empno, ename, sal from (
select * from emp_copy order by sal desc)
where rownum <= 3;

select * from sal_top3_view;

[문제4] 사원중에서 급여를 가장 많이 받는 사원 7명만을 출력하는 명령문을 인라인 뷰를 이용해서 구현해 보세요.
select rownum, empno, ename, sal from (
select * from emp order by sal desc)
where rownum <= 7;

[문제5] 입사일자를 기준으로 내림차순으로 정렬을 해서 5와 10사이의 존재하는 사원을 출력해 보세요.
select rnum 순위, empno, ename, sal, hiredate from(
select rownum rnum, empno, ename, sal, hiredate from (
select * from emp order by hiredate desc)
)
where rnum between 5 and 10;

[문제6] tjoeun/tiger 계정을 생성해서 순번/사원번호/이름/직업/근무부서(컬럼)의 항목을 갖는 테이블을 만들어서
데이터를 저장하되 순번 데이터 입력은 sequence를 이용하여 저장하고, view_acorn 뷰를 생성해서 순번/사원번호/이름만 출력할 수 있도록 만들어보세요.

create table problem6(
    idx     number(2) constraint problem6_idx_pk primary key,
    empno   number(2) constraint problem6_empno_nn not null,
    ename   varchar2(20) constraint problem6_ename_nn not null,
    job     varchar2(20),
    deptno  number(2)
);

create sequence problem6_seq start with 1 increment by 1;

insert into problem6(idx,empno,ename) values(problem6_seq.nextval,01,'홍길동');
insert into problem6(idx,empno,ename) values(problem6_seq.nextval,02,'김길동');
insert into problem6(idx,empno,ename) values(problem6_seq.nextval,03,'박길동');
insert into problem6(idx,empno,ename) values(problem6_seq.nextval,04,'최길동');
insert into problem6(idx,empno,ename) values(problem6_seq.nextval,05,'송길동');

create or replace view view_acorn as
select idx,empno,ename from problem6;

select * from view_acorn;
