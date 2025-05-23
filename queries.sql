-- Most watched channels(by quantity of videos)

SELECT c.name, COUNT(*) AS times_watched
FROM watch_history h
JOIN videos v ON h.video_id = v.video_id
JOIN channels c ON v.channel_id = c.channel_id
GROUP BY c.name
ORDER BY times_watched DESC
LIMIT 20;

-- Most rewatched videos

SELECT v.title, COUNT(*) AS views
FROM watch_history h
JOIN videos v ON h.video_id = v.video_id
GROUP BY v.title
ORDER BY views DESC
LIMIT 10;


--  Search watched videos by channel name

SELECT v.title, h.watched_at
FROM watch_history h
JOIN videos v ON h.video_id = v.video_id
JOIN channels c ON v.channel_id = c.channel_id
WHERE c.name = 'Tockers'
ORDER BY h.watched_at DESC;

-- Total videos watched

SELECT COUNT(*) AS videos_watched
FROM watch_history;

--Number of unique channels watched

SELECT COUNT(DISTINCT c.channel_id) AS unique_channels
FROM watch_history h
JOIN videos v ON h.video_id = v.video_id
JOIN channels c ON v.channel_id= c.channel_id;

