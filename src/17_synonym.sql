/*---- 오라클 : 동의어 ----*/
-- synonym = 객체
SQL>sqlplus system/admin1234
SQL>create table table_systb1(
        ename varchar2(20)
    );
SQL>insert into table_systb1 values('홍길동');
SQL>insert into table_systb1 values('이순신');

-- scott 사용자에게 시스템에서 만든 테이블에 select할 권한을 부여
SQL>grant select on table_systb1 to scott;
SQL>conn scott/tiger
SQL>select * from system.table_systb1;

--[2] 동의어 생성 및 의미 파악하기
SQL>conn system/admin1234
SQL>grant create synonym to scott;

SQL>conn scott/tiger
SQL>create synonym systab for system.table_systb1;

--[3] 비공개 동의어 생성 및 의미
SQL>conn system/admin1234
SQL>create role test_role;
SQL>grant connect, resource, create synonym to test_role;
SQL>grant select on scott.dept to test_role;

-- 사용자 생성
SQL>create user tester10 identified by tiger;
SQL>create user tester11 identified by tiger;

-- 사용자에게 Role 부여
SQL>grant test_role to tester10;
SQL>grant test_role to tester11;

-- 사용자 tester10 비공개 동의어 생성
SQL>conn tester10/tiger
SQL>create synonym dept for scott.dept;
SQL>select * from dept;

-- 사용자 tester11 접속
SQL>conn tester11/tiger

-- [4] 공개 동의어 정의하기
SQL>conn system/admin1234
SQL>create public synonym pubdept for scott.dept;

-- 사용자 생성
SQL>create user tester12 identified by tiger;

-- 사용자에게 권한 부여
SQL>grant test_role to tester12;
SQL>conn tester12/tiger
SQL>select * from pubdept;

--[5] 비공개 동의어 제거하기
-- 비공개 동의어인 dept는 동의어를 소유한 사용자로 접속한 후 제거해야 함
SQL>conn tester10/tiger
SQL>drop synonym dept;
SQL>select * from dept; -- 에러확인

--[6] 공개 동의어 제거하기
SQL>conn system/admin1234
SQL>drop public synonym pubdept;