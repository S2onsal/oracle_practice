/*---- 오라클 sql문 : 데이터 입력 / 검색(출력) / 삭제 ----*/

-- [1] 샘플 테이블 생성
create table exam01(
    deptno  number(2),
    dname   varchar2(14),
    loc     varchar2(14)
);

-- [2] 데이터 입력(저장) : insert into ~ values()
insert into exam01 (deptno, dname, loc) values (10, '회계부', '서울');
insert into exam01 (dname, deptno, loc) values ('연구부', 20, '경기도');

-- [3] 데이터 입력 : 행 생략
insert into exam01 values (30,'영업부','인천');

-- [4] null 값 입력
insert into exam01 values(40,'관리부', null);

-- [5] 데이터 출력 : select문
select * from exam01;

-- [6] 필드의 데이터를 변경 : 부서번호 변경
update exam01 set deptno = 50
where deptno = 40;

-- [7] 급여 10% 인상 금액 반영
create table exam02 as select * from emp;

update exam02 set sal = sal * 1.1;

-- [8] 부서번호가 10인 사원의 부서번호를 20으로 변경
update exam01 set deptno = 20
where deptno = 10;

-- [9] 급여가 3000 이상인 사원만 급여를 10% 인상
update exam02 set sal = sal * 1.1
where sal <= 10000;

-- [10] 사원 이름이 scott인 자료의 부서번호를 10, 직급을 MANAGER로 변경
update exam02 set deptno = 10, job = 'MANAGER'
where ename = 'SCOTT';

-- [11] 30번 부서 사원을 삭제
delete exam02 where deptno = 30;
delete from exam02 where deptno = 30;

-- [12] 사원을 전체 삭제
delete exam02;
delete from exam02;