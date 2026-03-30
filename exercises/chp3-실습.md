### 게임 유저 관리 시스템 (step 1)  
게임 유저
---  
### 요구사항 작성 (step 2)

1. 사용자 2명
    - 게임 운영자 : 유저의 상태를 확인하고, 전체적인 현황을 모니터링 할 수 있다.
    - 일반 유저 : 본인의 계정 정보를 관리하고, 게임 내에 여러 캐릭터를 생성하고 육성할 수 있다.

2. 요구사항
    1. 회원 가입 및 계정 관리 :유저는 고유한 아이디, 비밀번호, 이메일을 입력하여 회원가입을 할 수 있어야 합니다.  
    2. 캐릭터 다중 보유      ： 한 명의 유저는 여러 개의 캐릭터를 생성할 수 있지만, 각 캐릭터의 이름은 전체 서버에서 중복될 수 없습니다.  
    3. 레벨 및 경험치 관리   ： 캐릭터는 고유한 레벨과 경험치 데이터를 가지며, 게임 플레이에 따라 이 수치는 업데이트되어야 합니다.  
    4. 로그인 기록           ： 유저가 마지막으로 접속한 날짜와 시간을 기록하여 휴면 계정 판단 근거로 활용합니다.
    5. 캐릭터 직업 분류      ： 캐릭터 생성 시 전사, 마법사, 궁수 등 지정된 직업 중 하나를 반드시 선택해야 합니다.  
---
### 데이터 설계 (step 3)
1. 엔티티(Entity) 정의
    - User ： 유저의 계정 정보를 담는 테이블
    - Character  ： 유저의 캐릭터 정보를 담는 테이블

2. 속성 정의
    1. user
        - `user_id`, int(pk), auto increment
        - `account_id`, varchar(50), not null, unique
        - `password`, varchar(30), not null
        - `email`, varchar(50), unique
        - `last_login` datetime        
        
    2. character
        - `char_id`, int(pk), auto increment
        - `user_id`, int(fk), not null
        - `nickname`, varchar(20), not null, unique
        - `job`, varchar(10), not null
        - `level`, int, default 1  
---
### SQL 작성(step 4)

#### 테이블 생성  

```sql
-- 1. 유저 테이블 생성
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE,
    last_login DATETIME
);
```

```sql
-- 2. 캐릭터 테이블 생성
CREATE TABLE `Character` (
    char_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    nickname VARCHAR(20) NOT NULL UNIQUE,
    job VARCHAR(10) NOT NULL,
    level INT DEFAULT 1,
    -- User 테이블의 user_id를 참조하는 외래키 설정
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);
```
#### 데이터 삽입  

```sql
-- 유저 데이터 삽입
INSERT INTO User (account_id, password, email, last_login) 
VALUES ('gamer_pro', 'pass123', 'pro@example.com', NOW());
```

```sql
-- 캐릭터 데이터 삽입 (user_id가 1인 유저의 캐릭터)
INSERT INTO `Character` (user_id, nickname, job, level) 
VALUES (1, '전사무적', '전사', 15);
```

#### 데이터 조회
```sql
-- 모든 유저 정보 조회
SELECT * FROM User;

-- 모든 캐릭터 정보 조회
SELECT * FROM `Character`;
```

```sql
-- 레벨이 높은 순서대로 캐릭터 정렬
SELECT nickname, level FROM `Character` ORDER BY level DESC;
```