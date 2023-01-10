/*---- 오라클 sql문 : 테이블 생성 / 수정 / 삭제 ----*/
-- [1] 테이블 생성 : create table문
create table exam01(
exno number(2),
exname varchar2(20),
exsal number(7,2));

-- [2] 기존 테이블과 동일하게 테이블 만들기
create table exam02 as select * from emp;

-- [3] 기존 테이블에서 새로운 컬럼 추가 : alter문(필드추가)
alter table exam01 add (
    exjob varchar2(10));
    
-- [4] 테이블 구조 수정 : 필드 수정
alter table exam01 modify (
    exjob varchar2(20));

-- [5] 테이블 구조 수정 : 필드 삭제
alter table exam01 drop column exjob;

-- [6] 테이블 수정 : 이름 변경
alter table exam01 rename to test01;
rename test01 to exam01;

-- [7] 테이블 삭제
drop table exam01;
drop table exam01 purge;
drop table exam02 purge;

show recyclebin;
purge recyclebin;

-- [8] 테이블 내의 모든 데이터(레코드) 삭제
truncate table exam02;
