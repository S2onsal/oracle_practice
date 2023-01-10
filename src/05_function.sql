/* 오라클 명령어 : 내장 함수 */

-- [1] 임시 데이터 출력
select 1234*1234 from dual;

-- [2] 샘플 테이블인 dual 테이블
select * from tab;
select DUMMY  from dual;

/*---- 문자열 처리 관련 함수 ----*/
-- [3] lower() : 모든 문자를 소문자로 변환
select lower('Hong Kil Dong') as 소문자 from dual;

-- [4] upper() : 모든 문자를 대문자로 변환
select upper('Hong Kil Dong') as 대문자 from dual;

-- [5] initcap() : 첫글자만 대문자로 변환
select initcap('Hong Kil Dong') as "첫글자 대문자" from dual;

-- [6] concat() : 문자열 연결
select concat('더조은 ', '컴퓨터') from dual; 

-- [7] length() : 문자열의 길이
select length(concat('더조은 ', '컴퓨터')) from dual;

-- [8] substr() : 문자열 추출(데이터, 인덱스(1), 카운트)
select substr('홍길동 만세',1,3) from dual;
select substr('홍길동 만세',3,3) from dual;

-- [9] instr() : 문자열 시작 위치
select instr('홍길동 만세', '동') from dual;
select instr('seven', 'e') from dual;

-- [10] lpad(), rpad() : 자리 채우기
select lpad('Oracle',20,'#') from dual;
select rpad('Oracle',20,'#') from dual;

-- [11] trim() : 컬럼이나 대상 문자열에서 특정 문자가 첫번째 글자이거나 마지막 글자이면 잘라내고 남은 문자열만 반환.
select trim('a' from 'aaaOracleaaa') from dual;
select trim(' ' from '   Oracle   ') from dual;

/*---- 수식 처리 관련 함수 ----*/
-- [12] round() : 반올림(음수: 소숫점 이상 자리)
select round(12.3456,2) from dual;

select deptno, sal, round(sal, -3) from emp
where deptno = 30;

-- [13] abs() : 절대값
select abs(1-3), abs(3-1) from dual;

-- [14] floor() : 소수자리 버리기
select floor(12.3456) from dual;

-- [15] trunc() : 특정 자리 자르기
select trunc(12.3456, 3) from dual;

-- [16] mod() : 나머지
select mod(8,5) from dual;

/*---- 날짜 처리 관련 함수 ----*/
-- [17] sysdate : 날짜
select sysdate from dual;

alter session set nls_date_format='YYYY/MM/DD(DAY)HH24:MI:SS'; -- 해당 창에서만 적용

-- [18] months_between() : 개월 수 구하기
select ename, hiredate, round(months_between(sysdate,hiredate),2) as "개월 수" from emp;
select months_between(to_date('2003-01-01','yyyy-mm-dd'),to_date('2001-01-01','yyyy-mm-dd')) from dual;

-- [19] add_months() : 개월 수 더하기
select add_months(sysdate, 12) from dual;

-- [20] next_day() : 다가올 요일에 해당하는 날짜
select next_day(sysdate, 1) from dual;


select next_day(sysdate, '일') from dual;

-- [21] last_day() : 해당 달의 마지막 일 수
select last_day('2012-02-01') from dual;

-- [22] to_char() : 문자열로 반환
select to_char(sysdate, 'yy-mm-dd') from dual;

-- [23] to_date() : 날짜형(date)으로 변환
select to_date('2012/02/01','yyyy/mm/dd') from dual;

-- [24] nvl() : null인 데이터를 다른 데이터로 변경
select ename,comm,nvl(comm,0) from emp;

-- [25] decode() : switch문과 같은 기능
select ename, deptno,
decode(deptno,
10,'A',
20,'R',
30,'S',
'X') as 부서명 from emp;

-- [26] case : if ~ else if ~
select ename, deptno,
case
when deptno = 10 then 'account'
when deptno = 20 then 'research'
when deptno = 30 then 'sales'
when deptno = 40 then 'operations' end as 부서명
from emp;