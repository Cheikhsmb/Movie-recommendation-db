
CREATE DATABASE movie_recommendation;
USE movie_recommendation;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    release_year INT,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);

CREATE TABLE Ratings (
    user_id INT,
    movie_id INT,
    rating DECIMAL(2,1) CHECK (rating >= 1.0 AND rating <= 5.0),
    rated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE WatchHistory (
    watch_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    watched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

INSERT INTO Genres (genre_name) VALUES
('Action'), ('Comedy'), ('Drama'), ('Sci-Fi'), ('Romance');

INSERT INTO Users (username, email) VALUES
('Ndié', 'ndie@example.com'),
('Bamba', 'bamba@example.com'),
('Fallou', 'fallou@example.com');

INSERT INTO Movies (title, release_year, genre_id) VALUES
('The Matrix', 1999, 4), -- Sci-Fi
('Inception', 2010, 4), -- Sci-Fi
('Superbad', 2007, 2), -- Comedy
('The Dark Knight', 2008, 1), -- Action
('Titanic', 1997, 5); -- Romance

INSERT INTO Ratings (user_id, movie_id, rating) VALUES
(1, 1, 4.5), -- Ndié rates The Matrix
(1, 2, 4.0), -- Ndié rates Inception
(1, 3, 3.0), -- Ndié rates Superbad
(2, 1, 4.0), -- Bamba rates The Matrix
(2, 4, 5.0), -- Bamba rates The Dark Knight
(3, 2, 4.5), -- Fallou rates Inception
(3, 3, 4.0); -- Fallou rates Superbad

INSERT INTO WatchHistory (user_id, movie_id, watched_at) VALUES
(1, 1, '2025-05-01 10:00:00'), -- Ndié watched The Matrix
(1, 3, '2025-05-02 15:00:00'), -- Ndié watched Superbad
(2, 4, '2025-05-03 20:00:00'), -- Bamba watched The Dark Knight
(3, 2, '2025-05-04 18:00:00'); -- Fallou watched Inception



