/*---- 오라클 : 데이터 무결성 제약 조건 ----*/

-- 컬럼 레벨 제약 조건 지정
--[1] not null 제약 조건을 설정하지 않고 테이블 생성
drop table emp01 purge;
drop table emp02 purge;
drop table emp03 purge;
drop table emp04 purge;
drop table emp05 purge;
drop table emp06 purge;
drop table emp07 purge;

create table emp01(
    empno   number(4),
    ename   varchar2(20),
    job     varchar2(20),
    deptno  number(2)
);

--[null 데이터 입력 연습]
insert into emp01 values (null, null, 'salesman', 40);

--[2] not null 제약 조건을 설정하여 테이블 생성 (null을 허용하지 않는다)
create table emp02(
    empno   number(4) not null,
    ename   varchar2(20),
    job     varchar2(20),
    deptno  number(2)
);

--[null 데이터 입력 연습]
insert into emp02 values (null, '홍길동', 'salesman', 10);
insert into emp02 values (1234, '홍길동', 'salesman', 10);

--[3]unique 제약 조건을 설정하여 테이블 생성 (중복을 허용하지 않는다)
create table emp03(
    empno   number(4) unique,
    ename   varchar2(20),
    job     varchar2(20),
    deptno  number(2)
);

insert into emp03 values (1234, '홍길동', 'salesman', 10);
insert into emp03 values (1234, '이몽룡', 'manager', 30);
insert into emp03 values (null, '성춘향', 'research', 20);
insert into emp03 values (null, '이순신', 'accounting', 10);

--[4] 컬럼 레벨로 조건명 명시하기 -> not null & unique 제약 조건 / 오류에 대한 가독성 up
-- 사용자가 제약 조건명을 지정하지 않고, 제약 조건만을 명시할 경우 오라클 서버가 자동으로 제약 조건명 부여
-- 오라클이 부여하는 제약 조건명은 sys_ 다음에 숫자를 나열한다.
-- 어떤 제약 조건을 위배했는지 알 수 없기 때문에 사용자가 의미있게 제약 조견명을 명시할 수 있도록 오라클이 제공한다.
create table emp04(
    empno   number(4) constraint emp04_empno_uk unique,
    ename   varchar2(20) constraint emp04_ename_nn not null,
    job     varchar2(20),
    deptno  number(2)
);

insert into emp04 values (1234, '홍길동', 'salesman', 10);
insert into emp04 values (1234, '이몽룡', 'manager', 30);

--[5] primary key(기본키) 제약 조건 설정하여 테이블 생성
-- not null + unique
create table emp05(
    empno   number(4) constraint emp05_empno_pk primary key,
    ename   varchar2(20) constraint emp05_ename_nn not null,
    job     varchar2(20),
    deptno  number(2)
);

insert into emp05 values (1234, '홍길동', 'salesman', 10);
insert into emp05 values (1234, '이몽룡', 'manager', 30);
insert into emp05 values (null, '이몽룡', 'manager', 30);

--[6] 참조 무결성을 위한 Foreign key (외래 키)
-- 부모 키가 도기 위한 컬럼은 반드시 부모 테이블의 기본키나 유일키로 설정되어 있어야 한다.
create table dept06(
    deptno  number(2) constraint dept06_deptno_pk primary key,
    dname   varchar2(20) constraint dept06_dname_nn not null,
    loc     varchar2(20)
);

insert into dept06 values(10, 'accounting', '경기도');
insert into dept06 values(20, 'research', '인천시');
insert into dept06 values(30, 'sales', '서울');
insert into dept06 values(40, 'managing', '세종');

create table emp06
(
    empno   number(4) constraint emp06_empno_pk primary key,
    ename   varchar2(20) constraint emp06_ename_nn not null,
    job     varchar2(20),
    deptno  number(2) constraint emp06_deptno_fk references dept06(deptno)
);

insert into emp06 values (1234, '홍길동', 'salesman', 10);
insert into emp06 values (1240, '이몽룡', 'manager', 50);

--[7] check 제약 조건
-- 급여 컬럼을 생성하되 값은 500 ~ 5000 사이의 값만 저장 가능
-- 성별 저장 컬럼으로 gender를 정의하고, 'M'/'F' 둘 중 하나의 값만 저장 가능

create table emp07
(
    empno   number(4) constraint emp07_empno_pk primary key,
    ename   varchar2(20) constraint emp07_ename_nn not null,
    sal     number(7,2) constraint emp07_sal_ck check(sal between 500 and 5000), 
    gender  varchar2(1) constraint emp07_gender_ck check(gender in ('M', 'F'))
);

insert into emp07 values (1234, '홍길동', 6000, 'M');
insert into emp07 values (1235, '이몽룡', 3500, 'N');

--[8] default 제약 조건 설정하기
-- 지역명 컬럼에 아무 값도 입력하지 않을 때, 디폴트값인 'SEOUL'이 입력되도록 제약 조건 설정
create table dept08(
    deptno  number(2) constraint dept08_deptno_pk primary key,
    dname   varchar2(20) constraint dept08_dname_nn not null,
    loc     varchar2(20) default 'SEOUL'
);

SELECT DATA_DEFAULT
FROM USER_TAB_COLUMNS
;

drop table dept08;

insert into dept08 values(10,'accounting','인천');
insert into dept08 (deptno, dname) values(21,'accounting');
insert into dept08 values(30,'accounting',default);

desc dept08;

select * from dept08;

--[9] 제약 조건 명시 방법
-- 1) 컬럼 레벨로 제약 조건명을 명시해서 제약 조건 설정
create table emp09
(
    empno   number(4) constraint emp09_empno_pk primary key,
    ename   varchar2(20) constraint emp09_ename_nn not null,
    sal     number(7,2) constraint emp09_sal_ck check(sal between 500 and 5000), 
    gender  varchar2(1) constraint emp09_gender_ck check(gender in ('M', 'F'))
);
-- 2) 테이블 레벨 방식으로 제약 조건 설정
-- 주의) not null 제약 조건은 테이블 레벨 방식으로 제약 조건 지정 불가
create table emp09_2(
    empno   number(4),
    ename   varchar2(20) constraint emp09_2_ename_nn not null,
    sal     number(7,2), 
    gender  varchar2(1),
    constraint emp09_2_empno_pk primary key(empno),
    constraint emp09_2_sal_ck check(sal between 500 and 5000),
    constraint emp09_2_gender_ck check(gender in ('M', 'F'))
);

create table emp09_3
(
    empno   number(4),
    ename   varchar2(20) constraint emp09_3_ename_nn not null,
    job     varchar2(20),
    deptno  number(2),
    constraint emp09_3_empno_pk primary key(empno),
    constraint emp09_3_deptno_fk foreign key(deptno) references dept06(deptno)
);

-- * USER_CONSTRAINTS 데이터 딕셔너리 뷰
-- : 제약 조건에 관한 정보를 알려줌
select CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
from user_constraints;

--[10] 제약 조건 추가하기
create table emp10
(
    empno   number(4),
    ename   varchar2(20),
    job     varchar2(20),
    deptno  number(2)
);

alter table emp10 add constraint emp10_empno_pk primary key(empno);
alter table emp10 add constraint emp10_depno_fk foreign key(deptno) references dept06(deptno);

--[11] not null 제약 조건 추가하기
alter table emp10 modify ename constraint emp10_ename_nn not null;

--[12] 제약 조건 제거하기
alter table emp10 drop primary key;

--[13] 제약 조건(외래키) 컬럼 삭제
delete from dept06;
-- 1) 제약 조건의 비활성화
alter table emp06 disable constraint emp06_deptno_fk;
 
-- 2) cascade 옵션
alter table dept06 disable primary key cascade;