-- Tables and Values for Movie Database
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Prisha's Movie Database DDL
CREATE OR REPLACE TABLE Users (
    userId INT AUTO_INCREMENT UNIQUE NOT NULL,
    name varchar(100),
    email varchar(255) NOT NULL UNIQUE,
    PRIMARY KEY (userId)
);

CREATE OR REPLACE TABLE SavedMovies (
    userId int NOT NULL,
    movieId int NOT NULL,
    saved_date DATE DEFAULT CURRENT_DATE NOT NULL,
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (movieId) REFERENCES Movies(movieId)
);

INSERT INTO Users (
    name,
    email
) 
VALUES
(
    'John Smith',
    'JoSmith@gmail.com'
),
(
    'Jane Doe',
    'JaDoe@gmail.com'
),
(
    'Scarlett Johanson',
    'ScarJo@gmail.com'
);

INSERT INTO SavedMovies (
    saved_date
)
VALUES
(
    "2025-03-05"
),
(
    "2025-05-10"
),
(
    "2025-01-05"
);

-- Rebeca's Movie Database DDL
CREATE OR REPLACE TABLE Movies (
    movieID INT AUTO_INCREMENT UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NULL,
    release_date DATE NULL,
    lead_actor VARCHAR(150) NULL,
    streaming_platform VARCHAR(100) NULL,
    PRIMARY KEY (movieID)
);

CREATE OR REPLACE TABLE WatchedMovies (
    userID INT NOT NULL,
    movieID INT NOT NULL,
    watched_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (userID, movieID),
    FOREIGN KEY (movieID) REFERENCES Movies(movieID)
    FOREIGN KEY (userID) REFERENCES Users(userID),
);

INSERT INTO Movies (title, genre, release_date, lead_actor, streaming_platform)
VALUES
('A House of Dynamite', 'Thriller', '2025-09-02', 'Idris Elba', 'Netflix'),
('Wicked', 'Fantasy', '2024-11-22', 'Cythia Erivo', 'Prime Video'),
('The Night Before Christmas', 'Fantasy', '1993-10-29', 'Bing Crosby', 'Disney+');

INSERT INTO WatchedMovies (userID, movieID, watched_date)
VALUES
(1, 1, '2025-09-10'),
(2, 1, '2025-09-15'),
(2, 3, '2023-12-25');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;