-- Group 64: Rebeca Moreno Rodriguez, Prisha Velhal
-- Movie Night Planner Management System
-- PL/SQL Stored Procedures
-- Citation: Structure based on sp_moviedb.sql example from CS340 course materials
-- Originality: 
-- sp_ResetDatabase - Database recreation logic and sample data specific to Movie Night Planner
-- sp_DeleteJohnSmith - Demonstrates CASCADE delete functionality
-- sp_AddUser - INSERT operation for Users table
-- sp_UpdateUser - UPDATE operation for Users table
-- sp_DeleteUser - DELETE operation with CASCADE to junction tables
-- AI Usage: No AI tools were used in developing this application code.

-- RESET DATABASE STORED PROCEDURE
DROP PROCEDURE IF EXISTS sp_ResetDatabase;

DELIMITER //
CREATE PROCEDURE sp_ResetDatabase()
BEGIN
    SET FOREIGN_KEY_CHECKS=0;
    
    -- Drop existing tables to avoid conflicts
    DROP TABLE IF EXISTS WatchedMovies;
    DROP TABLE IF EXISTS SavedMovies;
    DROP TABLE IF EXISTS Movies;
    DROP TABLE IF EXISTS Users;
    
    -- Create Users table
    CREATE TABLE Users (
        userId INT AUTO_INCREMENT NOT NULL,
        name VARCHAR(100),
        email VARCHAR(255) NOT NULL UNIQUE,
        PRIMARY KEY (userId)
    );
    
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
    
    -- Insert sample Users
    INSERT INTO Users (name, email) VALUES
    ('John Smith', 'JoSmith@gmail.com'),
    ('Jane Doe', 'JaDoe@gmail.com'),
    ('Scarlett Johansson', 'ScarJo@gmail.com');
    
    -- Insert sample Movies
    INSERT INTO Movies (title, genre, release_date, lead_actor, streaming_platform) VALUES
    ('A House of Dynamite', 'Thriller', '2025-09-02', 'Idris Elba', 'Netflix'),
    ('Wicked', 'Fantasy', '2024-11-22', 'Cynthia Erivo', 'Prime Video'),
    ('The Night Before Christmas', 'Fantasy', '1993-10-29', 'Bing Crosby', 'Disney+');
    
    -- Insert sample SavedMovies
    INSERT INTO SavedMovies (userId, movieId, saved_date) VALUES
    (1, 2, '2025-03-05'),
    (2, 2, '2025-05-10'),
    (1, 3, '2025-01-05');
    
    -- Insert sample WatchedMovies
    INSERT INTO WatchedMovies (userId, movieId, watched_date) VALUES
    (1, 1, '2025-09-10'),
    (2, 1, '2025-09-15'),
    (2, 3, '2023-12-25');
    
    SET FOREIGN_KEY_CHECKS=1;
END //
DELIMITER ;

-- DEMO CUD OPERATION - Delete a specific user
DROP PROCEDURE IF EXISTS sp_DeleteJohnSmith;

DELIMITER //
CREATE PROCEDURE sp_DeleteJohnSmith()
BEGIN
    -- This will cascade delete SavedMovies and WatchedMovies for this user
    DELETE FROM Users WHERE name = 'John Smith' AND email = 'JoSmith@gmail.com';
END //
DELIMITER ;

-- CREATE/INSERT STORED PROCEDURE
-- Add a new user to the Users table
DROP PROCEDURE IF EXISTS sp_AddUser;

DELIMITER //
CREATE PROCEDURE sp_AddUser(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(255)
)
BEGIN
    INSERT INTO Users (name, email) VALUES (p_name, p_email);
END //
DELIMITER ;

-- UPDATE STORED PROCEDURE
-- Update an existing user's information
DROP PROCEDURE IF EXISTS sp_UpdateUser;

DELIMITER //
CREATE PROCEDURE sp_UpdateUser(
    IN p_userId INT,
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(255)
)
BEGIN
    UPDATE Users 
    SET name = p_name, email = p_email 
    WHERE userId = p_userId;
END //
DELIMITER ;

-- DELETE STORED PROCEDURE
-- Delete a user (will cascade to SavedMovies and WatchedMovies)
DROP PROCEDURE IF EXISTS sp_DeleteUser;

DELIMITER //
CREATE PROCEDURE sp_DeleteUser(
    IN p_userId INT
)
BEGIN
    DELETE FROM Users WHERE userId = p_userId;
END //
DELIMITER ;
