-- Tables and Values for Movie Database
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
