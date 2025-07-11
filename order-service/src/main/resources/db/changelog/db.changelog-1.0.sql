--liquibase formatted sql

--changeset re1kur:1

CREATE TABLE IF NOT EXISTS statuses
(
    id   SMALLSERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL UNIQUE
);

--changeset re1kur:2

CREATE TABLE IF NOT EXISTS orders
(
    id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    goods_id  INT NOT NULL,
    status_id SMALLINT NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT now(), --date        TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    FOREIGN KEY (status_id) REFERENCES statuses (id),
    UNIQUE(user_id, goods_id)
);

--changeset re1kur:3
INSERT INTO statuses (name)
VALUES  ('CREATED'),
        ('REJECTED'),
        ('APPROVED');

--changeset re1kur:4
ALTER TABLE orders ALTER COLUMN status_id SET DEFAULT 1;