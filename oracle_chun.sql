--=============
--CHUN계정 과제실습 
--=============
--학과 테이블
SELECT * FROM tb_department;
--학생테이블
select * from tb_student;
--과목 테이블
select * from tb_class;

--교수 테이블

select *from tb_professor;

--교수 과목 테이블
select * from tb_class_professor;

--점수 등급
select *from tb_grade;


--===========================================================
--실습문제 풀기--
--===========================================================
--1. 학과테이블에서 계열별 정원의 평균을 조회(정원 내림차순 정렬)
select category 계열, trunc(avg(capacity)) "정원의 평균"
from tb_department
group by category
order by "정원의 평균" desc;

--2. 휴학생을 제외하고, 학과별로 학생수를 조회(학과별 인원수 내림차순)
select department_no 학과번호, count(*) 학생수
from tb_student
where absence_yn != 'Y'
group by department_no
order by 학생수 desc;

--3. 과목별 지정된 교수가 2명이상이 과목번호와 교수인원수를 조회
select class_no 과목번호, count(professor_no) 교수인원수
from tb_class_professor
group by class_no
having count(professor_no)>=2;

--4. 학과별로 과목을 구분했을때, 과목구분이 "전공선택"에 한하여 
--과목수가 10개 이상인 행의 학과번호, 과목구분(class_type), 과목수를 조회(전공선택만 조회)
select department_no,
        class_type,
        count(department_no) 과목수
from tb_class
where class_type like '전공선택'
group by department_no, class_type
having count(department_no) >= 10
order by department_no;

--학번/학생명/담당교수명 조회
--1.두테이블의 기준컬럼파악
--2.on조건절에 해당되지 않는 데이터 파악

select * from tb_student; --coach_professor_no
select * from tb_professor; --professor_no

select*
from tb_student S join tb_professor P
on S.coach_professor_no =P.professor_no;
--담당교수가 배정되지 않은 학생이나 교수를 제외 579명
-->inner join
--담당교수가 배정되지않은 학생 포함 leftjoin
--담당학생이없는 교수도포함 rightjoin

-->inner조인 담당교수가 배정되지않은 학생이나 교수제외
select count(*)
from tb_student S join tb_professor P
on S.coach_professor_no =P.professor_no;

-->left join 담당교수가 배정되지않은 학생포함588 (579+9)
select count(*)
from tb_student S left join tb_professor P
on S.coach_professor_no =P.professor_no;

-->right join 담당학생이없는 교수 포함 580  (579+1)
select count(*)
from tb_student S right join tb_professor P
on S.coach_professor_no =P.professor_no;



--1.교수 배정을 받지 않은 학생 조회 --9명 좌측기준
select count(*)
from tb_student 
where coach_professor_no is null;

--2. 담당학생이 한명도없는 교수 우측기준
--총전제 교수 수를알아야하고
select count(*)
from tb_professor;

--중복없는 담당교수 수 113명 
select count(distinct coach_professor_no)

from tb_student ;

--실습문제
--1.학번 학생명 학과명 조회
--학과 지정이안된 학생은 존재하지 않는다.
--이부분 확인과정
SELECT COUNT(*)
FROM tb_student
WHERE DEPARTMENT_NO IS NULL;

--조건 확인되엇으니 이제 원하는 목록을위해 조인후 추출해보자.
SELECT s.student_no 학번,
    s.student_name 학생명,
    d.department_name 학과명
FROM TB_STUDENT S
 JOIN tb_department D
ON s.department_no = d.department_no;
--  TB_CLASS_PROFESSOR (수업번호, 교수번호에다있다.)
--2. 수업번호, 수업명 , 교수번호 , 교수명 조회
SELECT *
FROM TB_CLASS_PROFESSOR;

SELECT C.class_no 수업번호,
        C.class_name 수업명,
        P.professor_no 교수번호,
        P.professor_name 교수명
FROM Tb_Class_Professor CP
join tb_class C
on CP.class_no =C.class_no
join tb_professor P
on p.professor_no=CP.professor_no;


--3.송박선 학생의 모든 학기 과목별 점수를조회(학기, 학번 ,학생명, 수업명, 점수)
select *
from tb_grade;

select g.term_no 학기,
--        s.student_no 유징사용은 별칭사용안된다.
            student_no 학번,
            s.student_name 학생명,
            c.class_name 수업명,
            g.point 학점
from tb_grade G
JOIN tb_student S
USING(student_no)
JOIN tb_class C
USING(CLASS_NO)
WHERE S.STUDENT_NAME ='송박선';

--4.