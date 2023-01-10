/*---- 오라클 : 사용자(User) 권한 (Role) ----*/
--[1] 권한의 역할과 종류
-- 권한 : 시스템 권한, 객체 권한

--[2] 'thomas' 계정 생성(cmd 창에서 실행)
-- 계정 접속
SQL>sqlplus system/admin1234

-- 현재 접속 계정 확인
SQL>show user;

-- 계정 생성 
SQL>create user thomas identified by tiger;

--[3] 데이터베이스 접속 권한 부여
SQL>sqlplus system/admin124 
SQL>grant create session to thomas;

create table emp01(
    empno   number(2),
    ename   varchar2(10),
    job     varchar2(10),
    deptno  number(2)
);

--[4] 테이블 생성 권한 부여
SQL>sqlplus system/admin1234
SQL>grant create table to thomas;

--[5] 테이블 스페이스 확인
-- 테이블 스페이스는 디스크 공간을 소비하는 테이블과 뷰 그리고 그 밖의 다른 
-- 데이터베이스 객체들이 저장되는 장소
-- cf) 오라클 xe 버전의 경우 메모리 영역은 system으로 할당
--     오라클 full 버전의 경우 메모리 영역은 users로 할당
--     SQL>alter user thomas quota 2m on users (full ver)
SQL>alter user thomas quota 2m on system; -- (xe ver)

select * from tab;

-- * 계정 생성 및 테이블 생성까지의 권한 부여 정리
C:\>sqlplus system/admin1234
create user thomas identified by tiger;
grant create session to thomas;
grant create table to thomas;
alter user thomas quota 2m on system;

--[6] with admin option
-- tester1 계정 생성 및 권한 부여
C:\>sqlplus system/admin1234
create user tester1 identified by tiger;
grant create session to tester1;
grant create table to tester1;
alter user tester1 quota 2m on system;

-- tester2 계정 생성 및 권한 부여
C:\>sqlplus system/admin1234
create user tester2 identified by tiger;
grant create session to tester2 with admin option;
grant create table to tester2;
alter user tester2 quota 2m on system;

--[7] 테이블 객체에 대한 select 권한 부여(scott/emp -> thomas)
SQL>conn scott/tiger
SQL>grant select on emp to thomas;
SQL>conn thomas/tiger
select * from emp;

--[8] 스키마(SCHEMA) : 객체를 소유한 사용자명을 의미
SQL>select * from scott.emp;

--[9] 사용자에게 부여된 권한 조회
-- user_tab_privs_made
-- user_tab_privs_recd
SQL>conn thomas/tiger
SQL>select * from user_tab_privs_made
SQL>select * from user_tab_privs_recd

select * from user_tab_privs_recd;

--[10] 비밀번호 변경시
SQL>conn system/admin1234
SQL>alter user thomas identified by thomas;

--[11] 객체 권한 제어하기
SQL>conn scott/tiger
SQL>revoke select on emp from thomas;

--[12] with grant option
SQL>conn scott/tiger
SQL>grant select on emp to tester1 with grant option;

-- 새로운 커맨드 창에서 실행
SQL>sqlplus tester1/tiger
SQL>select * from scott.emp;
SQL>grant select on scott.emp to tester2;

--[13] 사용자 계정 제거
SQL>conn system/admin1234
SQL>drop user tester2;

--[14] 권한(Role)
-- 1) connect Role
-- 2) resource Role
-- 3) DBA Role
SQL>conn system/admin1234
SQL>create user tester2 identified by tiger;
SQL>grant connect, resource to tester2;
SQL>conn tester2/tiger

SQL>create table emp01(
    empno   number(2),
    ename   varchar2(10),
    job     varchar2(10),
    deptno  number(2)
);


