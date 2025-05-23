--table for channels wich videos have been watched
CREATE TABLE channels (
    channel_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    url VARCHAR(512) UNIQUE
);

--table for videos watched
CREATE TABLE videos (
    video_id INTEGER PRIMARY KEY ,
    title VARCHAR(512) NOT NULL,
    url VARCHAR(512) UNIQUE,
    channel_id INT,
    FOREIGN KEY (channel_id) REFERENCES Channels(channel_id)
);

-- table to link channels and videos
CREATE TABLE watch_history (
    history_id INTEGER PRIMARY KEY ,
    video_id INT,
    watched_at DATETIME NOT NULL,
    platform VARCHAR(50),
    activity_control VARCHAR(100),
    channel_id INTEGER,
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id),
    FOREIGN KEY (video_id) REFERENCES Videos(video_id)
);
