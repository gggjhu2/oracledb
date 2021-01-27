--===============================
--system 관리자 생성
--==================================


--한줄 주석
/* 구문주석
*/
show user;

--현재 등록된 사용자목록 조회
--sys 슈퍼 관리자   .db생성 /삭제 권한있음
--system 일반관리자  일반관리자 .db생성



select * from dba_users;

select*
FROM DBA_USERS;

--관리자는 일반 사용자를 생성할 수있다.
create user kh
IDENTIFIED by kh  --비밀번호 (대소문자구분)
default tablespace users;
--한번 만든 테이블 유저는 반복 생성불가능하다.

--사용자 삭제
--drop user kh;  

--접속 권한 create session 이 포함된 role(권한묶음) connect부여
grant connect to kh;

--테이블 등 객체 생성권한이 포함된 role resource 부여
grant RESOURCE to kh;

--위두가지는 반복되므로 한번에 할수잇다.

grant connect , RESOURCE to kh;

--role(권한묶음) 에포함된 권한 확인
--DATADICTIONARY DB 의 각 객체에 대한 메타정보를 확인할 수있는 READ-ONLY테이블
select*
from dba_sys_privs
where grantee in ('CONNECT','RESOURCE');
