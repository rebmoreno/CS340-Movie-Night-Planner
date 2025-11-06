--Users table
SELECT userId, name, email FROM Users
INSERT INTO Users (name, email)
VALUES (@nameInput, @emailInput)
UPDATE Users 
    SET name = @nameInput 
    AND email = @emailInput 
    WHERE userId = @userIdInput
DELETE FROM Users WHERE userId = @userIdInput;

--SavedMovies table
SELECT 
    Users.name AS user_name,
    Movies.title AS movie_title,
    SavedMovies.saved_date
FROM SavedMovies
INNER JOIN Users ON SavedMovies.userId = Users.userId
INNER JOIN Movies ON SavedMovies.movieId = Movies.movieId
INSERT INTO SavedMovies (userId, movieId, saved_date)
VALUES (@userIdInput, @movieIdInput, @savedDateInput)
UPDATE SavedMovies
    SET saved_date = @savedDateInput
    WHERE userId = @userIdInput 
    AND movieId = @movieIdInput
DELETE FROM SavedMovies WHERE userId = @userIdInput AND movieId = @movieIdInput;
