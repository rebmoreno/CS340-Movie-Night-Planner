--Users table
SELECT userId, name, email FROM Users;
INSERT INTO Users (name, email)
VALUES (@nameInput, @emailInput);
UPDATE Users SET name = @nameInput, email = @emailInput WHERE userId = @userIdInput;
DELETE FROM Users WHERE userId = @userIdInput;

--SavedMovies table
SELECT userId, movieId, watched_date FROM SavedMovies;
INSERT INTO SavedMovies (userId, movieId, saved_date)
VALUES (@userIdInput, @movieIdInput, CURRENT_DATE);
DELETE FROM SavedMovies WHERE userId = @userIdInput AND movieId = @movieIdInput;