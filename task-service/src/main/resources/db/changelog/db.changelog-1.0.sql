--liquibase formatted sql

--changeset re1kur:1
CREATE TABLE IF NOT EXISTS tracks
(
    id   SMALLSERIAL PRIMARY KEY,
    name VARCHAR(128) NOT NULL UNIQUE

);

--changeset re1kur:2
CREATE TABLE IF NOT EXISTS tasks
(
    id                  SERIAL PRIMARY KEY,
    track_id            SMALLINT       NOT NULL,
    name                VARCHAR(128)   NOT NULL,
    preview_description VARCHAR(256)   NOT NULL,
    description         TEXT           NOT NULL,
    level               SMALLINT       NOT NULL,
    cost                DECIMAL(19, 2) NOT NULL,
    FOREIGN KEY (track_id) REFERENCES tracks (id) ON DELETE CASCADE
);

--changeset re1kur:3
CREATE TABLE IF NOT EXISTS users_tasks
(
    user_id UUID,
    task_id INTEGER,
    completed_at TIMESTAMP,
    PRIMARY KEY (user_id, task_id),
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
);

--changeset re1kur:4
CREATE TABLE IF NOT EXISTS users_tracks
(
    user_id  UUID,
    track_id SMALLINT,
    PRIMARY KEY (user_id, track_id),
    FOREIGN KEY (track_id) REFERENCES tracks (id) ON DELETE CASCADE
);

--changeset re1kur:5
CREATE TABLE user_tasks_files
(
    task_id INTEGER,
    user_id UUID,
    file_id UUID,
    PRIMARY KEY (task_id, user_id, file_id),
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
);
