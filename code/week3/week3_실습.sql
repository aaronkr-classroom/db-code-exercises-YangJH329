/*
[Entities / 개체]
- professor

[Properties / 속성]
- id 			(BIGSERIAL) -- 자동으로 증가하는 숫자
- name 			(VARCHAR(30)
- dept 			(VARCHAR(50)
- salary 		(NUMERIC)
- salary_level  (NUMERIC)
- hire_date 	(DATE) --'YYYY-MM-DD'
*/

CREATE TABLE prof (
	id bigserial,
	name varchar(30),
	dept varchar(50),
	salary numeric,
	salary_level numeric,
	hire_date date
);

-- 데이터 삽입하기
INSERT INTO prof (name, dept, salary, salary_level, hire_date)
values ('김석진', '컴퓨터공학', 100000, 2, '1992-12-04'), -- Bts 진
		('박지성', '컴퓨터공학', 900000, 2, '1992-12-04'),
		('이재성','정보통신공학',800000, 1, '2001-3-1'),
		('손흥민','체육대학', 700000, 1, '1992-07-08'),
		('백지헌','아동교육학',600000, 1, '2003-04-17');


-- 데이터 검색
SELECT name, salary FROM prof;

SELECT name, salary FROM prof order by salary desc; -- or asc

SELECT name, salary FROM prof WHERE salary > 90000;

SELECT name, salary FROM prof WHERE name LIKE '김%'; -- PostgreSQL ILIKE 대/소문자 상관없음

SELECT name, dept FROM prof 
	WHERE dept LIKE '%공%'
	ORDER BY dept ASC;

SELECT name, salary FROM prof WHERE salary BETWEEN 700000 AND 900000;