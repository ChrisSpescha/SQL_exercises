/* SQL Stretch Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


--==================================================================
/* TASK I
How many audio tracks in total were bought by German customers? And what was the total price paid for them?
hint: use subquery to find all of tracks with their prices
*/

SELECT COUNT(UnitPrice), SUM(UnitPrice) FROM tracks
    WHERE TrackId IN (SELECT invoice_items.TrackId FROM customers
    JOIN invoices
    ON customers.CustomerId = invoices.InvoiceId
    JOIN invoice_items 
    ON invoices.InvoiceId == invoice_items.InvoiceId
    WHERE customers.Country = 'Germany')
    ;

/* TASK II
What is the space, in bytes, occupied by the playlist “Grunge”, and how much would it cost?
(Assume that the cost of a playlist is the sum of the price of its constituent tracks).
*/

SELECT SUM(Bytes), SUM(UnitPrice) from tracks
    JOIN playlist_track
    ON tracks.TrackId = playlist_track.TrackId
    JOIN playlists
    ON playlist_track.PlaylistId = playlists.PlaylistId
    WHERE playlists.Name = 'Grunge';


/* TASK III
List the names and the countries of those customers who are supported 
by an employee who was younger than 35 when hired. 
*/

SELECT customers.FirstName, customers.Country FROM customers
    JOIN employees
    ON customers.SupportRepId = employees.EmployeeId
    WHERE employees.employeesID IN (SELECT EmployeeId, HireDate - BirthDate as age_hired FROM employees
    WHERE age_hired < 35;);



    