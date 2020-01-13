USE vk;

SHOW TABLES;

SELECT * FROM users LIMIT 10;

SELECT * FROM profiles LIMIT 10;

CREATE TEMPORARY TABLE sex(sex CHAR(1));
INSERT INTO sex VALUES ('m'), ('f');
UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);

SELECT * FROM messages LIMIT 10;
UPDATE messages SET
   from_user_id = FLOOR(1 + (RAND() * 100)),
   to_user_id = FLOOR(1 + (RAND() * 100));
   
SELECT * FROM media LIMIT 10;

SELECT * FROM media_types;
DELETE FROM media_types;
TRUNCATE media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio');

UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 3));
UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));
UPDATE media SET filename = CONCAT('https://dropbox/vk/file_', size);

UPDATE media SET metadata = CONCAT(
  '{"', size, '":"',
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');
 
DESC media;
ALTER TABLE media MODIFY COLUMN metadata JSON;
 
SELECT * FROM friendship LIMIT 10;
UPDATE friendship SET
  user_id = FLOOR(1 + (RAND() * 100)),
  friend_id = FLOOR(1 + (RAND() * 100));
 
DESC friendship;

SELECT * FROM friendship_statuses;
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name)
  VALUES ('Requested'), ('Confirmed');

SELECT *FROM friendship LIMIT 10;
UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 2));

SHOW TABLES;

SELECT * FROM communities;
DELETE FROM communities WHERE id > 20;

SELECT * FROM communities_users;
UPDATE communities_users SET
  community_id = FLOOR(1 + (RAND() * 20)),
  user_id = FLOOR(1 + (RAND() * 100));

SELECT * FROM friendship LIMIT 10;
SELECT * FROM friendship_statuses;

CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  header VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DESC posts;

SELECT * FROM friendship LIMIT 10;

INSERT INTO friendship_statuses (name) VALUE ('Interrupted');
SELECT * FROM friendship_statuses;

ALTER TABLE profiles ADD COLUMN updated_at DATETIME DEFAULT NOW() ON UPDATE NOW();

CREATE TABLE meetings (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE,
  scheduled_at DATETIME
);

SELECT * FROM meetings;
SELECT * FROM posts;



 