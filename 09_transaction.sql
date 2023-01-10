/*---- 오라클 : 트랜잭션 ----*/
--[1] 테이블 생성
create table dept01 as select * from dept;

--[2] commit
-- 두 개의 command 창을 띄워서 scott 계정으로 접속

-- command(1)에서 실행 및 데이터 확인 
delete from dept01;
select * from dept01; -- 반영 OK

-- command(2)에서 실행 및 데이터 확인
select * from dept01; -- 반영 NO

-- command(1)에서 commit 명령 실행
commit;

-- command(2)에서 데이터 확인
select * from dept01; -- 반영 OK

--[3] rollback
drop table dept01 purge;

create table dept01 as select * from dept;

-- command(1)에서 실행 및 데이터 확인 
delete from dept01;
select * from dept01; -- 반영 OK

rollback;