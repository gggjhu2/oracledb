--chun계정 생성
create user chun
identified by chun
default tablespace users;

--connect , resource를부여
grant connect, resource to chun;
