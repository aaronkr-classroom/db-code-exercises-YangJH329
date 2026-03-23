/*
동아리 관리
[Entities ]
- club_member

[Property]
- student_id (int) PRIMARY KEY-- 멤버 식별을 위한 pk
- name varchar(30) NOT NULL
- dept varchar(30)
- role varchar(20) default '일반'
- join_date date DEFAULT CURRENT_DATE
*/

-- Create table
CREATE TABLE club_member (
    student_id int PRIMARY KEY,
    name varchar(30) NOT NULL,
    dept varchar(30),
    role varchar(20) DEFAULT '일반',
    join_date date DEFAULT CURRENT_DATE
);

-- insert data
INSERT INTO club_member (student_id, name, dept, role, join_date) VALUES 
(20210001, '손흥민', '컴퓨터공학', '회장', '2025-03-02'),
(20210002, '이재성', '소프트웨어', '부회장', '2025-03-05'),
(20220015, '김민재', '컴퓨터공학', '일반', '2026-03-10'),
(20230042, '황희찬', '전자공학', '일반', '2026-03-12'),
(20230050, '조규성', '체육학', '일반', '2026-03-15');

-- 전체 조회
SELECT * FROM club_member; 

-- 정렬
SELECT name, dept, join_date FROM club_member ORDER BY 3 ASC;

-- 조건 검색
SELECT name, role FROM club_member WHERE LIKE '%회장';