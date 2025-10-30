-- Group 64: Rebeca Moreno Rodriguez, Prisha Velhal
-- Movie Night Planner Management System
-- CS340 Project Step 2 - DDL

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS WatchedMovies;
DROP TABLE IF EXISTS SavedMovies;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Users;

-- Prisha's Tables
-- Create Users table
CREATE TABLE Users (
    userId INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(100),
    email VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (userId)
);

-- Rebeca's Tables
-- Create Movies table
CREATE TABLE Movies (
    movieId INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NULL,
    release_date DATE NULL,
    lead_actor VARCHAR(150) NULL,
    streaming_platform VARCHAR(100) NULL,
    PRIMARY KEY (movieId)
);

-- Create SavedMovies junction table
CREATE TABLE SavedMovies (
    userId INT NOT NULL,
    movieId INT NOT NULL,
    saved_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (userId) REFERENCES Users(userId)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (movieId) REFERENCES Movies(movieId)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create WatchedMovies junction table
CREATE TABLE WatchedMovies (
    userId INT NOT NULL,
    movieId INT NOT NULL,
    watched_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (userId) REFERENCES Users(userId)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (movieId) REFERENCES Movies(movieId)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert sample Users (Prisha's data)
INSERT INTO Users (name, email) VALUES
('John Smith', 'JoSmith@gmail.com'),
('Jane Doe', 'JaDoe@gmail.com'),
('Scarlett Johansson', 'ScarJo@gmail.com');

-- Insert sample Movies (Rebeca's data)
INSERT INTO Movies (title, genre, release_date, lead_actor, streaming_platform) VALUES
('A House of Dynamite', 'Thriller', '2025-09-02', 'Idris Elba', 'Netflix'),
('Wicked', 'Fantasy', '2024-11-22', 'Cynthia Erivo', 'Prime Video'),
('The Night Before Christmas', 'Fantasy', '1993-10-29', 'Bing Crosby', 'Disney+');

-- Insert sample SavedMovies (Prisha's data)
INSERT INTO SavedMovies (userId, movieId, saved_date) VALUES
(1, 2, '2025-03-05'),
(2, 2, '2025-05-10'),
(1, 3, '2025-01-05');

-- Insert sample WatchedMovies (Rebeca's data)
INSERT INTO WatchedMovies (userId, movieId, watched_date) VALUES
(1, 1, '2025-09-10'),
(2, 1, '2025-09-15'),
(2, 3, '2023-12-25');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;