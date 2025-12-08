-- Group 64: Rebeca Moreno Rodriguez, Prisha Velhal
-- Movie Night Planner Management System
-- CS340 Portfolio Project - Fall 2025
-- Data Definition Language (DDL)
--
-- Citation: Table structure syntax based on CS340 course examples
-- Originality: 
-- All table schemas (Users, Movies, SavedMovies, WatchedMovies)
-- All foreign key relationships and CASCADE operations
-- All sample data
-- All JOIN queries for M:N relationships
-- Dropdown population queries using CONCAT
-- AI Usage: No AI tools were used in developing this application code.

--Users table
SELECT userId, name, email FROM Users;

-- get all users for dropdown
SELECT userId, name FROM Users;

INSERT INTO Users (name, email)
VALUES (@nameInput, @emailInput);

UPDATE Users 
    SET name = @nameInput,
        email = @emailInput 
    WHERE userId = @userIdInput;

DELETE FROM Users WHERE userId = @userIdInput;

-- Movies table
SELECT movieId, title, genre, release_date, lead_actor, streaming_platform 
FROM Movies;

-- get all movies for dropdown
SELECT movieId, CONCAT(title, ' (', genre, ')') AS display_name FROM Movies;

INSERT INTO Movies (title, genre, release_date, lead_actor, streaming_platform)
VALUES (@titleInput, @genreInput, @release_date_Input, @lead_actor_Input, @streaming_platform_Input);

UPDATE Movies
SET title = @titleInput,
    genre = @genreInput,
    release_date = @release_date_Input,
    lead_actor = @lead_actor_Input,
    streaming_platform = @streaming_platform_Input
WHERE movieId = @movieIdInput;

DELETE FROM Movies
WHERE movieId = @movieIdInput;

--SavedMovies table
SELECT 
    Users.name AS user_name,
    Movies.title AS movie_title,
    Movies.genre,
    Movies.streaming_platform,
    SavedMovies.saved_date
FROM SavedMovies
INNER JOIN Users ON SavedMovies.userId = Users.userId
INNER JOIN Movies ON SavedMovies.movieId = Movies.movieId;

INSERT INTO SavedMovies (userId, movieId, saved_date)
VALUES (@userIdInput, @movieIdInput, @savedDateInput);

UPDATE SavedMovies
    SET saved_date = @savedDateInput
    WHERE userId = @userIdInput 
    AND movieId = @movieIdInput;

DELETE FROM SavedMovies WHERE userId = @userIdInput AND movieId = @movieIdInput;

-- WatchedMovies table
SELECT 
    Users.name AS user_name,
    Movies.title AS movie_title,
    Movies.genre,
    Movies.streaming_platform,
    WatchedMovies.watched_date
FROM WatchedMovies
INNER JOIN Users ON WatchedMovies.userId = Users.userId
INNER JOIN Movies ON WatchedMovies.movieId = Movies.movieId;

INSERT INTO WatchedMovies (userId, movieId, watched_date)
VALUES (@userIdInput, @movieIdInput, @watched_date_Input);

UPDATE WatchedMovies
SET watched_date = @watched_date_Input
WHERE userId = @userIdInput AND movieId = @movieIdInput;

DELETE FROM WatchedMovies
WHERE userId = @userIdInput AND movieId = @movieIdInput;
