--- 28-05-2021 23:21:20
--- SQLite
CREATE TABLE User
(
	UserID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
	FirstName VARCHAR NOT NULL,
	LastName VARCHAR NOT NULL,
	Birthplace VARCHAR NOT NULL,
	CreatedAt DATETIME NOT NULL,
	UpdatedAt DATETIME NULL
);

CREATE TABLE Favorite 
(
	FavoriteID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
	UserID INTEGER NOT NULL,
	ArtistID INTEGER, 
	AlbumID INTEGER,
	SongID INTEGER,
	GenreID INTEGER,
	CreatedAt DATETIME NOT NULL,
	UpdatedAt DATETIME NULL,
	FOREIGN KEY (UserID) REFERENCES User (UserID),
	FOREIGN KEY (ArtistID) REFERENCES artists (id),
	FOREIGN KEY (AlbumID) REFERENCES albums (id),
	FOREIGN KEY (SongID) REFERENCES songs (id),
	FOREIGN KEY (GenreID) REFERENCES genres (id)
);

--- 28-05-2021 23:21:59
--- SQLite
INSERT INTO User 
(
  FirstName, 
  LastName,
  Birthplace,
  CreatedAt
)  
VALUES 
(	
  'Wesley', 
  'Chambers', 
  'Orlando, Florida',
  CURRENT_DATE
);

INSERT INTO User 
(
  FirstName, 
  LastName,
  Birthplace,
  CreatedAt
)  
VALUES 
(	
  'Michael', 
  'Jordan', 
  'Brooklyn, New York',
  CURRENT_TIMESTAMP
);

--- 28-05-2021 23:22:28
--- SQLite
SELECT * FROM artists; --We selected everything: all columns and all rows.;

--- 28-05-2021 23:22:37
--- SQLite
SELECT name FROM songs;	--We selected one column and all rows.;

--- 28-05-2021 23:22:51
--- SQLite
SELECT 
	id, 
	name, 
	created_at 
FROM songs; --You get the idea!;

--- 28-05-2021 23:23:04
--- SQLite
/***** ERROR ******
near "(": syntax error
 ----- 
SELECT * FROM songs WHERE length > '5:00'; 
--We selected only those rows with songs that are longer than five minutes. 
(The time is in single tick marks because that column is of data type VARCHAR.);
*****/

--- 28-05-2021 23:23:21
--- SQLite
SELECT * FROM songs WHERE length > '5:00';

--- 28-05-2021 23:23:40
--- SQLite
SELECT * FROM User WHERE LastName IN ('Jordan', 'Brown', 'Ashley', 'Carnegie');

--- 28-05-2021 23:23:47
--- SQLite
SELECT * FROM User WHERE FirstName = 'Wesley' AND LastName = 'Chambers';
SELECT * FROM User WHERE FirstName = 'Wesley' OR LastName = 'Jordan'; 
--Note the difference between these first two SELECT statements.

SELECT * FROM User WHERE UserID > 1 OR (UpdatedAt IS NULL AND FirstName = 'Florence');

SELECT * FROM User WHERE FirstName LIKE '%ley';
SELECT * FROM User WHERE FirstName LIKE '%esl%';
SELECT * FROM User WHERE FirstName LIKE '%sle%' OR LastName LIKE 'Jor%';

--- 28-05-2021 23:24:20
--- SQLite
SELECT * FROM artists WHERE id > 1 AND id < 6;

--- 28-05-2021 23:24:32
--- SQLite
SELECT * FROM songs WHERE name GLOB 'Man*'; 
--the '*' means any amount of character or number

SELECT * FROM songs WHERE name GLOB '*Know';

SELECT * FROM songs WHERE name GLOB '*ake*';

SELECT * FROM songs WHERE name GLOB '*8*';

SELECT * FROM songs WHERE name GLOB '??? Learn'; 
--the question mark means exactly one character or number

SELECT * FROM songs WHERE name GLOB 'Mary ????';

SELECT * FROM songs WHERE name GLOB '??on??';

--- 28-05-2021 23:25:00
--- SQLite

SELECT * FROM songs WHERE name GLOB '*Know';

--- 28-05-2021 23:25:23
--- SQLite
INSERT INTO User 
(
	FirstName,
  	LastName,
  	Birthplace,
  	CreatedAt
)
VALUES 
(
	'Florence',
  	'Griffith-Joyner',
  	'Littlerock, California',
  	CURRENT_TIMESTAMP
),
(
	'Tom',
  	'Brady',
  	'San Mateo, California',
  	CURRENT_DATE
);

--- 28-05-2021 23:25:43
--- SQLite
UPDATE artists SET name = 'Janet Jackson' WHERE name LIKE 'janet Jackson';

--- 28-05-2021 23:25:50
--- SQLite
UPDATE User 
SET FirstName = 'Wesley A.',
	LastName = 'Chambers IV',
	UpdatedAt = CURRENT_TIMESTAMP
WHERE UserID = 1;

--- 28-05-2021 23:26:00
--- SQLite
BEGIN TRANSACTION;
	UPDATE User SET FirstName = 'Hey, change my name me back!';
    SELECT * FROM User;
ROLLBACK;

--- 28-05-2021 23:26:26
--- SQLite
BEGIN TRANSACTION;

  DELETE FROM User; 

  SELECT * FROM User; 
  --this SELECT is here to help you see what would have happened in the delete statement.
  --You don't need it in order to delete. 

ROLLBACK;

--- 28-05-2021 23:26:40
--- SQLite
BEGIN TRANSACTION;
    DELETE FROM songs WHERE id BETWEEN 5 AND 10;

    SELECT * FROM songs WHERE id < 11; 
    --See that record 5-10 would have been deleted if the rollback had not occurred.

ROLLBACK;

--- 28-05-2021 23:27:55
--- SQLite
SELECT * FROM Favorite;

--- 28-05-2021 23:28:50
--- SQLite
SELECT 
	album_id, 
	SUM(length) AS Minutes 
FROM songs GROUP BY album_id;

--- 28-05-2021 23:29:00
--- SQLite
SELECT albums.id, albums.name, SUM(songs.length) AS Minutes 
FROM songs 
INNER JOIN albums ON songs.album_id = albums.id
GROUP BY albums.id;

--- 28-05-2021 23:29:08
--- SQLite
SELECT albums.id, albums.name, SUM(songs.length) AS Minutes 
FROM songs 
INNER JOIN albums ON songs.album_id = albums.id
GROUP BY albums.id;

--- 28-05-2021 23:29:15
--- SQLite
SELECT 
	albums.name,
	songs.name, 
	songs.length AS Minutes 
FROM albums 
LEFT JOIN songs ON albums.id = songs.album_id
ORDER BY albums.name, Minutes;

--- 28-05-2021 23:29:29
--- SQLite
SELECT 
    artists.name AS Artist,
    songs.name AS Song,
    songs.length AS Minutes,
	albums.name AS Album,
    albums.label AS Label,
    albums.year_released AS Released
FROM albums
INNER JOIN songs ON albums.id = songs.album_id 
INNER JOIN artists ON albums.artist_id = artists.id
GROUP BY albums.name
ORDER BY artists.name;

--- 28-05-2021 23:29:42
--- SQLite
SELECT 
	albums.name,
	songSubSelect.name, 
	songSubSelect.length AS Minutes 
FROM albums 
INNER JOIN 
(
	SELECT * FROM songs
) songSubSelect ON albums.id = songSubSelect.album_id;

--- 28-05-2021 23:29:58
--- SQLite
SELECT id, name, created_at FROM songs --a dataset

UNION ALL

SELECT id, name, updated_at FROM albums --another dataset;

--- 28-05-2021 23:30:08
--- SQLite
SELECT * FROM songs 

UNION 

SELECT * FROM songs;

--- 28-05-2021 23:30:34
--- SQLite
SELECT album_id, name FROM songs 

INTERSECT

SELECT id, name FROM albums;

--- 28-05-2021 23:30:46
--- SQLite
SELECT COUNT(album_id) FROM
(
    SELECT album_id, name FROM songs
    INTERSECT
    SELECT id, name FROM albums);

--- 28-05-2021 23:31:01
--- SQLite
SELECT album_id, name, created_at FROM songs 

INTERSECT

SELECT id, name, created_at FROM albums;

--- 28-05-2021 23:31:14
--- SQLite
SELECT name 
FROM songs
WHERE album_id < 65

EXCEPT 

SELECT name
FROM songs
WHERE name = 'Ironic';

--- 28-05-2021 23:31:47
--- SQLite
SELECT DISTINCt album_id FROM songs; --71
--vs
SELECT album_id FROM songs; -- 799;

--- 28-05-2021 23:35:13
--- SQLite
SELECT * FROM Favorite;

--- 28-05-2021 23:35:17
--- SQLite
SELECT * FROM Favorite;

--- 28-05-2021 23:35:45
--- SQLite
SELECT * FROM User;

--- 28-05-2021 23:37:48
--- SQLite
INSERT INTO Favorite
(userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(3, NULL, NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--- 28-05-2021 23:38:09
--- SQLite
SELECT * FROM Favorite;

--- 28-05-2021 23:56:28
--- SQLite
/***** ERROR ******
no such column: albums_id
 ----- 
SELECT albums.id, albums.name, user.firstname AS name FROM albums
INNER JOIN songs ON albums.id = albums_id
INNER JOIN artists ON albums.artists_id = artists.id
INNEr JOIN user ON albums.user_id = user.id
GROUP BY albums.name
ORDER BY user.name;
*****/

--- 28-05-2021 23:59:31
--- SQLite
/***** ERROR ******
no such column: albums_id
 ----- 
SELECT albums.id, albums.name, user.firstname FROM albums
INNER JOIN songs ON albums.id = albums_id
INNER JOIN artists ON albums.artists_id = artists.id
INNEr JOIN user ON albums.user_id = user.id
GROUP BY albums.name
ORDER BY user.name;
*****/

--- 29-05-2021 00:04:48
--- SQLite
/***** ERROR ******
near "AS": syntax error
 ----- 
SELECT albums.name, albums.id FROM albums
WHERE SUM (length AS minutes > 5);
*****/

--- 29-05-2021 00:04:57
--- SQLite
/***** ERROR ******
near "AS": syntax error
 ----- 
SELECT albums.name, albums.id FROM albums
WHERE SUM
(length AS minutes > 5);
*****/

--- 29-05-2021 00:07:53
--- SQLite
/***** ERROR ******
near "SELECT": syntax error
 ----- 
SELECT albums.name, albums.id FROM albums
SELECT song.length AS minutes
WHERE SUM (length);
*****/

--- 29-05-2021 00:13:32
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 00:21:33
--- SQLite
SELECT * FROM albums;

--- 29-05-2021 00:21:48
--- SQLite
SELECT * FROM artists;

--- 29-05-2021 00:22:04
--- SQLite
SELECT * FROM songs;

--- 29-05-2021 00:24:33
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:25:46
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 00:26:54
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:27:02
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 00:27:17
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 00:27:26
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:27:39
--- SQLite
SELECT * FROM User;

--- 29-05-2021 00:28:01
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 00:28:08
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 00:28:16
--- SQLite
SELECT * FROM User;

--- 29-05-2021 00:28:47
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:29:20
--- SQLite
SELECT * FROM artists;

--- 29-05-2021 00:29:50
--- SQLite
SELECT * FROM songs;

--- 29-05-2021 00:30:11
--- SQLite
SELECT * FROM artists;

--- 29-05-2021 00:30:26
--- SQLite
SELECT * FROM albums;

--- 29-05-2021 00:30:37
--- SQLite
SELECT * FROM songs;

--- 29-05-2021 00:33:00
--- SQLite
/***** ERROR ******
no such column: songid
 ----- 
SELECT
    songid,
    songs.name AS track,
    albums.title AS album,
    artists.name AS artist
FROM
    songs
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
*****/

--- 29-05-2021 00:33:09
--- SQLite
/***** ERROR ******
no such column: songsid
 ----- 
SELECT
    songsid,
    songs.name AS track,
    albums.title AS album,
    artists.name AS artist
FROM
    songs
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
*****/

--- 29-05-2021 00:33:28
--- SQLite
/***** ERROR ******
near ".": syntax error
 ----- 
SELECT
    songsid,
    songs.name
    albums.title
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
*****/

--- 29-05-2021 00:33:37
--- SQLite
/***** ERROR ******
no such column: songsid
 ----- 
SELECT
    songsid,
    songs.name,
    albums.title,
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
*****/

--- 29-05-2021 00:33:56
--- SQLite
/***** ERROR ******
no such column: song.id
 ----- 
SELECT
    song.id,
    songs.name,
    albums.title,
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
*****/

--- 29-05-2021 00:34:04
--- SQLite
/***** ERROR ******
no such column: albums.title
 ----- 
SELECT
    songs.name,
    albums.title,
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
*****/

--- 29-05-2021 00:34:14
--- SQLite
/***** ERROR ******
no such column: albums.albumid
 ----- 
SELECT
    songs.name,
    albums.name,
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
*****/

--- 29-05-2021 00:34:29
--- SQLite
/***** ERROR ******
no such column: albums.albumid
 ----- 
SELECT
    songs.name,
    albums.name,
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.albumid = songs.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
*****/

--- 29-05-2021 00:34:50
--- SQLite
/***** ERROR ******
no such column: albums.albumid
 ----- 
SELECT
    songs.name,
    albums.name,
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.albumid = songs.album_id
    INNER JOIN artists ON artists.artistid = albums.artist_id;
*****/

--- 29-05-2021 00:35:03
--- SQLite
/***** ERROR ******
no such column: albums.album.id
 ----- 
SELECT
    songs.name,
    albums.name,
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.album.id = songs.album_id
    INNER JOIN artists ON artists.artist.id = albums.artist_id;
*****/

--- 29-05-2021 00:35:18
--- SQLite
SELECT
    songs.name,
    albums.name,
    artists.name
FROM
    songs
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:36:00
--- SQLite
SELECT
    songs.name AS 'Song Name',
    albums.name AS 'Album Name',
    artists.name AS 'Artist Name'
FROM
    songs
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:37:05
--- SQLite
/***** ERROR ******
near "albums": syntax error
 ----- 
SELECT
    songs.name AS 'Song Name',
    songs.id AS 'Song ID'
    albums.name AS 'Album Name',
    artists.name AS 'Artist Name'
FROM
    songs
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;
*****/

--- 29-05-2021 00:37:11
--- SQLite
SELECT
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    artists.name AS 'Artist Name'
FROM
    songs
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:38:03
--- SQLite
SELECT
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:38:53
--- SQLite
/***** ERROR ******
no such column: genres.name
 ----- 
SELECT
	genres.name As 'Genre Name',
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;
*****/

--- 29-05-2021 00:39:09
--- SQLite
/***** ERROR ******
no such column: genres.name
 ----- 
SELECT
	genres.name As 'Genre Name',
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;
*****/

--- 29-05-2021 00:39:20
--- SQLite
/***** ERROR ******
no such column: genres.id
 ----- 
SELECT
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;
*****/

--- 29-05-2021 00:39:52
--- SQLite
SELECT
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs, genres
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:40:14
--- SQLite
SELECT
	genres.name as 'Genre Name',
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs, genres
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:42:43
--- SQLite
INSERT INTO Favorite
(userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(1, 14, 1, 1, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--- 29-05-2021 00:42:48
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:43:34
--- SQLite
SELECT
	genres.name as 'Genre Name',
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs, genres
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:44:29
--- SQLite
INSERT INTO Favorite
(userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(1, 14, 1, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--- 29-05-2021 00:44:34
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:45:59
--- SQLite
/***** ERROR ******
no such column: favorite.id
 ----- 
DELETE FROM Favorite
WHERE favorite.id = 2;
*****/

--- 29-05-2021 00:46:10
--- SQLite
/***** ERROR ******
no such column: id
 ----- 
DELETE FROM Favorite
WHERE id = 2;
*****/

--- 29-05-2021 00:46:20
--- SQLite
DELETE FROM Favorite
WHERE FavoriteID = 2;

--- 29-05-2021 00:46:25
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:46:45
--- SQLite
SELECT
	genres.name as 'Genre Name',
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs, genres
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:47:48
--- SQLite
INSERT INTO Favorite
(userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(4, 13, 4, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--- 29-05-2021 00:47:52
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:48:30
--- SQLite
SELECT
	genres.name as 'Genre Name',
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs, genres
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:49:12
--- SQLite
INSERT INTO Favorite
(favoriteid, userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(2, 2, 25, 8, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--- 29-05-2021 00:49:15
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:49:30
--- SQLite
SELECT * FROM User;

--- 29-05-2021 00:49:54
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:50:55
--- SQLite
DELETE FROM Favorite
WHERE FavoriteID = 2;

--- 29-05-2021 00:50:58
--- SQLite
INSERT INTO Favorite
(userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(2, NULL, NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--- 29-05-2021 00:51:01
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:51:17
--- SQLite
DELETE FROM Favorite
WHERE FavoriteID = 5;

--- 29-05-2021 00:51:20
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:51:55
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:52:04
--- SQLite
INSERT INTO Favorite
(favoriteid, userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(2, 2, NULL, NULL, NULL, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

--- 29-05-2021 00:52:06
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 00:52:28
--- SQLite
SELECT
	genres.name as 'Genre Name',
    genres.id AS 'Genre ID',
    songs.name AS 'Song Name',
    songs.id AS 'Song ID',
    albums.name AS 'Album Name',
    albums.id AS 'Album ID',
    artists.name AS 'Artist Name',
    artists.id AS 'Artist ID'
FROM
    songs, genres
    INNER JOIN albums ON albums.id = songs.album_id
    INNER JOIN artists ON artists.id = albums.artist_id;

--- 29-05-2021 00:53:05
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 00:55:32
--- SQLite
/***** ERROR ******
no such column: songs.al
 ----- 
SELECT albums.name, albums.id, SUM(songs.length) AS minutes
FROM albums
LEFT JOIN songs ON albums.id = songs.al;
*****/

--- 29-05-2021 00:56:17
--- SQLite
SELECT albums.name, albums.id, SUM(songs.length) AS minutes
FROM albums
LEFT JOIN songs ON albums.id = songs.album_id
GROUP By albums.id
HAVING SUM(songs.length) > 5;

--- 29-05-2021 00:57:09
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 00:59:24
--- SQLite
SELECT albums.name, albums.id, SUM(songs.length) AS minutes
FROM albums
LEFT JOIN songs ON albums.id = songs.album_id
GROUP By albums.id
HAVING SUM(songs.length) > 5;

--- 29-05-2021 00:59:28
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 01:01:16
--- SQLite
SELECT albums.name, albums.id, SUM(songs.length) AS minutes
FROM albums
LEFT JOIN songs ON albums.id = songs.album_id
GROUP By albums.id
HAVING SUM(songs.length) > 5;

--- 29-05-2021 01:02:40
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 01:02:55
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 01:04:23
--- SQLite
/***** ERROR ******
9 values for 8 columns
 ----- 
INSERT INTO Favorite
(favoriteid, userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(5, 1, 2, 25, 8, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM Favorite;
*****/

--- 29-05-2021 01:05:07
--- SQLite
INSERT INTO Favorite
(favoriteid, userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(5, 2, 25, 8, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM Favorite;

--- 29-05-2021 01:05:35
--- SQLite
/***** ERROR ******
UNIQUE constraint failed: Favorite.FavoriteID
 ----- 
INSERT INTO Favorite
(favoriteid, userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(5, 5, 25, 8, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM Favorite;
*****/

--- 29-05-2021 01:05:43
--- SQLite
INSERT INTO Favorite
(favoriteid, userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(6, 5, 25, 8, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM Favorite;

--- 29-05-2021 01:06:01
--- SQLite
DELETE FROM Favorite
WHERE FavoriteID = 5;

--- 29-05-2021 01:06:10
--- SQLite
INSERT INTO Favorite
(favoriteid, userid, songid, genreid, artistid, albumid, createdat, updatedat)
VALUES
(5, 5, 25, 8, 4, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT * FROM Favorite;

--- 29-05-2021 01:06:16
--- SQLite
DELETE FROM Favorite
WHERE FavoriteID = 6;

--- 29-05-2021 01:06:26
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 01:06:31
--- SQLite
SELECT * FROM User;

--- 29-05-2021 01:06:53
--- SQLite


SELECT * FROM Favorite;

--- 29-05-2021 01:08:08
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

--- 29-05-2021 01:08:23
--- SQLite
SELECT * FROM User;

--- 29-05-2021 01:09:47
--- SQLite
INSERT INTO User 
(
	FirstName,
  	LastName,
  	Birthplace,
  	CreatedAt
)
VALUES 
(
	'Elon',
  	'Musk',
  	'Pretoria, South Africa',
  	CURRENT_TIMESTAMP
);

--- 29-05-2021 01:09:50
--- SQLite
SELECT * FROM User;

--- 29-05-2021 01:10:05
--- SQLite
SELECT * FROM Favorite;

--- 29-05-2021 01:10:13
--- SQLite
SELECT user.firstname, user.lastname, artists.name AS 'Fav Artist',
    albums.name AS 'Fav Album',
    songs.name AS 'Fav Song',
    genres.name AS 'Fav Genre'
FROM User
	LEFT JOIN Favorite
    ON user.userid = favorite.userid
    LEFT JOIN artists
    ON favorite.artistid = artists.id
    LEFT JOIN albums
    ON favorite.albumid = albums.id
    LEFT JOIN songs
    ON favorite.songid = songs.id
    LEFT JOIN genres
    ON favorite.genreid = genres.id;

