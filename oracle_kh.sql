--============================================
--kh계정
--============================================
show user;

--table sample 생성
create table sample(
id number
);
--권한이 없기 떄문에 오류가난다. 
--01031. 00000 -  "insufficient privileges"
--===부적절한 권한이라는 뜻이다. =>create table이라는 권한필요
--즉 테이블 만들기에대한 권한이없어서 생성불가하다는뜻이다.

grant connect to kh;

select * from tab;

--사원 테이블 
select *from employee;

--부서 테이블
select *FROM department;

--직급 테이블

SELECT*FROM job;

--지역 테이블
SELECT
    *
FROM location;
--국가테이블
SELECT
    *
FROM nation;
-급여등급 테이블
select * FROM sal_grade;

--표 TABLE ,ENTITY,RELATION 데이터를 보관하는 객체
--열 COLUMN, FIELD, ATTRIBUTE 세로 ,데이터가 담길형식
--행 ROW ,RECORD ,TUPLE 가로 ,실제 데이터
--도메인 DOMAIN 하나의 컬럼에 취할수 있는 값의 그룹 범위

--테이블 명세
describe employee;
desc employee; --(desc describe의 약어다)

--컬럼명   널여부    유형  (자료형) 
--컬럼명 :대소문자구분은없다 언더스코어를 통해서 단어를 구분한다.
--널여부 : NOT NULL 널일수없다 반듯이 값이있어야된다.
--           (빈칸=NULL)   값이없어도된다.
--자료형 : 각타입의 유형이 나뉘어있다.(문자,숫자,날짜로분류되있다.)
--문자(VARCHAR, CHAR ) 숫자(NUM) , 날짜(DATE)

--============================================================
--DATA TYPE (자료형) /크게 3가지
--============================================================
--1.문자형     대표적으로 VARCHAR2 | CHAR ...
--2.숫자형              NUMBER
--3.날짜 시간형          DATE
--=======>모든데이터타입은 COLUMN에(열) 지정해서 값을 제한적으로 허용하기위한것.

--------------------------------------------------------------
--문자형
--------------------------------------------------------------
--고정형 CHAR(BYTE) (최대 2000byte)
--      char(10) 'korea' 영소문자는 글자당(10byte넘는건들어갈수없다)
--                  1byte이므로 실제크기 5byte,고정형 10byte로저장
--      '안녕' 한글은 글자당 3BYTE(11GEX기준) 이므로
--      실제크기 6BYTE 고정형 10BYTE저장됨.

--가변형 VARCHAR2(BYTE)(최대 4000byte)
-- varchar2(10byte) 'korea' 영소문자는 글자당(10byte넘는건들어갈수없다)
--                  1byte이므로 실제크기 5byte,가변형 6byte로저장 
--      '안녕' 한글은 글자당 3BYTE(11GEX기준) 이므로
--      실제크기 6BYTE 가변형 6BYTE저장됨.  
            --tb_datatype 테이블 생성
            
-- 가변형 long : 최대 2GB 몇글자인지는모르지만 크다.
-- LOB타입(LARGE OBJECT ) 중의 CLOB(CHARACTER LOB)는 단일컬럼
--최대 4GB까지지원 가능하다.
create table tb_datatype(
--컬럼명 데이터  자료형  같은식으로 나열.
--기본값 널여부 등 세부적으로 기입가능
a char(10),
b varchar2(10)
);

--table조회
--select * *는 모든 컬럼
                --테이블명
select *from tb_datatype;


--1행추가
insert into tb_datatype
values('hello','hello2');

--2행추가 
insert into tb_datatype
values('안녕','안녕2');
-- 가로줄이 추가되고있다.
--확인
select *from tb_datatype;

-- 에브리바디가 15바이트로 10바이트를넘어서 에러가난다.
insert into tb_datatype
values('에브리바디','안녕2');
--ORA-12899: value too large for column
--"KH"."TB_DATATYPE"."A" (actual: 15, maximum: 10)
--사용자. 테이블명    . 컬럼명    지금 사이즈  한계사이즈

--데이터가 변경(insert ,update ,delete)되는 경우, 메모리상에 먼저처리
--실제 적용안됨
--실제 데이타 베이스에 commit을통해 database에 적용해야한다.



commit;

--langthb(컬럼명): number -저장된 데이터의 실제크기를 리턴

select a ,lengthb(a),b,lengthb(b)
from tb_datatype;


--------------------------------------------------------------
--숫자형
--------------------------------------------------------------
--정수, 실수를 구분치않는다.
--NUMBER(P, S)
--P:표현가능한 전체자리수
--S:P중소수점 이하자리수를 가리킨다.

/*
예)
값: 1234.567
===============
NUMBER   1234.567 제한없이 처리가능(숫자라면)
NUMBER(7)   ==>12345만된다.  --반올림
    -7번째자리(7,0)과같다.
NUMBER(7,1)   ==>1234.6  --자동 반올림된다.
NUMBER(7,-2)  ===> 1200 --반올림  

*/

create table tb_datatype_number(
 a number,
 b number(7),
 c number(7,1),
 d number(7,2)
 );
 
 SELECT * FROM tb_datatype_number;

insert into tb_datatype_number
values('1234.567','1234.567','1234.567','1234.567');
SELECT*FROM tb_datatype_number;
insert into tb_datatype_number
values('1234.567','1234.567','1234.567','1234.567');
SELECT*FROM tb_datatype_number;

insert into tb_datatype_number
values('1234564654564.578978967','1234.567','1234.567','1234.5689897');
--지정한 크기보다 큰숫자

commit;
--들어간 값이 지워진다. ==>마지막 commit 시점이후 변경사항은 취소된다.
rollback;


--===================================================
--날짜  , 시간 형
--===================================================
--date  년원일 시분초 까지 표현가능
--timestamp 기본년원일 시부초에 밀리초와 지역대까지저장가능

create table tb_datatype_date(
a date,
b timestamp
);


select to_char(a,'yyy/mm/dd hh24:mi:ss'),b
 from tb_datatype_date;

insert into tb_datatype_date
values(sysdate,systimestamp);

--날짜형 - 날짜형 =숫자(1)<==하루

select to_char(a,'yyy/mm/dd hh24:mi:ss'), to_char
(a-1,'yyy/mm/dd hh24:mi:ss'), to_char
(a+1,'yyy/mm/dd hh24:mi:ss'),
b
 from tb_datatype_date;

insert into tb_datatype_date
values(sysdate,systimestamp);

--날짜형 +-숫자(1=하루) =날짜형
select sysdate -a
from tb_datatype_date;

--to date 문자열을 날짜형으로 변환하는 함수 
select to_date('2021/01/24')-a
from tb_datatype_date;

--dual 가상 테이블
select(sysdate+1) - sysdate
from dual;

--====================
--DQL
--====================
--DATA QUERY LANGUAGE 데이터조회(검색)을 위한언어
--SELECT
--쿼리 조회 결과를 RESULTsET이라고한다. (결과집합),0행이상을포함한다.
--FROM 절에 조회하고자 하는 테이블 명시.
--WHERE 절에의해 특정행을 FILTERING 가능
--SELECT 절에의해 컬럼 FILTERING  또는 추가가능
--ORDER BY 절에 의해서 행을 정렬할 수 있다..

/*
======================너무너무중요한부분
구조
SELECT 컬럼명 (5) =>필수
FROM 테이블명(1)   =>필수
WHERE 조건절 (2)   =>선택
GROUP BY 그룹기준컬럼(3)=>선택
HAVING  그룹조건절(4)    =>선택
ORDER BY 정렬기준 컬럼(6)=>선택
--===================너무너무중요한부분
*/
select*
from employee
where dept_code ='D9' --데이터는 대소문자 구분
order by emp_name asc; --오름차순

--문제 1 job테이블에서 job_name 컬럼정보만 출력
select *
from job;

--문제 2. department 테이블에서 모든 컬럼을 출력
select dept_id,
dept_title,
location_id
from department;
--select * 도 가능
from department;

--문제 3. employee테이블에서 이름 ,이메일 ,전화번호 ,입사일을 출력
select emp_name,
email,
phone,
hire_date
from employee ;



--문제 4. employee 테이블에서 급여가 250만원 이상인 사원의 이름과 급여를출력
select emp_name,salary
from employee 
where salary >=2500000 ;

--문제 5. employee 테이블에서 급여가 350만원 이상이면서, 직급코드가 J3인 사원의
--모든 컬럼을 조회
select *
from employee
where salary >=3500000 and job_code ='J3';
--참고, 조건문에 && 나 ||는 사용하지않는다. AND 나 OR사용가능


--문제 6.employee테이블에서 현재 근무중인 사원을 이름 오름차순으로 정렬해서 출력.

select*
from employee
where quit_yn = 'N'
order by emp_name;

--order by emp_name desc ; =>내림차순
--order by emp_name asce ; =>오름차순

--============================================================
--SELECT 
--==============================================================

--TABLE 의 존재하는 컬럼
--카상컬럼(산술연산)
--임의의 LITERAL(값)
--각컬럼은 별칭(alias)를 가질 수 있다.
--as는 생략가능
--" " 생략가능
--예외 생략불가능한 경우
--=> 별칭에 공백 , 특수문자나 숫자로시작하는경우
--쌍따옴표 필수
select emp_name as "사원명"
,phone "전화번호",
salary 급여,
salary*12 "1년급여",
123 "123",
'안녕' "인사"
from employee;


--실급여 구하기 : salary +(salary +bounus)
select emp_name,
salary,
nvl(bonus,0),
salary + (salary * nvl(bonus,0)) "실급여"
from employee;
--  NULL값과는 산술연산은 할수없다 그결과는 무조건 NULL이다.
--null%1 나머지 산술연산은 없다.
--select null+1,
--null-1,
--null*1,
--null/1
--from dual; --1행짜리 가상테이블

--nvl( col, null 값일때) null처리 함수
--col의 값이 null이 아니면 col값 리턴
--col의 값이 null이면  null을 리턴

select bonus,
nvl(bonus, 0 ) null처리후
from employee;

--distinct 중복 제거용 키워드
--select 절 에 단한번 사용가능하다.
--예)직급 코드를 중복없이 출력
select distinct job_code
--중복된값은 날라간다.

from employee;

--여러컬럼사용시 컬럼을 묶어서 보유한 값으로 취급 
select distinct job_code, dept_code
from employee;

--문자 연결 연산자 ||
-- +는 산술연산자만 가능하다.
select '안녕' ||'하세요'||1234
from dual;

select emp_name ||'('||phone||')'
from employee;

--=================================================
--WHERE절(행을 필터링하는 구)
--================================================
--테이블의 모든 행 중 결과집합에 포함될 행을 필터링한다.
--특정행에 대해 TRUE(결과집합에포함) , FALSE(결과집합에서제외) 결과를 리턴한다.

/* WHERE 절에쓸수있는 연산자
  =  같은가
 != 다른가  ^= 다른가   <>다른가  3가지가있다.
    나머지는 기존 산술연산자와동일하다.
  +아예 처음보는연산자도 존재
  --=======================================
  between....and...  범위연산
  like, not like        문자패턴연산
  is null , is not null 널여부
  in, not in        값목록에 포함여부를 물어본다.
  같은 sql만의 연산자가있다.
  and
  or 
  not도존재
--==========================================
*/
--==사용해본다.
select*
from employee
where dept_code!='D6';

--급여가 2000000 원보다 많은 사원 조회
select emp_name,salary
from employee
where salary > 2000000;

--부서코드가 D6이거나 D9인 사원조회
select emp_name,dept_code
from employee
where dept_code ='D6' or dept_code ='D9';

--날짜형 비교가능
--과거가 작다
select emp_name, hire_date
from employee
where hire_date <'2000/01/01'; --날짜형식의 문자열은 자동으로 날짜형으로 형변환

--20년이상 근무한 사원 조회 :
--날짜형 -날짜형 =숫자(1=하루)
--날짜형-숫자(1=하루)=날짜형

select emp_name , hire_date ,quit_yn

from employee
where  quit_yn='N'
and to_date('2021/01/22')-hire_date>365*20;

--범위 연산
--급여가 200만원 이상 400만원 이하인 사원 조회(사원명, 급여)
select emp_name,
salary
from employee
--where  salary >=2000000 and salary<=4000000;

select emp_name,
salary
from employee
where salary  between 2000000 and 4000000; 
--포함 이상 이하 관계

--입사일이 1990/01/01 ~2001/01/01 인 사원조회(사원명,입사일)
select emp_name,hire_date
from employee
where quit_yn='N'and
hire_date >= '1990/01/01' and hire_date <='2001/01/01';

--like , not like
--문자열 패턴 비교 연산

--wildcard:패턴의미를 가지는 특수문자 로 두가지가있다.
--_  => 아무문자 한글짜
--%  => 아무문자 0개이상
select emp_name
from employee
where emp_name like '전%' ; --전으로 시작하는 문자가 존재하는가
--전씨로시작하는건다가능하지만 전이뒤로오는건안된다 파전(x)

select emp_name
from employee
where emp_name like '전__' ; --_두개  전으로시작 , 2개의 문자가 존재하는가
--전형동 전전전 , (ㅇ)
--전,전진,파전,전당포아저씨(x)

--이름에가운데 글자가 '옹' 인 사원 조회
select emp_name
from employee
where emp_name like'_옹_';

--이름에 '이'rk emfdjrksms tkdnjswhghl
select emp_name
from employee
where emp_name like'%이%';

--email 컬럼값의 '_'이전 글자가 3글자인 이메일을 조회
select email
from employee
--where email like'___%'; --4글자 이후 0개이상의 문자열이 뒤따르는가를검사한것이다.
-->escape 문자로 해야된다.
where email like '___\_%' escape'\'; --어떤글짜 3글자가나오고 언더스코어가잇는가.
--임의의 escape문자를 등록가능 하지만 데이터값안의 존재하지않는 기호로사용할것
select emp_name , dept_code
from employee
where dept_code ='D6' or dept_code ='D8';

select emp_name , dept_code
from employee       --이안에 갯수제한없이 원하는만큼사용가능
where dept_code in ('D6','D8','D1');

select emp_name , dept_code
from employee       --이안에 갯수제한없이 원하는만큼사용가능
where dept_code NOT in ('D6','D8','D1');
                --NOT IN  을하면 해당값이없는 사람을 추출
                
select emp_name , dept_code
from employee       
where dept_code !='D6' AND dept_code !='D8';

--인턴 사원 조회
select emp_name, dept_code
from employee
where dept_code =null;
--null 값은 산술연산 비교연산 모두불가
--null은 is not null , in null :전용 비교연산자가있다.
select emp_name, dept_code
from employee
where dept_code is null;

--D6, D8 부서원이 아닌사원 조회 (인턴사원 포함)
select emp_name, dept_code
from employee
where dept_code not in('D6','D8') or  dept_code is null;

--nvl버전 
select emp_name , nvl(dept_code,'인턴')dept_code
from employee
where nvl(dept_code, 'D0') not in('D6','D8');

--============================================================
--ORDER BY
--==============================================================
--SELECT구문 중 가장 마지막에 처리
--지정한 컬럼 기준으로 결과집합을 정렬해서 보여준다.
--NUMBER 0<10
--STRING 사전등재순 ㄱ<ㅎ 혹은 A<Z
--DATE 과거<미래 
--null 값 위치를 결정가능 :nulss first or  nulls last
--asc 오름차순(기본값)
--desc내림차순
--복수개의 컬럼을 차례로 정렬할수 있다.

SELECT *
FROM employee
order by emp_id asc; --desc; 는내림차순이다.

select emp_id , emp_name , dept_code ,job_code, hire_date
from employee
order by dept_code , emp_name;

--alias 사용가능
select emp_id 사번,
emp_name 사원명
from employee
order by 사원명;
--1부터 시작하는 컬럼순서 사용가능.
select*
from employee
order by 9 desc;--(컬럼순서를 왼쪽부터 1~이런식으로 매겨진다 해당번수의컬럼을선택가능)
                        --그러나 그렇게 크게 추천하는방식은아니다.
                            --selec의 컬럼수가 달라지면 9번째자리의 값이바뀌기떄문이다.
 
 --=====================================================================
 --BUILT -IN FUNCTION
 --===============================================================
 --일련의 실행 코드 작성해두고 호출해서 사용함.
 --반드시 하나의 리턴값을 가짐.
 --1.단일행 함수 :각행마다 반복호출되어서 호출된 수만큼 결과를 리턴함.
 -- A.문자처리함수
 -- B.숫자처리함수
 -- C.날짜처리함수
 -- D.형변환 함수
 -- E. 기타함수
 
 --2.그룹함수 :여러행을 그룹핑한후, 그룹당 하나의 결과를 리턴한다.
 
 
--=============================================================================
--A.문자처리 함수
--==============================================================================
SELECT EMP_NAME ,email
FROM EMPLOYEE
where length(email)<15;

--lengthb(col)
--값의 byte수 리턴
select emp_name , lengthb(emp_name),
email,lengthb(email)
from employee;

        --문자열--찾을것 --STARTPOTITION시작지점, OCCURENCE발생횟수.
--instr(STRING,SEARCH,[POSITION,[OCCURENCE] ])
--STRING 에서 SEARCH 가 위치한 INDEX 를 반환.
--STARTPOSITION 검색시작위치
--OCCURENCE 출현순서
--ORACLE 에서는 1-BASED INDEX. 1부터 시작한다.
SELECT INSTR('KH정보교육원 국가정보원 정보문화사','정보'),--3
INSTR('KH정보교육원 국가정보원 정보문화사','안녕'),--0값 없음
INSTR('KH정보교육원 국가정보원 ','정보',5),--11
INSTR('KH정보교육원 국가정보원 정보문화사 ','정보',1,3), --15
INSTR('KH정보교육원 국가정보원 정보문화사 ','정보',-1) --11
                                    --11 STARTPOSITION이 음수면 뒤에서부터검색
FROM DUAL;

--email 컬럼값중 '@' 의 위치는 ?(이메일,위치인덱스)
select email, instr(email,'@')
from employee;

                --STARTINDEX
--substr(STRING ,POSITION  ,[ LENGTH] )
--STRING 에서 STARTINDEX부터 LENGTH갯수만큼 짤라내어 리턴하는녀석
--LENGTH 생략시에는 문자열 끝까지 반환한다.
                            --문자열의 6번지를 2글자만큼 출력
SELECT SUBSTR('SHOW ME THE MONEY' , 6, 2)
FROM DUAL;

SELECT SUBSTR('SHOW ME THE MONEY' , 6)--ME THE MONEY --마지막인자 생략시끝까지가져옴
FROM DUAL;

SELECT SUBSTR('SHOW ME THE MONEY' ,-5,3)--음수지정가능 뒤에서부터 5번째 3글짜리턴
FROM DUAL;


--한번에 여러 컬럼 생성가능
SELECT SUBSTR('SHOW ME THE MONEY' , 6, 2),
SUBSTR('SHOW ME THE MONEY' , 6),
SUBSTR('SHOW ME THE MONEY' , 6, 2)
FROM DUAL;

--실습문제 @: 사원명에서 성만 중복없이 사전순으로 출력
SELECT distinct substr(emp_name ,1,1) 성
from employee
--order by substr(emp_name,1,1) asc; 도가능
--order by 1; 도가능
--order by 1; 도가능
order by 성;


--lpad or rpad 사용법이유사하다 
--          byte수의 공간에 스트링을 대입하고 남은공간에 padding_char로채워라.            
--rpad(string, byte [, padding_char])
--rpad lpad는 패딩차를 왼쪽 오른쪽에 채우는것을나누는것이다.
--실습문제 @: padding char는 생략시 공백문자가 대입된다.

--실습
select lpad(email,20,'#')
from employee;
select rpad(email,20,'#')
from employee;
select lpad(email,20),'[',lpad(email,20,'#'),']','[',rpad(email,20,'#'),']'
from employee;

-- 실습문제:남자사원만 사번, 사원명, 주민번호 , 연봉 , 조회
--주민번호 뒤 6자리는 ******숨김처리할것.
select 
emp_id,
emp_name,
--substr(emp_no,1,8) ||'*****'emp_no,  이렇게도가능 아래처럼도가능
 rpad(substr(emp_no,1,8),14,'*') emp_no,
(salary+(salary*nvl(bonus,0)))*12 annul_pay
from employee
where substr(emp_no,8,1) in('1','3');



--========================================================
--B.숫자처리 함수
--========================================================

--MOD(피젯수, 젯수) 나머지함수
--나머지 함수 %가존재하지않는다.,==>모드 함수를 이용한다.
--         10나누기2 의 나머지
SELECT MOD(10,2),
MOD(10,3),
MOD(10,4)
FROM DUAL;

--입사년도가 짝수인 사원조회
select emp_name,
    extract(year from hire_date) year --날짜함수: 년도추출
    from employee
    where mod(extract(year from hire_date),2)=0
    order by year;
    
--ceil(number)
--소수점 기준으로 올림
select ceil(123.456),
ceil(123.456*100)/100 --역시 부동소수점방식이다.
from dual;


--floor(number)
--서수점 기준으로 버림
select floor(456.789),
        floor(456.789*10)/10
        from dual;
        
--round(number [,position])
--position 기준(기본값0, 소수점기준) 으로 반올림처리
select round(234.567),
round(234.456,2),
round(235.567,-1)
from dual;

--trunc(number [, position])
--버림 floor보다 많이쓴다.
select trunc(123.456),
trunc(123.456,2)
from dual;


--============================================================
--C.날짜처리 함수
--============================================================

--add_months(date, number)
--date기준으로 몇달 (number)전후의 날짜형을 리턴
--날짜형 + 숫자 =날짜형
--날짜형 - 날짜형 =숫자
select sysdate,
add_months(sysdate,1),
add_months(sysdate,-1),
add_months(sysdate+5,1)

from dual;

--months_between(미래,과거)
--두 날짜형의 개월수 차이를 리턴한다.

select sysdate,
        --아래는 날짜형으로 변환하는 메소드이다.
       trunc(months_between(to_date('2021/07/08'),sysdate),1) diff
       from dual;
       
--문제 
--이름,입사일,근무개월수(n개월),근무개월수(n년m개월) 조회
select emp_name,
        hire_date,
        trunc(months_between(sysdate,hire_date))||'개월' 근무개월수,
--        trunc(months_between(sysdate,hire_date)/12) ||'몇년',
--        mod(months_between(sysdate,hire_date),12) || '개월',
        trunc(mod(months_between(sysdate,hire_date),12)) || '개월' 근무개월수

from employee;

--extract(year |month |day|hour|minute|second from date): number
--날짜형 데이터에서 특정필드만 숫자형으로 리턴.

select extract(year from sysdate)yyyy,
        extract(month from sysdate)mm,--1부터 12
        extract(day from sysdate)dd,
        -- 시분초는 방법이다르다.
--        extract(hour fro sysdate) hh 안된다.
        extract(hour from cast(sysdate as timestamp))hh,
        extract(minute from cast(sysdate as timestamp))mm,
        extract(second from cast(sysdate as timestamp))ss

from dual;

--trunc(date)
--시분초 정보를 제외한 년월일 정보만 리턴
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') date1,
        to_char(trunc(sysdate), 'yyyy/mm/dd hh24:mi:ss') date1
from dual;

--===========================================================================
-- D.형변환 함수
--===========================================================================

/*
    TO_CHAR         TO_DATE
    --------->   ------------>
NUMBER      STRING          DATE
    <--------     <---------
    TO_NUMBER       TO_CHAR
*/
--TO_CHAR(DATE |NUMBER[,FORMAT])
select to_char(sysdate,'yyyy/mm/dd(dy) hh:mi:ss am')now,
        to_char(sysdate,'fmyyyy/mm/dd(dy) hh:mi:ss am')now,--형식문자로인한 앞글자0
        --을제거
--        to_char(sysdate,'yyyy년/mm월/dd일')now
        --이처럼하고싶을떄는 방법이다로있다.
        to_char(sysdate, 'yyyy"년" mm"월" dd"일" ') now
from dual;

select to_char(1234567,'fmL9,999,999,999')won,  --L은 지역화폐
        to_char(1234567,'fmL9,999')won,    --자리수가 모잘라서 오류
        to_char(123.4 , '999.99'), --9는 소수점 이상의 빈자리는공란 ,소수점이하빈자리는
        --                              -0처리
        to_char(123.4 , '0000.00') --빈자리는 모두 0처리.
from dual;

--이름 , 급여(3자리 콤마), 입사일( 1990-9-3(화))을조회

select emp_name,
       to_char(salary,'fml9,999,999,999,999') salary,
       to_char(hire_date,'fmyyyy-mm-dd(dy)')hire_date
from employee;

--to_number(string, format)
select 
to_number( '1,234,567' , '9,999,999') +100,
to_number('￦3,000' , 'L9,999')+100
--    '1,234,567'+100 -- 우리가보기엔숫자지만 오라클이보기엔 문자열이다.
from dual;  

--자동형변환 지원
select '1000'+100,
        '99'+'1',
        '99'||'1'
from dual;        
    
--to_date(string, format)
select to_date('2020/09/09' , 'yyyy/mm/dd')
from dual;

--'2021/07/08 21:50:00 '를 2시간후의 날짜정보를 yyy/mm/dd hh24:mi :ss형식으로출력
select to_char(to_date('2021/ 07/08 21:50:00', 
       'yyyy/mm/dd hh24:mi:ss') +  (2 / 24), 
 'yyyy/mm/dd hh24:mi:ss') result

from dual;

--현재시간 기준 1일 2시간 3분 4초후의 날짜 정보를 yyyy/mm/dd hh24:mi:ss형식으로출력
--1시간:1/24
--1분:1/24*60
--1초는:1/(24*60*60)


select to_char(sysdate + 1 + (2 / 24) + (3 / (24 * 60))
                       + (4 / (24 * 60 * 60)), 
                       'yyyy-mm-dd hh24:mi:ss') result
from dual;

--기간타입
--interval year to month :년월 기간
--interval date to second :일시분초 기간

--1년 2개월 3일 4시간 5분 6초후 조회
select to_char(add_months(sysdate,14)+3+(4/24)+(5/24/60)+(6/24/60/60),
'yyyy/mm/dd hh24: mi :ss'
) result
from dual;

                --year month interval
select to_char(sysdate +to_yminterval('01-02'),
'yyyy/mm/dd hh24:mi:ss')
result
from dual;


select to_char(
sysdate +to_yminterval('01-02')+to_dsinterval('3  04:05:06'),
'yyyy/mm/dd hh24:mi:ss')
result
from dual;

--numtodsinterval(diff,unit)
--numtoyminterval(diff,unit)
--diff :날짜차이
--unit : year |month |day |hour |minute| second

select numtodsinterval( to_date('20210708','yyyymmdd')-sysdate,
'day')
from dual;

--null처리함수
--nvl(col,nullvalue)
--nvl2(col,notnullvalue,nullvalue)
--col값이 null 이 아니면 두번째인자를 리턴, null이면 세번째인자를 리턴
select emp_name,
bonus,
nvl(bonus,0) nvl1,
nvl2(bonus,'있음','없음')nvl2
from employee;

--선택함수1 
--decode(expr,값1,결과값1,값2,결과값2,....[,기본값])
select emp_name,
emp_no,         
            --8번째에 1글짜를 가져온다.
decode(substr(emp_no,8,1),'1','남','2','여','3','남','4','여') gender,
decode(substr(emp_no,8,1),'1','남','3','남','여') gender
from employee;

--직급 코드에 따라서 j1-대표 , j2/j3-임원 ,나머지는 평사원으로출력(사원명,직급코드,직위)

select emp_name 사원명,
       job_code 직급코드,
       decode(job_code, 'J1','대표','J2','임원','J3','임원','평사원')
from employee;

--where 절에도 사용가능
--여사원만 조회

select emp_name ,
       emp_noselect emp_name 사원명,
       job_code 직급코드,
       decode(job_code, 'J1','대표','J2','임원','J3','임원','평사원')
from employee;

select emp_name,
emp_no,         
            --8번째에 1글짜를 가져온다.
decode(substr(emp_no,8,1),'1','남','2','여','3','남','4','여') gender,
decode(substr(emp_no,8,1),'1','남','3','남','여') gender
from employee;

select emp_name,
emp_no,         
            --8번째에 1글짜를 가져온다.
decode(substr(emp_no,8,1),'1','남','2','여','3','남','4','여') gender
from employee;

--선택함수2
--case
/*
type1(decode와유사)

case표현식
when 값1 then 결과1
when 값2 then 결과2
....
[else 기본값]
end

type2

case
    when 조건식1 then 결과1
    when 조건식2 then 결과2
    .....
    [else 기본값]
    end
*/


--type1
select emp_no,
case substr(emp_no,8,1)
        when '1' then '남'
        when '3' then '남'
        else '여'
        end gender
from employee;

--type2
select emp_no,
case
    when substr(emp_no,8,1)='1' then'남'
    when substr(emp_no,8,1)='3' then'남'
    else '여'
    end gender,
case 
    when substr(emp_no,8,1) in('1','3')then'남'
    else'여'
    end gender
from employee;


--=======================================================================
--GROUP FUNCTION
--==================================================================
--여러행을 그룹핑하고, 그룹당 하나의 결과를 리턴하는 함수
--모든 행을 하나의 그룹, 또는 GROUP  BY를 통해서 세부 그룹지정이 가능하다.

--SUM(COL)
select sum(salary)
from employee;


--그룹함수의 결과와 일반컬럼을 동시ㅣ에 조회할 수 없다.
select EMP_NAME,
sum(salary)
from employee;
--ORA-00937: not a single-group group function

                --보너스에는 널이있다.
select sum(salary),SUM(BONUS),
  sum(salary +(salary*nvl(bonus,0))) sum
  --가공된컬럼도 그룹함수가능
from employee;
--널값이 있는 컬럼은 널값이있는 컬럼 제외하고 더하기한다.

--avg(col) 
--평균
select round(avg(salary),1) avg,
    to_char(round(avg(salary),1),'FML9,999,999,999') AVG2
    
from employee;

--부서코드가 D5인 부서원의 평균급여 조회
select to_char(round(avg(salary),1),'fml9,999,999,999')avg3
from employee
where dept_code ='D5';

--남자사원의 평균 급여 조회
select  to_char(round(avg(salary),1),'fml9,999,999,999,999') avg4
from employee;
where substr(emp_no,8,1,)in('1','3');

--count(col)
--null 이 아닌 컬럼의 개수

select count(emp_id)
from employee;
--*모든 컬럼, 즉 하나의 행을 의미
select count(*),
        count(bonus)notnullc, --9 bonus 컬럼이 null이 아닌 행의 수
        count(dept_code)
from employee
where bonus is not null ;
--보너스를 받는 사원 수 조회.

--sum ()을이용하는법 =>가상코드를 만들어본다.
select sum(
        case
            when bonus is not null then 1
            when bonus is null then 0
            end
            )bonusman
from employee;

--max(col) | min(col)
--숫자, 날짜(과거에서->미래순으로커진다) , 문자(ㄱ~>ㅎ 사전등재순으로커진다)
select max(salary),min(salary),
        max(hire_date),min(hire_date)
from employee;