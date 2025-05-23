import json
import sqlite3

with open("watch-history.json", "r", encoding="utf-8") as f:
    data = json.load(f)

conn = sqlite3.connect("youtube_rewind.db")
cur = conn.cursor()

for entry in data:
    try:
        title = entry["title"].replace("Watched ", "").strip()
        url = entry.get("titleUrl")
        time = entry.get("time")
        channel_info = entry.get("subtitles", [{}])[0]
        channel_name = channel_info.get("name", "Unknown")
        channel_url = channel_info.get("url")

        if not time or not url:
            continue

        # Insert channel
        cur.execute(
            "INSERT OR IGNORE INTO channels (name, url) VALUES (?, ?)",
            (channel_name, channel_url),
        )
        cur.execute("SELECT channel_id FROM channels WHERE name = ?", (channel_name,))
        channel_id = cur.fetchone()[0]

        # Insert video with channel_id
        cur.execute(
            "INSERT OR IGNORE INTO videos (title, url, channel_id) VALUES (?, ?, ?)",
            (title, url, channel_id),
        )
        cur.execute("SELECT video_id FROM videos WHERE url = ?", (url,))
        video_id = cur.fetchone()[0]

        # Insert history ignoring platform and activity_control
        cur.execute(
            "INSERT INTO watch_history (video_id, channel_id, watched_at) VALUES (?, ?, ?)",
            (video_id, channel_id, time),
        )

    except Exception as e:
        print("Skipped:", e)

conn.commit()
conn.close()
