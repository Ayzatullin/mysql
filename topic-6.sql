USE vk;

-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT id, from_user_id AS friend FROM messages WHERE to_user_id = 54
UNION
SELECT id, to_user_id AS friend FROM messages WHERE from_user_id = 54;

SELECT user_id, friend_id   
  FROM friendship  
  WHERE confirmed_at IS NOT NULL
    AND status_id IN (
      SELECT id FROM friendship_statuses
        WHERE name = 'Confirmed');
       

-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей
-- Сумму посчитать не смог.

SELECT 
    user_id, 
    TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age, 
    (SELECT COUNT(target_id) FROM likes l WHERE l.user_id = p.user_id GROUP BY l.user_id) AS likes_numb
FROM profiles p
 ORDER BY age LIMIT 10;



-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT user_id, sex, 
(SELECT COUNT(target_id) FROM likes l WHERE l.user_id = p.user_id GROUP BY l.user_id) AS likes_numb
FROM profiles p;



-- 5. Найти 10 пользователей, которые проявляют наименьшую активность
-- Наименьшая активность - меньше всех ставили лайков, загрузили медиа, написали сообщений и постов.

DESC likes;
SELECT user_id, COUNT(target_id) AS like_num FROM likes GROUP BY user_id ORDER BY like_num;

DESC media;
SELECT user_id, COUNT(filename) AS m_num FROM media GROUP BY user_id ORDER BY m_num;

DESC messages;
SELECT from_user_id, to_user_id, is_delivered FROM messages;

DESC posts;






