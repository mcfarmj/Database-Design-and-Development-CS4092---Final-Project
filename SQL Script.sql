-- === SCHEMA CREATION ===
DROP TABLE IF EXISTS "Review";
DROP TABLE IF EXISTS "Watchlist";
DROP TABLE IF EXISTS "Movie";
DROP TABLE IF EXISTS "User";

CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE "Movie" (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    director VARCHAR(100),
    genre VARCHAR(50),
    release_year INT
);

CREATE TABLE "Watchlist" (
    user_id INT REFERENCES "User"(user_id) ON DELETE CASCADE,
    movie_id INT REFERENCES "Movie"(movie_id) ON DELETE CASCADE,
    status VARCHAR(20) NOT NULL CHECK (status IN ('to-watch', 'watched')),
    PRIMARY KEY (user_id, movie_id)
);

CREATE TABLE "Review" (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES "User"(user_id) ON DELETE CASCADE,
    movie_id INT REFERENCES "Movie"(movie_id) ON DELETE CASCADE,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE DEFAULT CURRENT_DATE
);

-- === SAMPLE DATA ===
INSERT INTO "User" (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

INSERT INTO "Movie" (title, director, genre, release_year) VALUES
('Inception', 'Christopher Nolan', 'Sci-Fi', 2010),
('The Matrix', 'Lana Wachowski', 'Action', 1999),


INSERT INTO "Watchlist" (user_id, movie_id, status) VALUES
(1, 1, 'to-watch'),
(1, 2, 'watched'),
(2, 1, 'watched'),


INSERT INTO "Review" (user_id, movie_id, rating, comment) VALUES
(1, 2, 5, 'Amazing action and story!'),
(2, 1, 4, 'Great visuals, a bit complex.');


