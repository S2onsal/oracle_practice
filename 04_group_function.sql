/* 오라클 명령어 : Group 함수 */

-- [1] sum() : 합계
select sum(sal) as "총 급여" from emp;

-- [2] count() : 카운트
select count(*) as "사원 수" from emp;

-- [3] avg() : 평균
select round(avg(sal)) as "평균 급여" from emp;

-- [4] max() : 최대값
select max(sal) as "최대 급여" from emp;

select a.ename, sal as "최대 급여" from emp a
where a.sal = (select max(sal) from emp);

-- [5] min() : 최소값
select min(sal) as "최소 급여" from emp;

select a.ename, sal as "최소 급여" from emp a
where a.sal = (select min(sal) from emp);

-- [6] Group by 절 : 직업별 급여 평균
select job, round(avg(sal)) as "직업별 급여 평균" from emp
group by job;

-- [7] Having 절 : 직업별 급여 평균(단, 급여 평균 2000이상 직업)
select job, round(avg(sal)) as "직업별 급여 평균_2" from emp
group by job
having avg(sal) >= 2000;