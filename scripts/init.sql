-- Create the 'users' table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    userName VARCHAR(255) NOT NULL UNIQUE
);

-- Create the 'subscriptions' table
CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    subscriber_id INT NOT NULL,
    subscribed_to_id INT NOT NULL,
    FOREIGN KEY (subscriber_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (subscribed_to_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT unique_subscription UNIQUE (subscriber_id, subscribed_to_id)
);

-- Create the 'videos' table
CREATE TABLE videos (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    release_date TIMESTAMP DEFAULT NOW(),
    video_uploader_id INT NOT NULL,
    FOREIGN KEY (video_uploader_id) REFERENCES users(id) ON DELETE CASCADE
);
