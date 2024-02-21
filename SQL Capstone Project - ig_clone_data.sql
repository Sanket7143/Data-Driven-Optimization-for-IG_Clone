# SQL Capstone Project - ig_clone_data.sql
use ig_clone;
# Q.1 Entity-Relationship (ER) diagram
---image attached in PDF---
# Q.2 we want to reward the user who has been around the longest,find the 5 oldest users.
select * from users order by created_at asc limit 5;

# Q 3.To target inactive users in an email ad campaign,find the users have never posted a photo.
select u.username
from users u
left join photos p on u.id = p.user_id
where p.user_id is null;
# Q 4.Suppose you are running a contest to find out who got the most likes on a photo.find out who win?
select u.username, COUNT(*) as like_count
from users as u
inner join photos as p on u.id = p.user_id
inner join likes as l on p.id = l.photo_id
group by u.username
order by  like_count DESC
Limit 1;

# Q 5.User Behavior Analysis : Calculated the average user post frequency to provide valuable insights to investors on user engagement.
SELECT u.username,COUNT(p.user_id) AS num_posts,
AVG(DATEDIFF(CURRENT_TIMESTAMP(), p.created_at)) 
AS avg_post_frequency_days
FROM users u LEFT JOIN photos p ON u.id = p.user_id
GROUP BY u.username;

# Q 6.find the top 5 most used hashtags?
select tag_name, COUNT(*) as count from tags
group by tag_name order by  
count DESC limit 5;

# Q 7.Bot Detection: Implemented queries to identify potential bots by finding users who liked every photo on the site.
SELECT user_id FROM likes
GROUP BY user_id 
HAVING COUNT(DISTINCT photo_id) = (SELECT COUNT(*) FROM photos);

# 8.the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos
select distinct u.username
from users as u
inner join  photos as p on u.id = p.id
inner jOin likes as l on l.user_id = p.user_id
where u.username like 'c%';

# Q 9.top 30 username to the company who have posted photos in the range of 3 to 5.
SELECT u.username, COUNT(*) AS photo_count
FROM users AS u
INNER JOIN photos AS p ON u.id = p.user_id
GROUP BY u.username
HAVING photo_count BETWEEN 3 AND 5
ORDER BY photo_count DESC
LIMIT 30;

