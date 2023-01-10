/*---- 오라클 - 시퀀스(sequence)----*/
--[1] 샘플 테이블 생성
create table memos(
    num number(4) constraint memos_num_pk primary key,
    name varchar2(20) constraint memos_name_nn not null,
    postDate date default(sysdate)
);

drop table memos;

--[2] 해당 테이블의 시퀀스 생성
create sequence memos_seq start with 1 increment by 1;

--[3] 데이터 입력 : 일련번호 포함
insert into memos(num,name) values(memos_seq.nextval,'홍길동');
insert into memos(num,name) values(memos_seq.nextval,'이순신');
insert into memos values(memos_seq.nextval,'강감찬',default);
insert into memos values(memos_seq.nextval,'유관순',default);
insert into memos values(memos_seq.nextval,'장영실',default);

--[4] 현재 시퀀스가 어디까지 증가되어 있는지 확인
select memos_seq.currval from dual;

--[5] 시퀀스 수정 : 최대 증가값을 9까지 제한
alter sequence memos_seq maxValue 100;
insert into memos values(memos_seq.nextval, '안창호', default);
insert into memos values(memos_seq.nextval, '안중근', default);
insert into memos values(memos_seq.nextval, '김구', default);

--[6] 시퀀스 삭제
drop sequence memos_seq;

--[7] 시퀀스 없는 상태에서 자동 증가값 구현
select max(num) from memos;
insert into memos(num,name) values((select max(num)+1 from memos),'김정희');

select * from memos;