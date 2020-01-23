USE vk;

SELECT * FROM users WHERE id = 3;

SELECT first_name, last_name, 'main_photo', 'city' 
  FROM users WHERE id = 3;
  
 SELECT 
   first_name, 
   last_name, 
   (SELECT filename FROM media WHERE id = 
     (SELECT photo_id FROM profiles WHERE user_id = 3) 
   ) AS photo,
   (SELECT hometown FROM profiles WHERE user_id = 3) AS hometown
  FROM users WHERE id = 3;
  
 
 DESC profiles;
 
  SELECT 
   first_name, 
   last_name, 
   (SELECT filename FROM media WHERE id = 
     (SELECT photo_id FROM profiles WHERE user_id = users.id) 
   ) AS photo,
   (SELECT hometown FROM profiles WHERE user_id = users.id) AS hometown
  FROM users WHERE id = 3;
 
SELECT filename FROM media 
  WHERE user_id = 1
    AND media_type_id = (
      SELECT id FROM media_types WHERE name = 'photo'
      );
     
SELECT * FROM media_types;
    
SELECT CONCAT(
   'Пользователь добавил фото ',
   filename,
   ' ',
   created_at) AS news
     FROM media
     WHERE user_id = 5
       AND media_type_id = (
         SELECT id FROM media_types WHERE name LIKE 'photo'
);
       
SELECT CONCAT(
   'Пользователь ', 
   (SELECT CONCAT(first_name, ' ', last_name)
     FROM users WHERE id = media.user_id),
     ' добавил фото ',
   filename,
   ' ',
   created_at) AS news
     FROM media
     WHERE user_id = 5
       AND media_type_id = (
         SELECT id FROM media_types WHERE name LIKE 'photo'
);

SELECT user_id, filename, size 
  FROM media 
  ORDER BY size DESC
  LIMIT 10;

 SELECT 
   (SELECT CONCAT(first_name, ' ', last_name)
     FROM users u WHERE u.id = m.user_id) AS user, 
     filename, 
     size 
       FROM media m
       ORDER BY size DESC
       LIMIT 10;
      
DESC friendship;

SELECT friend_id FROM friendship WHERE user_id = 3;
SELECT user_id FROM friendship WHERE friend_id = 3;


(SELECT friend_id FROM friendship WHERE user_id = 3)
UNION
 (SELECT user_id FROM friendship WHERE friend_id = 3);

SELECT * FROM friendship_statuses;


(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 3
    AND confirmed_at IS NOT NULL
    AND status_id IN (
      SELECT id FROM friendship_statuses
        WHERE name = 'Confirmed'
    )
)    
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 3
   AND confirmed_at IS NOT NULL
   AND status_id IN (
   SELECT id FROM friendship_statuses
        WHERE name = 'Confirmed'
   )
);


SELECT filename FROM media WHERE user_id IN (
 (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 5
    AND confirmed_at IS NOT NULL
    AND status_id IN (
      SELECT id FROM friendship_statuses
        WHERE name = 'Confirmed'
    )
 )    
 UNION
 (SELECT user_id 
  FROM friendship 
  WHERE friend_id = 5
   AND confirmed_at IS NOT NULL
   AND status_id IN (
   SELECT id FROM friendship_statuses
        WHERE name = 'Confirmed'
   )
 )
);

SELECT filename, user_id, created_at FROM media WHERE user_id = 5
UNION
SELECT filename, user_id, created_at FROM media WHERE user_id IN (
 (SELECT friend_id 
  FROM friendship 
  WHERE user_id = 5
    AND confirmed_at IS NOT NULL
    AND status_id IN (
      SELECT id FROM friendship_statuses
        WHERE name = 'Confirmed'
    )
 )    
 UNION
 (SELECT user_id 
  FROM friendship 
  WHERE friend_id = 5
   AND confirmed_at IS NOT NULL
   AND status_id IN (
   SELECT id FROM friendship_statuses
        WHERE name = 'Confirmed'
   )
 )
);


SELECT user_id, SUM(size) AS total
  FROM media 
  GROUP BY user_id
  HAVING total > 97000000
  ORDER BY total DESC;

DESC likes;
SELECT * FROM target_types;

SELECT target_id AS mediafile, COUNT(*) AS likes
  FROM likes
    WHERE target_id IN (
      SELECT id FROM media WHERE user_id = 9
      UNION
      (SELECT id FROM media WHERE user_id IN (
        SELECT friend_id
          FROM friendship 
            WHERE user_id = 9
              AND status_id IN (
                SELECT id FROM friendship_statuses
                   WHERE name = 'Confirmed'
               )))
        UNION
        (SELECT id FROM media WHERE user_id IN (
          SELECT user_id 
             FROM friendship
               WHERE friend_id = 9
                 AND status_id IN (
                   SELECT id FROM friendship_statuses
                     WHERE name = 'Confirmed'
                 )))
    )
    AND target_type_id = (SELECT id FROM target_types WHERE name = 'media')
    GROUP BY target_id;

SELECT COUNT(id) AS archive, MONTHNAME(created_at) AS month 
  FROM media 
  GROUP BY month;
 
 
SELECT COUNT(id) AS news,
  MONTHNAME(created_at) AS m,
  MONTH(created_at) AS month_num
    FROM media
    GROUP BY month_num
    ORDER BY month_num DESC;
   
DESC messages;
   
   
SELECT from_user_id, to_user_id, body, is_delivered, created_ad
  FROM messages 
    WHERE from_user_id = 3
      OR to_user_id = 3
    ORDER BY created_ad DESC;

SELECT from_user_id,
  to_user_id,
  body,
  IF(is_delivered, 'delivered', 'not delivered') AS status
    FROM messages 
      WHERE (from_user_id = 3 OR to_user_id = 3)
      AND is_delivered IS NOT TRUE
    ORDER BY created_ad DESC;
   
   
   
   
SELECT 
   (SELECT CONCAT(first_name, ' ', last_name)
     FROM users 
     WHERE id = user_id) AS friend,
     
     CASE (sex)
       WHEN 'm' THEN 'man'
       WHEN 'f' THEN 'woman'
     END AS sex,
     
     TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age
     
    FROM profiles 
    
    WHERE user_id IN (
      SELECT friend_id
        FROM friendship 
        WHERE user_id = 9
          AND confirmed_at IS NOT NULL
          AND status_id IN (
            SELECT id FROM friendship_statuses 
              WHERE name = 'Confirmed'
            )
        UNION
        SELECT user_id
        FROM friendship
        WHERE friend_id = 9
          AND confirmed_at IS NOT NULL
          AND status_id IN (
            SELECT id FROM friendship_statuses 
              WHERE name = 'Confirmed'
            )
  );
 
 
 SELECT CONCAT(first_name, ' ', last_name) AS fullname
   FROM users 
   WHERE first_name LIKE 'M%';

 SELECT CONCAT(first_name, ' ', last_name) AS fullname
   FROM users 
   WHERE first_name RLIKE '^M.*n$';   

 