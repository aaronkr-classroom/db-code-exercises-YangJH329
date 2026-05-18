-- week11
Table users;

SELECT user_level FROM users;

ALTER TABLE users
ADD CONSTRAINT chk_user_level
CHECK (user_level >=1 AND user_level <= 100);

UPDATE users
SET user_level = 100
WHERE user_id = 1;

-- 2 : 접속 상태는 online 또는 offline만 가능함
-- Table users;

ALTER TABLE users
ADD CONSTRAINT chk_user_status
CHECK (status in ('online','offline','connecting'));

UPDATE users
SET status = 'sleeping'
WHERE user_id = 2;  -- failed Query

-- 3: 아이템 가격은 0원 이상이어야함
Table items; -- or select price from items;

ALTER TABLE items
ADD CONSTRAINT chk_item_price
CHECK (price >= 0);

UPDATE items
SET price = - 10
WHERE item_id = 1001; -- failed Query2, chk_item_price 위반 

-- 4 : item등급을 정해진 값만 가능하다(S,A,B,C,D,E,F)
Table items;

ALTER TABLE items
ADD CONSTRAINT chk_item_grade
CHECK (grade in ('S','A','B','C','D','E','F'));

-- 5 : 닉네임은 중복되면 안된다
table users;

ALTER TABLE users
ADD CONSTRAINT uq_user_nickname
UNIQUE (nickname);

 -- Failed Query
INSERT INTO users VALUES
(6, '홍길동', 'DragonKing', 10, '2026-05-18', 'hong@home.com','offline' )

--
SELECT CONSTRAINT_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
	AND TABLE_NAME = 'plays'; 

SELECT CONSTRAINT_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
	AND TABLE_NAME = 'user_items'; 

--plays_user_id_fkey
--plays_game_id_fkey
--user_items_user_id_fkey
--user_items_item_id_fkey
ALTER TABLE plays
Drop CONSTRAINT plays_user_id_fkey;
ALTER TABLE plays
Drop CONSTRAINT plays_game_id_fkey;
ALTER TABLE user_items
Drop CONSTRAINT user_items_user_id_fkey;
ALTER TABLE user_items
Drop CONSTRAINT user_items_item_id_fkey; -- 기존 외래키 지우기

-- 새 FK 추가
-- 1 : 유저가 삭제되면 플레이 기록도 삭제되게 하기
ALTER TABLE plays
ADD CONSTRAINT fk_plays_users
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;

-- 2: 게임을 플레이한 기록이 있다면 삭제하지 못하도록
ALTER TABLE plays
ADD CONSTRAINT fk_plays_games
FOREIGN KEY (game_id)
REFERENCES games(game_id)
ON DELETE RESTRICT;

-- 3: 유저가 삭제되면 보유 아이템 기록도 삭제되도록
ALTER TABLE user_items
ADD CONSTRAINT fk_user_items_users
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;

-- 4: 아이템 누군가 보유 중이면 삭제하지 못하도록
ALTER TABLE user_items
ADD CONSTRAINT fk_user_items_items
FOREIGN KEY (item_id)
REFERENCES items(item_id)
ON DELETE RESTRICT;
-- alter table user_items -- 
-- drop constraint fk_user_items_items;

-- cascade test
select * from plays where user_id = 1;
select * from user_items where user_id=1;

DELETE FROM users WHERE user_id = 1; -- 

-- restrict test
table games;
-- INSERT INTO items VALUES (1004, '황금방패',20000, 'S');
DELETE FROM games where game_id = 101;  -- restrict, 삭제가 안된다
DELETE FROM items WHERE item_id = 1004; --
-- table items;