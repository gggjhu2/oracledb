--============================================
--kh계정
--============================================
show user;

--sql문은 대소문자를 구분하지않는다.
--사용자 계정의 비밀번호,테이블내의 데이터는 대소문자를 구분한다.



--table sample 생성
create table sample(
id number
);
--권한이 없기 떄문에 오류가난다. 
                --부적절한       권한
--01031. 00000 -  "insufficient privileges"
--===부적절한 권한이라는 뜻이다. =>create table이라는 권한필요
--즉 테이블 만들기에대한 권한이없어서 생성불가하다는뜻이다.

--grant connect to kh; 시스템 계정에서 kh에게 권한을줘야한다.

--현재 계정의 소유테이블 목록 조회
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

--급여등급 테이블
select * FROM sal_grade;

--표 TABLE ,ENTITY,RELATION 데이터를 보관하는 객체
                    --속성
--열 COLUMN, FIELD, ATTRIBUTE 세로 ,데이터가 담길형식 =>세로한줄
--행 ROW ,RECORD ,TUPLE 가로 ,실제 데이터  =>가로 한줄
--도메인 DOMAIN 하나의 컬럼에 취할수 있는 값의 그룹 범위

--테이블 명세
describe employee;
desc employee;
--(desc describe의 약어다)

--컬럼명   널여부    유형  (자료형) 
--컬럼명 :대소문자구분은없다 언더스코어를 통해서 단어를 구분한다.
--널여부 : NOT NULL=>(필수) 널일수없다  반듯이 값이있어야된다.
--           (빈칸=NULL)=>   값이없어도된다.
--자료형 : 각타입의 유형이 나뉘어있다.(문자,숫자,날짜로분류되있다.)
--문자(VARCHAR, CHAR ) 숫자(NUMBER) , 날짜(DATE)

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
--고정형 CHAR(BYTE) (최대 2000   byte)
--      char(10) 'korea' 영소문자는 글자당(10byte넘는건들어갈수없다)
--                  1byte이므로 실제크기 5byte,고정형 10byte로저장
--      '안녕' 한글은 글자당 3BYTE(11GEX기준) 이므로
--      실제크기 6BYTE 고정형 10BYTE저장됨.
 
--가변형 VARCHAR2(BYTE)(최대 4000byte)
-- varchar2(10byte) 'korea' 영소문자는 글자당(10byte넘는건들어갈수없다)
--                  1byte이므로 실제크기 5byte,가변형 5byte로저장 
--      '안녕' 한글은 글자당 3BYTE(11GEX기준) 이므로
--      실제크기 6BYTE 가변형 6BYTE저장됨.  
            --tb_datatype 테이블 생성
            --고정형 가변형 모두지정한 크기 이상의 값은 추가할 수 없다.
            
-- 가변형 long : 최대 2GB 몇글자인지는모르지만 크다.
-- LOB타입(LARGE OBJECT ) 중의 CLOB(CHARACTER LOB)는 단일컬럼
--최대 4GB까지지원 가능하다.


create table tb_datatype(
--컬럼명 데이터  자료형  같은식으로 나열.
--기본값 널여부 등 세부적으로 기입가능
a char(10),
b varchar2(10)
);
--한번만든테이블은 이름이같게 반복생성할수없다.


--table조회
--select * *는 모든 컬럼
                --테이블명
select * from tb_datatype;
SELECT A FROM TB_DATATYPE;
SELECT B FROM TB_DATATYPE;


--1행추가 ->행추가는 여러번 실행시 계속추가하계된다.
insert into tb_datatype
values('hello','hello33');

select *from tb_datatype;

--2행추가 
insert into tb_datatype
values('안녕','안녕23');
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
NUMBER(7)   ==>1235만된다.  --반올림
    --7번째자리(7,0)과같다.
NUMBER(7,1)   ==>1234.6  --자동 반올림된다.
NUMBER(7,-2)  ===> 1200 --반올림  

*/

create table tb_datatype_number(
 --컬럼생성
 a number,
 b number(7),
 c number(7,1),
 d number(7,2)
 );
 
 
 SELECT * FROM tb_datatype_number;

--값대입
insert into tb_datatype_number
values('1234.567','1234.567','1234.567','1234.567');
SELECT*FROM tb_datatype_number;
insert into tb_datatype_number
values('1234.567','1234.567','1234.567','1234.567');
SELECT*FROM tb_datatype_number;

insert into tb_datatype_number
values('1234564654564.578978967','1234.567','1234.567','1234.5689897');
--지정한 크기보다 큰숫자

--커밋으로 저장을한다.
commit;
--들어간 값이 지워진다. ==>마지막 commit 시점이후 변경사항은 취소된다.
rollback;


--===================================================
--날짜  , 시간 형
--===================================================
--date  년원일 시분초 까지 표현가능
--timestamp 기본년원일 시부초에 밀리초와 지역대까지저장가능

create table tb_datatype_date(
--a,b 컬럼만들기. 해당 컬럼의 이름 date, timestamp
a date,
b timestamp
);

select *from tb_Datatype_date;


--  TO_CHAR 날짜/숫자를 문자열로 표현하는방법이다.
-- A컬럼의 년원일 출력되던걸  시분초정보까지 표현
select to_char(a,'yyy/mm/dd hh24:mi:ss')투챠이용시분초 ,
b 그냥시스데이타
 from tb_datatype_date;


insert into tb_datatype_date
        --년월일만  / 년월일 시분초 까지 표현가능.
values(sysdate,systimestamp);


--날짜형 - 날짜형 =숫자(1)<==하루
select to_char(a,'yyy/mm/dd hh24:mi:ss') 투챠이용데이터타입, to_char
(a-1,'yyy/mm/dd hh24:mi:ss') 하루를뺸날짜, to_char
(a+1,'yyy/mm/dd hh24:mi:ss') 하루를더한날짜,
b
 from tb_datatype_date;

insert into tb_datatype_date
values(sysdate,systimestamp);

--날짜형 +-숫자(1=하루) =날짜형
select sysdate -a  --0.009일차이가난다.
from tb_datatype_date;

--to date 문자열을 날짜형으로 변환하는 함수 
                --이날짜 까지의 남은시간. 단위는 일이다.
select to_date('2021/02/03')-a
from tb_datatype_date;

--dual 가상 테이블
select (sysdate+1) -sysdate
from dual;

--====================
--DQL (DML 범주안에있는범주다 DML이라고 불러도된다)
--====================
--DATA QUERY LANGUAGE 데이터조회(검색)을 위한언어
--SELECT(5)
--쿼리 조회 결과를 resultset이라고한다. (결과집합),0행이상을포함한다.
--FROM 절에 조회하고자 하는 테이블 명시.(1)

--WHERE 절에의해 특정행을 FILTERING 가능(2)
--SELECT 절에의해 컬럼 FILTERING  또는 추가가능

--(3) GROUP BY
--(4) HAVING

--ORDER BY 절에 의해서 행을 정렬할 수 있다..(마지막순번6)

/*
======================너무너무중요한부분******************
구조 순서 2,3,4,5,1,6으로외우면편하다 
SELECT 컬럼명 (5)            =>필수
FROM 테이블명(1)              =>필수
WHERE 조건절 (2)             =>선택
GROUP BY 그룹기준컬럼(3)      =>선택
HAVING  그룹조건절(4)        =>선택
ORDER BY 정렬기준 컬럼(6)     =>선택
--===================너무너무중요한부분****************
*/


--=========================================================================
--첫날 실습문제 마무리
--=========================================================================
select*
from employee
where dept_code ='D9' --데이터는 대소문자 구분 ->부서코드가 D9인부서 대소문자구분
order by emp_name asc; --오름차순 ->사전등재순으로  DEASC

--문제 1 job테이블에서 job_name 컬럼정보만 출력
select *
from job;

SELECT JOB_NAME 잡네임
FROM JOB;

--문제 2. department 테이블에서 모든 컬럼을 출력
select dept_id 부서아이디,
dept_title 부서명,
location_id 지역아이디
from department;


--select * 도 가능
SELECT*
from department;


--문제 3. employee테이블에서 이름 ,이메일 ,전화번호 ,입사일을 출력
select emp_name 이름,
email 이메일,
phone 전화번호,
hire_date 입사일
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
--(참고, 조건문에 && 나 ||는 사용하지않는다. AND 나 OR사용가능)


--문제 6.employee테이블에서 현재 근무중인 사원을 이름 오름차순으로 정렬해서 출력.
SELECT QUIT_YN 퇴사유무
FROM EMPLOYEE
;
-->  웨어 오더바이로 조건을걸어준다.
select*
from employee
where quit_yn = 'N'  -->n인사원중에
order by emp_name;   -->이름순으로 정렬

--order by emp_name desc ; =>내림차순
--order by emp_name asce ; =>오름차순

--=========================================================================
--첫날 실습문제 마무리
--=========================================================================



--============================================================
--SELECT 
--==============================================================
--select 에쓸수잇는것들.
--TABLE 의 존재하는 컬럼
--카상컬럼(산술연산)
--임의의 LITERAL(값)
--각컬럼은 별칭(alias)를 가질 수 있다.
--alias는 생략가능 "alias" , alias 로사용가능
--" " 생략가능
--예외 생략불가능한 경우
--=> 별칭에 공백 , 특수문자나 숫자로시작하는경우
--쌍따옴표 필수
            -->as생략가능 " " 생략가능
select emp_name as "사원명"
,phone "전화번호",
salary 급여,
salary*12 "1년급여",
--임의의 값 임의의 컬럼이름 자유롭게 가능
123 "123",
'안녕' "인사",
'임의의값' 임의값별칭
--숫자로시작하는 컬럼명은 ""를씌워줘야한다.
from employee;

                                --%로되있다.
--실급여 구하기 : salary +(salary *bounus)
select emp_name 이름,
salary 급여,
bonus 보너스,
nvl(bonus,0) nvl보너스  ,
salary + (salary *bonus) 실급여nvl없이,
            --> 널값이있는 항목은 계산이안된다.
salary + (salary * nvl(bonus,0)) "실급여"
                    -->컬럼값 bonus가 널값이면 bonus column에 0을 기입하고 column값을
                    -->리턴한다.
from employee;


--  NULL값과는 산술연산은 할수없다 그결과는 무조건 NULL이다.
--null%1 나머지 산술연산은 없다.
--select null+1,
--null-1,
--null*1,
--null/1
--from dual; --1행짜리 가상테이블


--====================NULL 처리함수 (NVL함수)=================================
--nvl( col, null 값일때) null처리 함수
--col의 값이 null이 아니면 col값 리턴
--col의 값이 null이면  null을 리턴
--=========================================================================
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
select distinct job_code 잡코드, dept_code 부서코드
from employee;



--문자 연결 연산자 ||
-- +는 산술연산자만 가능하다.
select '안녕' ||'하세요'||1234 
from dual;
select emp_name || '(' || phone || ')' || '(' || job_code ||')'
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
  between....and...             범위연산
  like, not like                문자패턴연산
  is null , is not null         널여부
  in, not in                    값목록에 포함여부를 물어본다.
  위와같이 sql만의 연산자가있다.
  and
  or 
  not도존재
--==========================================
*/
--==사용해본다.

--부서코드가 D6인 사원조회
select *
from employee
where dept_code='D6';


--dpet_cde'D6이아닌사원' 사원명 부서코드
select emp_name 이름, dept_code 부서코드
from employee
where dept_code!='D6';


--부서코드 d6아닌 사원 중복제거 오더바이로  DEPT_CODE 사전등재순으로정렬
select distinct  emp_name 이름,dept_code 부서코드
from employee
where dept_code!='D6'
order by dept_code;
--질문 디스팅스 했는데 부서 중복은 사라지지않는다 부서중복을사라지게하려면?

--부서코드가 D6인사원 사전등재순 정렬
select distinct emp_name 이름, dept_code 부서코드
from employee
where dept_code='D6'
order by dept_code;

--급여가 2000000 원보다 많은 사원 조회
select emp_name,salary
from employee
where salary > 2000000
--급여 내림차순으로정렬 큰것부터나온다.
ORDER BY SALARY DESC;

--부서코드가 D6이거나 D9인 사원조회
select emp_name,dept_code
from employee
where dept_code ='D6' or dept_code ='D9';


--날짜형 비교가능
--과거가 작다
select emp_name 이름, hire_date 입사날
from employee
            --하이어데이트가 2000/01/01 보다 이전인 사원
where hire_date < '2000/01/01'; --날짜형식의 문자열은 자동으로 날짜형으로 형변환


--20년이상 근무한 사원 조회 :
--날짜형 -날짜형 =숫자(1=하루)
--날짜형-숫자(1=하루)=날짜형

select emp_name 존함 , hire_date 입사일 ,quit_yn 퇴사유무
from employee
            --퇴사하지않은사람이면서 근무기간이 365*20<==20년보다 큰 사람
where  quit_yn='N' and to_date ('2021/01/22') - hire_date > 365*20;


--범위 연산
--급여가 200만원 이상 400만원 이하인 사원 조회(사원명, 급여)
select emp_name 이름,
salary 급여
from employee
where  salary >=2000000 and salary<=4000000; --<-이렇게도된다


select emp_name 이름,
salary 급여200이상400이하
from employee
where salary  between 2000000 and 4000000
ORDER BY SALARY DESC;
--포함 이상 이하 관계 (200만원도 해당 400만원도해당)



--입사일이 1990/01/01 ~2001/01/01 인 사원조회(사원명,입사일)
select emp_name 이름,hire_date 입사일
from employee
            --재직중
where quit_yn='N'and hire_date >= '1990/01/01' and hire_date <'2001/01/01'
ORDER BY HIRE_DATE;


--============================================================================
--like , not like
--문자열 패턴 비교 연산

--wildcard:패턴의미를 가지는 특수문자 로 두가지가있다.
-- _  => 아무문자 한글짜
-- %  => 아무문자 0개이상
select emp_name 전으로시작하는
from employee
where emp_name like '전%' ; --전으로 시작하는 문자가 존재하는가
--전씨로시작하는건다가능하지만 전이뒤로오는건안된다 파전(x)


select emp_name 전씨성
from employee
                -- 전 뒤에 _ _ 두글자가존재하는가
where emp_name like '전__' ; --_두개  전으로시작 , 2개의 문자가 존재하는가
--전형동 전전전 , (ㅇ)
--전,전진,파전,전당포아저씨(x)


--이름에가운데 글자가 '옹' 인 사원 조회 이름은 세글자
select emp_name
from employee
where emp_name like'_옹_';

--이름에 '이'가 있고 두글자가 있는가
select emp_name
from employee
--where emp_name like'%이%';
WHERE EMP_NAME LIKE '%이%';


--============================================================================
--ESCAPE 문 활용 
        --사용하고싶은 ESCAPE 문자는 우리가정의할수있다.
--============================================================================
--email 컬럼값의 '_'이전 글자가 3글자인 이메일을 조회
select email
from employee

--where email like'___%'; --4글자 이후 0개이상의 문자열이 뒤따르는가를검사한것이다.
-->escape 문자로 해야된다.
where email like '___\_%' escape'\'; --어떤글짜 3글자가나오고 언더스코어수에 0개이상의
-- 문자열이있는가.가잇는가.
--임의의 escape문자를 등록가능 하지만 데이터값안의 존재하지않는 기호로사용할것

--IN ,NOT IN 값목록에 포함여부
--부서코드가 D6 또는 D8인사원조회
SELECT EMP_NAME 이름 , DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE DEPT_CODE ='D6' OR DEPT_CODE ='D8';
-->위문장을 아래 IN NOT IN 을사용해서 표현가능하다.
select emp_name , dept_code
from employee       
                    --이안에 갯수제한없이 원하는만큼사용가능
where dept_code in ('D6','D8','D1');


select emp_name , dept_code
from employee       --이안에 갯수제한없이 원하는만큼사용가능
where dept_code NOT in ('D6','D8','D1');
                --NOT IN  을하면 해당값이없는 사람을 추출

--D6 나 D8이아닌 사원
select emp_name , dept_code
from employee       
where dept_code !='D6' AND dept_code !='D8';

-->NOT IN 을이용해서 쉽게가능하다.
SELECT EMP_NAME , DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6','D8');


--인턴 사원 조회
select emp_name, dept_code
from employee
where dept_code = null;---->null 값은 산술연산 비교연산 모두불가 결과가안나온다.
--null은 is not null , in null :전용 비교연산자가있다.
select emp_name, dept_code
from employee
where dept_code is null; -->널은 IS NULL IS NOT NULL 로만 구분가능

--D6, D8 부서원이 아닌사원 조회 (인턴사원 포함)
select emp_name, dept_code
from employee
where dept_code not in('D6','D8') or  dept_code is null;

--nvl버전 
                    --DEPT코드가 NULL이면 '인턴'값을 대입
select emp_name , nvl(dept_code,'인턴')dept_code -->보여지는부분이여기서결정되는것이다.
from employee
       --인턴사원 포함 NVL문        --D6,D8아닌사원
where nvl(dept_code, 'D0') not in('D6','D8')  -->비교하려고 NVL을 우회적으로사용.
        --만약 DEPT_CODE가 NULL 이면 'D0'을 넣어라.
            --가상커럶이다
ORDER BY DEPT_CODE;


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

--공식 문서에의하면 정렬 ORDER BY절이없으면 정확한 정렬값을보장할수없다.
--오더바이절이없어도 정렬되어보일뿐 상황에따라 값이바뀔수있다.
SELECT *
FROM employee
order by emp_id asc; --desc; 는내림차순이다.

select emp_id 사번 , emp_name 이름 , dept_code 부서명 ,job_code 직급, hire_date
from employee
        --DEPR CODE순으로 먼저 정렬하고 그다음에 EMP_NAME 을 정렬한다.
order by dept_code , emp_name ;

--급여 내림차순
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

--alias 사용가능  ORDER BY는 컬럼명말고 컬럼별칭으로도 정렬을할수있다.
select emp_id 사번,
emp_name 사원명
from employee
order by 사원명;


--1부터 시작하는 컬럼순서 사용가능.
select EMP_ID ,EMP_NAME,EMAIL
from employee
order by 1 desc;--(컬럼순서를 왼쪽부터 1~이런식으로 매겨진다 해당번수의컬럼을선택가능)
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

--LENGTH 글자수
SELECT EMP_NAME ,email
FROM EMPLOYEE
--웨어절에서도 사용가능
where length(email)<15;


--lengthb(col) 글자의 총 바이트수
--값의 byte수 리턴
select emp_name 이름 , lengthb(emp_name)이름바이트,
email 이메일,lengthb(email) 이메일바이트
from employee;

 --============================================================================
 --INSTR사용법
 --===========================================================================
 
       --문자열--찾을것 --STARTPOTITION시작지점, OCCURENCE발생횟수.
--instr(STRING,SEARCH,[POSITION,[OCCURENCE] ])
--STRING 에서 SEARCH 가 위치한 INDEX 를 반환.
--STARTPOSITION 검색시작위치
--OCCURENCE 출현순서
--ORACLE 에서는 1-BASED INDEX. 1부터 시작한다.
SELECT INSTR('KH정보교육원 국가정보원 정보문화사','정보') 정보위치,--3번째
INSTR('KH정보교육원 국가정보원 정보문화사','안녕')안녕위치,--0값 없음
            --정보를 5번쨰인덱스부터 찾아서 정보가 나오는 첫글자인덱스값이 11이다.
INSTR('KH정보교육원 국가정보원 ','정보',5) 다섯글후정보위치,--11
            --1번지부터 정보를검색하지만 정보 정보 정보 를 찾아줘
INSTR('KH정보교육원 국가정보원 정보문화사 ','정보',1,3) 정보3번쨰, --15
            -- 마이너스는 뒤에서부터찾는다.
INSTR('KH정보교육원 국가정보원 정보문화사 ','정보',-1) 정보뒤에서부터 --11
                                    --11 STARTPOSITION이 음수면 뒤에서부터검색
FROM DUAL;



--email 컬럼값중 '@' 의 위치는 ?(이메일,위치인덱스)
select email, instr(email,'@')
from employee
ORDER BY instr(email,'@');



--=======================================================================
--SUBSTR사용법
--========================================================================
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
SELECT SUBSTR('SHOW ME THE MONEY' , 6, 2) 섭스트1,
SUBSTR('SHOW ME THE MONEY' , 6)섭스트2,
SUBSTR('SHOW ME THE MONEY' , 6, 2)섭스트3
FROM DUAL;



--실습문제 @: 사원명에서 성(1글자성)만 중복없이 사전순으로 출력
SELECT distinct substr(emp_name ,1,1) 성
from employee
--order by substr(emp_name,1,1) asc; 도가능
--order by 1; 도가능
--order by 1; 도가능
order by 성;

--===========================================================================
--  LPAD RPAD 사용법
--==========================================================================
--lpad or rpad 사용법이유사하다 
--          byte수의 공간에 스트링을 대입하고 남은공간에 padding_char로채워라.            
--rpad(string, byte [, padding_char])
--rpad lpad는 패딩차를 왼쪽 오른쪽에 채우는것을나누는것이다.
--실습문제 @: padding char는 생략시 공백문자가 대입된다.

--실습
                --20바이트다.
select lpad(email,20,'#')
from employee;
select rpad(email,20,'#')
from employee;
select lpad(email,20) 패딩문자없음,'[',lpad(email,20,'#'),']','[',rpad(email,20,'#'),']'
from employee;


-- 실습문제:남자사원만 사번, 사원명, 주민번호 , 연봉 , 조회
--주민번호 뒤 6자리는 ******숨김처리할것.
select 
emp_id 사번,
emp_name 사원명,
substr(emp_no , 1, 8) ||'******' 서브스트르주민번호,
--substr(emp_no,1,8) ||'*****'emp_no,  이렇게도가능 아래처럼도가능
rpad(substr(emp_no,1,8),14,'*') 알패드주민번호,

(salary+(salary * nvl(bonus,0)))* 12 연봉
from employee
                            --남자사원 1또는3을 걸르는 구문
Where substr(emp_no,8,1) in('1','3');



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
--소수점이전까지표현 포지션을정해주면 원하는 소수점자릿수까지 표현가능
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
add_months(sysdate,1)한달후,
add_months(sysdate,-1)한달전,
add_months(sysdate+5,1)오일한달후

from dual;

--months_between(미래,과거)
--두 날짜형의 개월수 차이를 리턴한다.
select sysdate,
        --아래는 날짜형으로 변환하는 메소드이다.
       trunc(months_between(to_date('2021/07/08'),sysdate),1) diff
      from dual;

       
--문제 
--이름,입사일,근무개월수(n개월),근무개월수(n년m개월) 조회
select emp_name 사원명,
        hire_date 입사일,
        trunc(months_between(sysdate,hire_date))||'개월' 근무개월수,
        trunc(months_between(sysdate,hire_date)/12) ||'년' 년수,
--        mod(months_between(sysdate,hire_date)*12,12) || '개월' 개월수,
        trunc(mod(months_between(sysdate,hire_date),12)) || '개월' 개월수
from employee;

        
--extract(year |month |day|hour|minute|second from date): number
--날짜형 데이터에서 특정필드만 숫자형으로 리턴.

select extract(year from sysdate)yyyy,
        extract(month from sysdate)mm,--1부터 12
        extract(day from sysdate)dd,
        -- 시분초는 방법이다르다.
--        extract(hour fro sysdate) hh 안된다.
                                            --24시기준이지만 12시간기준으로바꾸는
                                            --방법은 간단하지않아서 넘어간다.
        extract(hour from cast(sysdate as timestamp)) hh,
        extract(minute from cast(sysdate as timestamp))mm,
        extract(second from cast(sysdate as timestamp))ss
from dual;


--trunc(date)
--시분초 정보를 제외한 년월일 정보만 리턴
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') "24시간기준",
        to_char(trunc(sysdate), 'yyyy/mm/dd hh24:mi:ss') "24시간기준트렁크",
        to_char(sysdate, 'yyyy/mm/dd hh12:mi:ss') "12시간기준",
        to_char(trunc(sysdate), 'yyyy/mm/dd hh12:mi:ss') "12시간기준트렁크"
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

                        --fm 형식무낮로인한 앞글자 0을 제거
        to_char(sysdate,'fmyyyy/mm/dd(dy) hh:mi:ss am')fmnow2,
                                        
         to_char(sysdate,'fmyyyy/mm/dd(day) hh:mi:ss am')now3,
--        to_char(sysdate,'yyyy년/mm월/dd일')now
        --이처럼하고싶을떄는 방법이다로있다.
        to_char(sysdate, 'yyyy"년" mm"월" dd"일" ') now4,
          to_char(sysdate,' mm"월" dd"일" ') now4
from dual;
        
                        --fml은 지역화폐
select to_char(1234567,'fmL9,999,999,999')원화,  --L은 지역화폐
        to_char(1234567,'fmL9,999')자리수모자라는원,    --자리수가 모잘라서 오류
        to_char(123.4 , 'fm999.99'), --9는 소수점 이상의 빈자리는공란 ,소수점이하빈자리는
        --                              -0처리
        to_char(123.4 , 'fm0000.00') --빈자리는 모두 0처리. 즉0보다는9를많이쓴다.
         from dual;


--이름 , 급여(3자리 콤마), 입사일( 1990-9-3(화))을조회
select emp_name 사원명,
       to_char(salary,'fml9,999,999,999,999') 급여,
       to_char(hire_date,'yyyy-mm-dd(dy)') 입사일
from employee;

            --문자를받아서 어떤형식의문자인지를 알고 숫자형으로바꿔준다.
--to_number(string, format)
select 
            --문자열        
to_number( '1,234,567' , '9,999,999') +100 숫자로바꽈서연산,
                    --L은 지역화폐 기준이다.
to_number('￦3,000' , 'L9,999')+100 숫자로바꿔서돈연산
--    '1,234,567'+100 -- 우리가보기엔숫자지만 오라클이보기엔 문자열이다.
from dual;  

--자동형변환 지원
select '1000'+100,
        '99'+'1',
        --문자열 붙이기
        '99'||'1'
from dual;        
    
--to_date(string, format)
select to_date('2020/09/09' , 'yyyy/mm/dd'),
            --날자연산가능
to_date('2020/09/09' , 'yyyy/mm/dd')+1
from dual;

--'2021/07/08 21:50:00 '를 2시간후의 날짜정보를 yyy/mm/dd hh24:mi :ss형식으로출력
select to_char(to_date('2021/ 07/08 21:50:00', 
                                --데이트는 날짜기준이라서 24로나눈건 시간 이다.
                                --거기에 2를곱하면 2시간이나온다 그걸더하면두시간후가나온다.
                                --24시간중의 2라는뜻이다. 2시간
       'yyyy/mm/dd hh24:mi:ss') +  (2 / 24), 
 'yyyy/mm/dd hh24:mi:ss') result

from dual;

--현재시간 기준 1일 2시간 3분 4초후의 날짜 정보를 yyyy/mm/dd hh24:mi:ss형식으로출력
--1시간:1/24
--1분:1/24*60
--1초는:1/(24*60*60)

                            --2시간      --3분
select to_char(sysdate + 1 + (2 / 24) + (3 / (24 * 60))
                            --4초
                       + (4 / (24 * 60 * 60)), 
                       'yyyy-mm-dd hh24:mi:ss') result
from dual;


--기간타입
--interval year to month :년월 기간
--interval date to second :일시분초 기간

--1년 2개월 3일 4시간 5분 6초후 조회
--기존방식 으로해본다.           --1년2개월 3일  4시간 5분       6초
select to_char(add_months(sysdate,14)+3+(4/24)+(5/24/60)+(6/24/60/60),
'yyyy/mm/dd hh24: mi :ss'
) result
from dual;

--기간타입으로 바까본다
                --year month interval
select  SYSDATE 지금,
to_char(sysdate +to_yminterval('01-02') ,
'yyyy/mm/dd hh24:mi:ss') 일년2개월더하기
from dual;


select to_char( --연에서월까지             --날 에서 초까지
sysdate +to_yminterval('01-02')+to_dsinterval('3 04:05:06'),
'yyyy/mm/dd hh24:mi:ss')
result
from dual;


--numtodsinterval(diff,unit)
--numtoyminterval(diff,unit)
--diff :날짜차이
--unit : year |month |day |hour |minute| second

select numtodsinterval( to_date('20210708','yyyymmdd')-sysdate,
'day') 디에스인터벌
from dual;
--질문 => 밑에 55 06:49:56.000000 000부분을 트렁크로 안보이게처리할수없는지.


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
select emp_name 사원명,
emp_no 사원준민번호,         
            --8번째에 1글짜를 가져온다. 1이면남 2면여 3이면남 4면여
decode(substr(emp_no,8,1),'1','남','2','여','3','남','4','여') 성별1,
                        --1이면 남 3이면남 나머지는 여
decode(substr(emp_no,8,1),'1','남','3','남','여') 성별2
from employee;

--직급 코드에 따라서 j1-대표 , j2/j3-임원 ,나머지는 평사원으로출력(사원명,직급코드,직위)
select emp_name 사원명,
       job_code 직급코드,
       decode(job_code, 'J1','대표','J2','임원','J3','임원','평사원')
from employee;


--where 절에도 사용가능
--여사원만 조회
select 
       emp_name 사원명,
       job_code 직급코드,
       decode(substr(emp_no,8,1),'1','남','3','여') 성별
 from employee
where decode(substr(emp_no,8,1),'1','남','3','여') ='여';



select emp_name 사원명,
emp_no 사원주민번호,         
            --8번째에 1글짜를 가져온다.
decode(substr(emp_no,8,1),'1','남','2','여','3','남','4','여') 성별,
decode(substr(emp_no,8,1),'1','남','3','남','여') 성별나머지
from employee;

select emp_name,
emp_no,         
            --8번째에 1글짜를 가져온다.
decode(substr(emp_no,8,1),'1','남','2','여','3','남','4','여') gender
from employee;




--선택함수2
--case
/*
===========================================
type1(decode와유사)

case표현식

when 값1 then 결과1
when 값2 then 결과2
....
[else 기본값]

end
=============================================
==============================================
type2

case
    when 조건식1 then 결과1
    when 조건식2 then 결과2
    .....
    [else 기본값]
    end
================================================    
*/


--type1
select emp_no 사원명,
case substr(emp_no,8,1)
        when '1' then '남'
        when '3' then '남'
        else '여'
        end 별칭성별
from employee;

--type2
select emp_no 사원명,
case
    when substr(emp_no,8,1)='1' then'남'
    when substr(emp_no,8,1)='3' then'남'
    --위두가지가해당되지않는경우는 '여'이다.
    else '여'
    end  성별,
    
case
        --한줄로도 줄일수있다.  or도가능
    when substr(emp_no,8,1) in('1','3')then'남'
    else'여'
    end 성별케이스2,
    
    --직급 도해본다.
    --타입1방식 
    case job_code
    when 'J1' then '대표'
    when 'J2' then '임원'
    when 'J3' then '임원'
    ELSE '평사원'
    END 직급타입1,
    
    
    --타입 2방식
     --타입1방식 
    case 
    when job_code ='J1' then '대표'
    when job_code in('J2','J3') then '임원'
    else '평사원'
    END 직급타입2
from employee;



--=======================================================================
--GROUP FUNCTION
--==================================================================
--여러행을 그룹핑하고, 그룹당 하나의 결과를 리턴하는 함수
--모든 행을 하나의 그룹, 또는 GROUP  BY를 통해서 세부 그룹지정이 가능하다.

--SUM(COL)
select sum(salary)
from employee;


--그룹함수의 결과와 일반컬럼을 동시에 조회할 수 없다.
select EMP_NAME 사원명,
sum(salary) 급여합계
from employee;
--ORA-00937: not a single-group group function
--그룹함수 여러개는가능하다.
select sum(salary)총급여합계,trunc(avg(salary))총급여평균
from employee;


                --보너스에는 널이있다. null값 제외하고 누계처리
select sum(salary) 급여합계,SUM(BONUS) 보너스합계,
  sum(salary +(salary*nvl(bonus,0))) 보너스포함급여합계
  --가공된컬럼도 그룹함수가능
from employee;
--널값이 있는 컬럼은 널값이있는 컬럼 제외하고 더하기한다.


--avg(col) 
--평균
select round(avg(salary),1) avg,
                            --fml원화표시 3자리마다,을찍는다.
    to_char(round(avg(salary),1),'FML9,999,999,999') AVG2
from employee;


--부서코드가 D5인 부서원의 평균급여 조회
select to_char(round(avg(salary),1),'fml9,999,999,999')D5평균급여
from employee
            --웨어절 통해 D5부서 필터링
where dept_code ='D5';


--남자사원의 평균 급여 조회
select  to_char(round(avg(salary),1),'fml9,999,999,999,999') 남사원평균급여
from employee;
            --남사원 웨어절조건 필터링
where substr(emp_no,8,1,)in('1','3');

--count(col)
--null 이 아닌 컬럼의 개수
select emp_id
from employee;
--의 갯수만 출력
select count(emp_id)
from employee;

--*모든 컬럼, 즉 하나의 행을 의미
select count(*) 모든행,
        count(bonus) 보너스널아닌행의수, --9 bonus 컬럼이 null이 아닌 행의 수
        count(dept_code) 보너스받는사원수
from employee
where bonus is not null ;
--보너스를 받는 사원 수 조회.

--sum ()을이용하는법 =>가상코드를 만들어본다.
select sum(
        case
                    --보너스를 받는거면 1
            when bonus is not null then 1
                    --보너스 안받으면 0
            when bonus is null then 0
            end
            )보너스받는사람
from employee;


--max(col) | min(col)
--숫자, 날짜(과거에서->미래순으로커진다) , 문자(ㄱ~>ㅎ 사전등재순으로커진다)
select max(salary)최고봉급,min(salary)최저봉급,
        max(hire_date)입사일가장늦은,min(hire_date)입사일가장빠른
from employee;

--나이 추출시 주의 점
--현재년도-탄생년도+1 =>한국식나이
SELECT emp_name 사원명,
    emp_no 사원주민번호,
    substr(emp_no,1,2)년생
    from employee;
--substr(emp_no,1,2),         --이부분이문제다. 따로빼서 테스트해본다.
--extract(year from sysdate) -extract(year from to_date(substr(emp_no,1,2),'yy'))
--+1 ext,                                 --이부분 yy에대한설명
--extract(year from to_date(substr(emp_no,1,2),'yy')) extest
                                                            --rr로바까본다
--extract(year from sysdate) -extract(year from to_date(substr(emp_no,1,2),'rr'))
--+1 exrr
--rr을넣어도 에러가나올수있다.
--              yy는 현재년도 기준으로 현재세기(2000~2099)
--              rr은 1950년도 

--extract(year from sysdate)--

select 
extract(year from sysdate)-decode(substr(emp_no,8,1),'1',1900,'2',1900,200)
+substr(emp_no,1,2))+1 age
from employee;

--정리해서다시써본다
SELECT emp_name 상원명,
    emp_no 주민번호,
    extract(year from sysdate)-(decode(substr(emp_no,8,1),'1',1900,'2',1900,2000)
+substr(emp_no,1,2))+1 나이
from employee;


--============================================================================
--DQL2
--============================================================================
--group by
--------------------------------------
--지정컬럼기준으로 세부적인 그룹핑이 가능하다.
--group by 구문 없이는 전체를 하나의 그룹으로 취급한다.
--group by 절에 명시한 컬럼만 select 절에 사용가능하다.
select dept_code 그룹바이부서명, --emp_name, <=이렇게는쓸수없다. 그룹바이절에명시된 컬럼이아니기떄문이다.
sum(salary)급여합계
from employee
group by dept_code;  --일반컬럼 or가공컬럼이 전부 가능.
--부서별로 (dept_code) 코드 별로 salary값을 더한것이다


        --필요한컬럼 추출
select emp_name,dept_code, salary
from employee;

--직급별로 평균급여를 구하고싶다.
select  job_code 직급,
    trunc(avg(salary),1)평균급여1자리수까지
from employee
group by job_code
order by job_code;

--부서코드별 사원수 조회
--다양한방식으로가능
select decode(dept_code,null,'인턴',dept_code) 부서코드,count(emp_name) 사원수
from employee
group by dept_code
order by dept_code;
--      널값을  intern으로 채운다.
select nvl(dept_code,'intern') 직급코드,
    count(*) 사원수
from employee
group by dept_code;



--부서코드별 사원수 조회/ ,급여평균, 급여합계조회
select nvl(dept_code,'intern')직급코드,
       count(*) 사원수,
       
       --이렇게는 숫자만
       trunc(avg(salary))급여평균1,
       trunc(avg(salary),1)급여평균첫재짜리수,
       --아래두가지로도가능
       to_char(sum(salary),'fml9,999,999,999') 급여합계2,
       to_char(trunc(avg(salary),1),'fml9,999,999,999,0') 급여평균2
from employee
group by dept_code
order by dept_code ;

--성별인원수, 평균 급여조회
        --성별컬럼이없어서 가상의컬럼 성별이란컬럼을 만든다.
select decode(substr(emp_no,8,1),'1','남','3','남','여') 성별,
count(*) count,

--평균
to_char(trunc(avg(salary),1),'fml9,999,999,999,0')평균급여
from employee
group by decode(substr(emp_no,8,1),'1','남','3','남','여');



--직급코드 J1을 제외하고 ,입사년도별 인원수를 조회해주세요.
select extract(year from hire_date) 입사년도,
            count(*) 인원
from employee
where job_code != 'J1'
group by extract(year from hire_date)
order by 입사년도;

--
select
       extract(year from hire_date) 입사년,
        count(*)사원수
        from employee
where dept_code <> 'J1' -- ^= != <>
group by extract(year from hire_date)
order by 입사년도;

--선생님 답변
select extract(year from hire_date) 년도,
count(*) 인원수
from employee
            --<>부정연산자
where job_code <>'J1'
group by extract(year from hire_date)
order by 년도;

--두개이상의 컬럼을 그룹핑 기준으로 제시할수있다.
select nvl(dept_code,'intern'), job_code,
    count(*) 
from employee
            --부서내에 직급이어떻게되는가.
group by dept_code,job_code
order by 1,2;

--부서별 성별 인원수 조회
        --널 인턴처리
select nvl(dept_code,'인턴')부서코드,
       decode(substr(emp_no, 8, 1),'1', '남', '3', '남', '여') 성별,
       count(decode(substr(emp_no, 8, 1),'1','남','3','남', '여')) 인원
from employee
group by dept_code, 
         decode(substr(emp_no, 8, 1),'1','남','3','남', '여')
order by 1;

--=========================================================================
--HAVING (filterling 기능)
--=========================================================================
--group by 이후 조건절 ,having 단독불가.

--부서별 평균 급여가 300만원 이상인 부서만조회
select dept_code 부서코드,
        trunc(avg(salary))평균급여
from employee
group by dept_code
having avg(salary)>=3000000 --그룹바이의 조건추가
order by 1;

--직급별 인원수가 3명이상인 직급과 인원수 조회
select job_code 직급, count(*) 인원수
from employee
group by job_code
having  count(*) >=3 --직급 의 추가 조건
order by job_code;

--관리하는 사원이 2명이상인 manager의 아이디와 관리하는 사원수 조회
select emp_id 사원번호,
emp_name 사원명,
manager_id 상관번호
from employee;

select manager_id 관리번호,
count(*) 관리사원수
from employee
            --null 인 부분 제외
where manager_id is not null
group by manager_id
having count(*) >=2
order by 1;

--이렇게도가능하다.
--널처리를 해빙에넣어서도 처리가능하다.
select manager_id 관리번호,
count(*) 관리사원수
from employee
group by manager_id
            --널처리를 해빙에넣어봤다.
            --카운트는 널행을 처리하지않는다.
having count(manager_id) >=2
order by 1;


--=========================================================================
--rollup , cube(col1,cil2....컬럼나열가능) 함수소개
--=========================================================================
--group by절에 사용하는 함수
--그룹핑 결과에 대해 소계(합계)를 제공

--================롤업과 큐브의 차이===============
--rollup 지정컬럼에 대해 단방향 소계제공
--cube 지정컬럼에 대해 양방향 소계제공
--==============================================

--rollup 예제
select nvl(dept_code,'인턴') 부서,
count(*) 인원
from employee
group by dept_code; 
--이상황에서 전체 인원이 몇명인지궁금할때 사용한다.

select nvl(dept_code,'인턴') 부서,
count(*) 인원
from employee
group by rollup(dept_code); 
---->하면 인원수가 최하위에 새로운값으로 종합된다.
--부서명에 널값이뜬다.

--gouping()
--실제데이터(0) |집계데이터(1) 컬럼을 구분하는 함수
        --실제데이터랑 집계 소계데이터의 null을 구분할수없다.(nvl)
--select nvl(dept_code,'인턴') 부서,
--소계의 null을 처리하기위해 그루핑함수가필요하다.
select dept_code 부서코드,
--그루핑 함수가 0과 1을 구분한다.  집계데이터인 최하의 null은 그루핑결과1이된다.
grouping(dept_code) 집계데이터구분,
count(*) 인원
from employee
group by rollup(dept_code); 

--디코드 를이용해서 다음순서를진행해본다.
                    --0이면 nvl(dept_code,'인턴'),  1이면 합계를출력해주세요
select decode(grouping(dept_code),0,nvl(dept_code,'인턴'),1,'합계') dept_code,
--grouping(dept_code),
count(*) 인원
from employee
group by rollup(dept_code)
order by 1;


--두개이상의 컬럼을 rollup 이랑 cube에 전달하는경우가다르다.
--예제 ) 부서별 직급 코드별 인원수
select dept_code 부서,
job_code 직급,
count(*) 인원
from employee
group by dept_code,job_code
order by 1;


--rool up으로해본다.
select dept_code 부서,
job_code 직급,
count(*) 인원
from employee
        --부서코드별 소계를 각부서 밑에 출력해준다.
group by rollup(dept_code,job_code)
order by 1;


-->디코드로 널 부분을 고쳐서 가시성좋게 설정해준다.
select 
decode(grouping(dept_code),0,nvl(dept_code,'인턴'),'합계') 부서,
decode(grouping(job_code),0,job_code,'소계') 직급,
count(*) 인원
from employee
group by rollup(dept_code,job_code)
order by 1,2;
--==?>>이렇게하면 각부서별 그루핑 밑에 해당그루핑의 소계를 맨밑에 달아준다.

--cube를써본다.  -->롤업은 dept_code만 그룹핑을해서보여준다. 
                -->cube는 dept_code, job_code 양방향을다보여준다.
select decode(grouping(dept_code),0,nvl(dept_code,'인턴'), '소계') 부서,
decode(grouping(job_code),0,job_code,'소계') 직급,
count(*) 인원
from employee
group by cube(dept_code,job_code)
order by 1,2;


/*
SELECT(5)
FROM(1)
WHERE(2)
GROUP BY(3)
HAVING(4)
ORDER BY(6)

*/

--=============================================================================
--JOIN
--=============================================================================
--가로방향 합치기 JOIN 행+행
--세로방향 합치기 UNION 열+열

--두개 이상의  테이블을 연결해서 하나의 가상테이블(RELATION)을 생성
--기준컬럼을 가지고 행을 연결한다.


--송중기 사원의 부서명을 조회
select*
from employee
where emp_name ='송종기';

select dept_code 부서명 --'D9'
from employee
where emp_name = '송종기';

select dept_title--총무부
from department
where dept_id='D9';

-->임플로이 테이블에서 d9을 찾고 디파트먼트테이블에서 d9을 찾아서 총무부를 찾을수있었다.
-->임플로이 테이블과 디파트먼트테이블이 같은테이블이라면 송종기를찾아서 부서명컬럼의 부서명컬럼의
--이름을 한번에찾을수있었을것을 위한 기능이다.
--즉 두테이블을합쳐서 원하는 데이터를 편하게찾기위한 방법이다.

--join
select*from employee;
select * from department;
--위두 테이블을 합친것을 확인해볼수있따.
select  *
        --테이블별칭E          디파트먼트별칭 D
from employee E join department D
    
on E.dept_code =D.dept_id;
where E.emp_name='송종기';

select*from employee;
select * from department;
--아래두 테이블을 합친것을 확인해볼수있따.

--위의 조인 테이블을통해서 송종기 사원의 부서명을 추출해본다.
select  D.dept_title
from employee E join department D
on E.dept_code =D.dept_id
where E.emp_name='송종기';
--=============================================================================
--두테이블의 컬럼명이같을때는 반듯이 어떤테이블의 컬럼인지를명시해주어야한다
--아주중요한 에러
--============================================================================
--사원명 직급코드 잡네임 출력
select emp_name 사원명, job_code 직급코드 ,job_name 직급이름
from employee join job on employee.job_code = job.job_code;
--ORA-00918: column ambiguously(모호하다) defined 에러발생
                        --잡코드는 양쪽테이블에모두존재하기에 어떤테이블인지를명시해주어야한다.
select emp_name 사원명, employee.job_code 직급코드 ,job_name 직급이름
from employee join job on employee.job_code = job.job_code;
--원래는 이렇게쓰나 별칭을 사용하면 간편해지기에 별칭을 쓴다.
select emp_name 사원명, E.job_code 직급코드 ,job_name 직급이름
from employee E join job J on E.job_code = J.job_code;
--기준컬럼명이 좌우테이블에서 동일하다면, ON대신 USING 사용가능

select *
from employee E join job J
    --using에 사용된컬럼이 제일첫 인덱스 즉 첫번쨰로나온다.
using(job_code);
--using을 사용했다면 해당컬럼의 별칭을 사용할수없다.


--===========================================================================
--USING사용시 별칭 컬럼사용불가 사용시 에러 케이스 예제
--==========================================================================
select e.job_code
from employee E join job J
    --using에 사용된컬럼이 제일첫 인덱스 즉 첫번쨰로나온다.
using(job_code);
-->>>>using 사용시 별칭을 호출하면 에러가발생한다.
--ORA-25154: column part of USING clause cannot have qualifier




select *from employee;
SELECT*FROM job;

--==============================================================================
--join 종류
--1.EQUI -JOIN 동등 비교조건(=)에의한 조인 ==>거의대부분이 이킈조인이다.
--2.NON-EQUI JOIN   동등비교조건이아닌 (between and,in, not in, !=)조인

--join문법
--1.ANSI표준문법  :모든 DBMS공통 문법join 키워드
--2.Vendor(회사이름)별 문법 : DBMS별로 지원하는 문법, 오라클 전용 문법,(컴마)사용(포함)

--EQUI JOIN종류
/*
1. INNER JOIN 교집합

2. OUTER JOIN 합집합 
        --left outer join 좌측 테이블기준 합집합
        --right outer join 우측 테이블기준 합집합
        --full outer join 약테이블 기준 합집합
3. CROSS JOIN
        두테이블간의 조인할 수 있는 최대경우의 수를 표현

4. SELF JOIN
        같은테이블의 조인
5. MULTIPLE JOIN
        3개이상의 테이블을조인
*/

--============================================================================
--INNER JOIN
--============================================================================
/*
    A(inner) join B 교집합
    1.기준컬럼이 NULL인경우, 결과집합에서 제외.
    2.기준컬럼값이 상대테이블 에 존재하지 않는 경우, 결과집합에서 제외.
*/

select*
from employee E join department D
on E.dept_code = D.dept_id;
--두행이없다 null인행 제외

select *
from employee;
select * 
from department;
--1.employee 에서 dept_code가 null인 행 제외 :인턴사원 2행 제외
--2.department 에서 dept_id가 D3,D4,D7인행은 제외
--최종결과 22행

select*
from employee E join job J
on E.job_code =J.job_code;
--두테이블의 조건이 같다면 빠지는 행은없을수있다.

------------------------------------------------------------------------------
--OUTER JOIN
------------------------------------------------------------------------------
--1.LEFT (OUTER)<=생략가능 JOIN
--좌측테이블 기준
--좌측테이블 모든행이 포함, 우측테이블에는 ON조건절에 만족하는행만포함.
select*
from employee E left outer join department D
on E.dept_code =D.dept_id;
--결과를보면 좌측테이블의 모든 행은 추가되고 우측테이블의 없는데이터는 null로채워 제일밑에 채워
--진다.

--2.right outer join
--우측테이블기준
--우측테이블 모든행이 포함, 좌특테이블에는 on조건절에 만족하는 행만포함.
select*
from employee E right outer join department D
on E.dept_code =D.dept_id;

--임플로이에없는행은 역시 null로 채워서 출력 그래서 25행출력

--3.full outer join 잘안쓰인다.
--완전조인
--좌우 테이블 모두포함
select*
from employee E full outer join department D
on E.dept_code =D.dept_id;
--레프트할떄빠졌던 2행 라이트할떄빠졌던 3행 모두 다 들어와서 교집합할떄의 22행+2+3해서27행된다.

--사원명/부서명 조회시
--부서지정이 안된사원은 제외 :inner join
--부서지정이안된 사원도포함:left join
--사원배정이 안된 부서도 포함: right join

--==========================================================================
--CROSS JOIN  쓸데가 별로없다.
--==========================================================================
--상호조인
--ON 조건절 없이, 좌측테이블 행과 우측테이블의 행이 연결될수있는 모든경우의 수를 포함한결과집합.
--CARTESIAN'S PRODUCT
--216 행이나왔다 -24*9
select *
from employee E cross join department D;

--쓸대가별로없지만 한가지 쓸만한경우의 수를 소개해본다.
--일반컬럼, 그룹합수결과를 함계조회.
select trunc(avg(salary))
from employee;
                        --그룹합수를 같이 조회할수있게되었다.
SELECT EMP_NAME, SALARY,AVG,SALARY -AVG 평균차액
                             --쿼리문전체의 결과값을 가상테이블화할수있다.       
from employee E cross join (select trunc(avg(salary))avg from employee)A;




--============================================================================
--2021.02.03 시험
--===========================================================================
--2.	
--직원 정보가 저장된 EMP 테이블에서 각 부서(DEPT)별
--급여(SALARY)의 합계들을 구하여, 부서 급여합이 9백만을 초과하는 부서와 
--급여합계를 조회하는 SELECT 문을 작성하시오. (25점)
-- 조회한 컬럼명과 함수식에는 별칭 적용한다. (DEPT 부서명, 함수식 급여합)4
select decode(grouping(dept_code),0,nvl(dept_code,'인턴'), '소계') 부서
,count(*)
from employee
group by rollup(dept_code)
order by 1;

--
select dept_title 부서명, 급여합
from (select dept_title, sum(salary) 급여합
from employee
left join department on (dept_code = dept_id)
group by dept_title)
where 급여합 > 9000000;​

--3.	
--직원 정보를 저장한 EMP 테이블에서 사원명(ENAME)과 주민번호(ENO)를 함수를 사용하여
--아래의 요구대로 조회되도록 SELECT 구문을 기술하시오. (25점)
--
--'- 주민번호는 '891224-1******' 의 형식으로 출력되게 하시오
--
--- 조회결과에 컬럼명은 별칭 처리하시오. => ENAME 사원명, ENO 주민번호

select 
emp_name 사원명,
substr(emp_no , 1, 8) ||'******' 주민번호
from employee;

--4.	
--아래의 구문을 CASE 표현식을 사용하는 SELECT 문으로 변경하시오. (40점)
--
--- MERIT_RATING(인사고가)에 따라 BONUS(성과급)을 조회한다.
--merit_rating이 'A'라면 salary의 20%만큼 보너스를 부여한다.
--merit_rating이 'B'라면 salary의 15%만큼 보너스를 부여한다.
--merit_rating이 'C'라면 salary의 10%만큼 보너스를 부여한다.
--그 외 merit_rating값은 보너스가 없다.

select 
case merit_rating
when 'A' then bonus = 0.2
when 'B' then bonus = 0.15
when 'C' then bonus = 0.1
else bonus = 0
end
from employee;​
--이러가난다

--============================================================================
--기술시험
--============================================================================
--1. 직원테이블(EMP)이 존재한다.
--직원 테이블에서 사원명,직급코드, 보너스를 받는 사원 수를 조회하여 
--직급코드 순으로 오름차순 정렬하는 구문을 작성하였다.
--이 때 발생하는 문제점을 [원인](10점)에 기술하고, 
--이를 해결하기 위한 모든 방법과 구문을 [조치내용](30점)에 기술하시오.-
--SELECT
--EMPNAME
--, JOBCODE
--, COUNT(*) AS 사원수
--FROM
--EMP
--WHERE
--BONUS != 'NULL'
--GROUP BY JOBCODE
--ORDER BY JOBCODE;
--
----답원인
--WHERE BONUS != 'NULL' 로는 NULL인지 아닌지를 구분할 수 없다.
--왜냐하면 NULL에게는 =, + 같은 연산자를 사용할 수 없기 때문이다.
--
--
--
--EMPNAME
--
--, JOBCODE
--
--, COUNT(*) AS 사원수
--
--그룹함수의 결과와 일반 컬럼을 동시에 조회할 수 없다.
--
--
--
--GROUP BY JOB_CODE
--
--에서 EMPNAME을 표현하지 않아 오류가 난다
-------------------------------------------------------
--조치사항
--해당 테이블이 생성되어 있는지 확인한다. 
--또는 오타가 없는지 확인한다. 
--
--
--
--1. null 판단은 is not null 구문을 이용.
--
--2. window funtion 의 집계 함수를 이용.
--
--3. GROUP BY JOB_CODE를 지우거나 EMPNAME을 추가.​
--
--SELECT EMPNAME,
--
--JOBCODE,
--
--COUNT(*) OVER() 사원수
--
--FROM EMP
--
--WHERE BONUS IS NOT NULL
--
--[ GROUP BY JOB_CODE, EMPNAME ] -- 생략 가능
--
--ORDER BY JOBCODE;​

----==============
--2.직원 테이블(EMP)에서 부서 코드별 그룹을 지정하여 부서코드,
--그룹별 급여의 합계, 그룹별 급여의 평균(정수처리), 
--인원수를 조회하고 부서코드순으로 나열되어있는 코드
--아래와 같이 제시되어있다. 
--아래의 SQL구문을 평균 월급이 2800000초과하는 부서를 조회하도록 수정하려고한다.
--수정해야하는 조건을[원인](30점)에 기술하고, 
--제시된 코드에 추가하여 [조치내용](30점)에 작성하시오.(60점)
--
--SELECT
--DEPT
--, SUM(SALARY) 합계
--, FLOOR(AVG(SALARY)) 평균
--, COUNT(*) 인원수
--FROM
--EMP
--GROUP BY
--DEPT
--ORDER BY DEPT ASC;

--2번문제답
2번
-------------------------------------------------------
--원인
--평균에 관해서 조건이 필요하므로
--HAVING FLOOR(AVG(SALARY)) > 2800000 를 추가해야함​
--조치내용
--SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
--FROM EMP
--
--GROUP BY DEPT
--
--HAVING FLOOR(AVG(SALARY)) > 2800000
--
--ORDER BY DEPT ASC;​

