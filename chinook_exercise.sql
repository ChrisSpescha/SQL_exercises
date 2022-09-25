/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE

--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/

SELECT name, COUNT(title) as total_albums FROM artists
    LEFT OUTER JOIN albums
    ON artists.ArtistId == albums.ArtistId
    GROUP BY name
    HAVING total_albums < 1;

/* TASK II
Which artists recorded any tracks of the Latin genre?
*/

SELECT genres.name, artists.name FROM genres
    JOIN tracks
    ON genres.GenreId == tracks.GenreId
    JOIN albums
    ON tracks.AlbumId == albums.AlbumId
    JOIN artists
    ON artists.ArtistId == albums.ArtistId
    GROUP BY artists.Name
    HAVING genres.name = 'Latin';

/* TASK III
Which video track has the longest length?
*/

SELECT tracks.name, MAX(Milliseconds) FROM media_types
    JOIN tracks
    ON tracks.MediaTypeId == media_types.MediaTypeId;



/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/

SELECT FirstName, city, ReportsTo FROM employees;

SELECT FirstName, LastName FROM customers
    WHERE city = 'Edmonton';

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT employees.FirstName FROM employees
    JOIN customers
    ON customers.SupportRepId == employees.EmployeeId
    WHERE customers.Country == 'Brazil'
    GROUP BY employees.FirstName;


/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT playlists.name FROM playlists
    JOIN playlist_track
    ON playlists.PlaylistId == playlist_track.PlaylistId
    JOIN tracks
    ON tracks.TrackId == playlist_track.TrackId
    JOIN genres
    ON genres.GenreId = tracks.GenreId
    GROUP BY playlists.name
    HAVING genres.name != 'latin'
    ;