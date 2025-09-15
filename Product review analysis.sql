SELECT *
FROM multilingual_mobile_app_reviews_2025;

#identifying most used categories
#top: entertainment 163 users
#navigation 161 users
#travel & local 156 users
#health & fitness 153 users
#music & audio 149 users
SELECT app_category,  COUNT(app_category)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_category
ORDER BY 2 DESC
LIMIT 5;

#least used app categories
#Photography 107 users
#utilities 114 users
#games 116 users
SELECT app_category,  COUNT(app_category)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_category
ORDER BY 2 ASC
LIMIT 3;

#most used apps
#reddit 79 users
#pinterest 78 users
#onedrive 74 users
SELECT app_name, COUNT(app_name)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_name
ORDER BY 2 DESC
LIMIT 3;

#least used applications
#discord 42 users
#venmo 49 users
#VLC 49 users
SELECT app_name, COUNT(app_name)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_name
ORDER BY 2 ASC
LIMIT 3;

#highly rated applications by users
#top: Snapchat 3.31
#OneDrive 3.29
#Khan Academy 3.26
SELECT app_name, AVG(rating)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_name
ORDER BY 2 DESC
LIMIT 3;

#identifying app sage by gender using subquery
#reddit gender is prefer not to say makes sense main goal is anonymity
#pinterest unknown
#one drive non binary
SELECT t.app_name, t.user_gender, COUNT(*) AS gender_count
FROM multilingual_mobile_app_reviews_2025 t
JOIN (
    SELECT app_name
    FROM multilingual_mobile_app_reviews_2025
    GROUP BY app_name
    ORDER BY COUNT(*) DESC
    LIMIT 3
) top_apps ON t.app_name = top_apps.app_name
GROUP BY t.app_name, t.user_gender
HAVING COUNT(*) = (
    SELECT MAX(gender_count)
    FROM (
        SELECT user_gender, COUNT(*) AS gender_count
        FROM multilingual_mobile_app_reviews_2025
        WHERE app_name = t.app_name
        GROUP BY user_gender
    ) g
);

#by highly rated
#both khan academy and onedrive are non binary
#snapchat is unknown
SELECT t.app_name, t.user_gender, COUNT(*) AS gender_count
FROM multilingual_mobile_app_reviews_2025 t
JOIN (
    SELECT app_name
    FROM multilingual_mobile_app_reviews_2025
    GROUP BY app_name
    ORDER BY AVG(rating) DESC
    LIMIT 3
) top_apps ON t.app_name = top_apps.app_name
GROUP BY t.app_name, t.user_gender
HAVING COUNT(*) = (
    SELECT MAX(gender_count)
    FROM (
        SELECT user_gender, COUNT(*) AS gender_count
        FROM multilingual_mobile_app_reviews_2025
        WHERE app_name = t.app_name
        GROUP BY user_gender
    ) g
);

#app usage by aage to determine marketing
#SNAPCHAT average age is 44 years
#onerie has average age of 45
#khan academy has average age of 46
SELECT app_name, AVG(rating), AVG(user_age)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_name
ORDER BY 2 DESC
LIMIT 3;

#countries with highest votes based on app category
#Germany Travel & Local 10866 votes
#Malysia Travel & Local 9660 votes
#UK Productivity 9011 votes 
SELECT user_country, app_category, sum(num_helpful_votes)
FROM multilingual_mobile_app_reviews_2025
GROUP BY user_country, app_category
ORDER BY 3 DESC
LIMIT 3;

#most voted applications
#pinterest 52950 votes
#reddit 49207 votes
#instagram 46696 votes
SELECT app_name, sum(num_helpful_votes)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_name
ORDER BY 2 DESC
LIMIT 3;

#most voted applcations by country
#pinterest Mexico 5842 votes
#mx player Mexico 5827 votes
#spotify France 5516 votes
SELECT app_name, user_country, sum(num_helpful_votes)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_name, user_country
ORDER BY 3 DESC
LIMIT 3;


#most voted for app version
#version 8 mosted voted 5388 votes
#version 11.1 with 5219
#8.4 with  5187 votes
SELECT app_version, sum(num_helpful_votes)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_version
ORDER BY 2 DESC
LIMIT 3;

#identifying and removing unknown values for better analysis
SELECT app_version, count(*)
FROM multilingual_mobile_app_reviews_2025
WHERE app_version = 'UNKNOWN';

DELETE 
FROM multilingual_mobile_app_reviews_2025
WHERE app_version = 'UNKNOWN';

#most highly rated app versions
#version 12.2.39 with 5stars
#version 12.3.44 with 5 stars
#ersion 1.2.39 with 5 stars
SELECT app_version, rating, avg(rating)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_version, rating
ORDER BY 3 DESC
LIMIT 3;

#least rated versions 
#12.8.31-beta
#9.7.10-beta
#v5.2.30
SELECT app_version, rating, avg(rating)
FROM multilingual_mobile_app_reviews_2025
GROUP BY app_version, rating
ORDER BY 3 ASC
LIMIT 3;

#checking for final unknowns
SELECT review_id
FROM multilingual_mobile_app_reviews_2025
WHERE review_id LIKE '%UNKNOWN%'
OR review_id IS NULL;

SELECT user_id
FROM multilingual_mobile_app_reviews_2025
WHERE user_id LIKE '%UNKNOWN%'
OR user_id IS NULL;

SELECT app_category
FROM multilingual_mobile_app_reviews_2025
WHERE review_id LIKE '%UNKNOWN%';

SELECT rating
FROM multilingual_mobile_app_reviews_2025
WHERE rating LIKE '%UNKNOWN%';

SELECT review_date
FROM multilingual_mobile_app_reviews_2025
WHERE review_date LIKE '%UNKNOWN%';

SELECT review_time
FROM multilingual_mobile_app_reviews_2025
WHERE review_time LIKE '%UNKNOWN%';

SELECT num_helpful_votes, count(*)
FROM multilingual_mobile_app_reviews_2025
WHERE num_helpful_votes= 'UNKOWN';

DELETE
FROM multilingual_mobile_app_reviews_2025
WHERE num_helpful_votes = 0;

SELECT user_age
FROM multilingual_mobile_app_reviews_2025
WHERE user_age LIKE '%UNKNOWN%';

SELECT user_country
FROM multilingual_mobile_app_reviews_2025
WHERE user_country LIKE '%UNKNOWN%';

DELETE
FROM multilingual_mobile_app_reviews_2025
WHERE user_country LIKE '%UNKNOWN%';

SELECT user_gender
FROM multilingual_mobile_app_reviews_2025
WHERE user_gender LIKE '%UNKNOWN%'
OR user_gender 	IS NULL;
