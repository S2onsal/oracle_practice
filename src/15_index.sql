/*---- 오라클 : 인덱스(index) ----*/

--[1] 인덱스 정보 조회
select index_name, table_name, column_name from user_ind_columns
where table_name in ('EMP', 'DEPT');

--[2] 조회 속도 비교하기
-- 사원테이블 복사 : 주의) 데이터 복사시 테이블 구조와 내용만 복사될 뿐 제약조건은 복사 x
create table emp01_copy as select * from emp;

insert into emp01_copy select * from emp01_copy;
insert into emp01_copy(empno, ename) values(8010,'ANGEL');

set timing on

-- 인덱스 연결 x
select distinct empno, ename from emp01_copy
where ename = 'ANGEL'; --0.694

--[3] 인덱스 생성
-- 기본키나 유일키가 아닌 컬럼에 대해서 인덱스를 지정하려면 create index 사용
create index idx_emp01_copy_ename
on emp01_copy (ename);

select distinct empno, ename from emp01_copy
where ename = 'ANGEL';

--[4] 인덱스 제거
drop index idx_emp01_copy_ename;