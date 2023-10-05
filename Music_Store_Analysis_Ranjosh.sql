-- 1] Who is the senior most employee based on job title.
SELECT * FROM employee
ORDER BY levels DESC
limit 1
-- Answer- Madan Mohan (Senior General Manager)

-- 2] Which countries have the most invoices
SELECT billing_country,COUNT(*) FROM invoice
GROUP BY billing_country
ORDER BY COUNT(*) DESC
LIMIT 5
-- USA,Canada, Brazil, France, Germany

-- 3] What are top 3 values of total invoice.
SELECT total FROM invoice
ORDER BY total DESC
LIMIT 3
-- 23.76 ,19.8 and 19.8 Dollars

-- 4] Which city has the best customers? We would like to throw a promotional Music Festival in the city
-- we made the most money. Write a query that returns one city that has the highest sum of invoice totals.
-- Return both the city name and sum of all invoice totals.
SELECT billing_city,SUM(total) AS invoice_totals FROM invoice
GROUP BY billing_city
ORDER BY SUM(total) DESC
LIMIT 1
-- Prague has the most sales with 273 dollars as total amount.

-- 5] Who is the best customer? The customer who has spent the most money will be declared as the best customer.
-- Write a query that returns the person who has spent the most money.
SELECT customer_id,SUM(total) FROM invoice
GROUP BY customer_id
ORDER BY SUM(total) DESC
LIMIT 1
-- Customer with customer_id 5 is the best customer.

-- 6]Write a query to return the email, first name, last name & Genre of all Rock music listeners. 
-- Return your list ordered alphabetically by email starting with A. 
-- Rock music listeners are customers.
-- This contains all rock tracks
(SELECT * FROM track
 WHERE genre_id=(SELECT genre_id FROM genre WHERE name='Rock'))
 
-- Final answer
SELECT DISTINCT customer.first_name, customer.last_name, customer.email,gen.genre_id FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id
JOIN (SELECT * FROM track WHERE genre_id=(SELECT genre_id FROM genre WHERE name='Rock')) AS gen ON invoice_line.track_id=gen.track_id
ORDER BY customer.email asc

-- 7]Let's invite the artists who have written the most rock music in our dataset. Write a query that returns
-- the artist name and total track count of the top 10 rock bands.
SELECT artist.name,COUNT(*) as total_track_count
FROM album
JOIN (SELECT * FROM track WHERE genre_id=(SELECT genre_id FROM genre WHERE name='Rock')) AS gen ON gen.album_id=album.album_id
JOIN artist ON album.artist_id=artist.artist_id
GROUP BY artist.artist_id
ORDER BY COUNT(*) DESC
LIMIT 10
-- Table which has only rock music tracks IS gen
-- Artist table has unique artist names and ids.
-- Album table has unique albums but artists repeat.[One artist might have multiple albums]
-- Track album has multiple tracks from one album. and more details about those tracks.
-- Genre id has unique genres.
-- RESULT- Led Zeppelin with 114 Tracks,U2 with 112 Tracks, Deep Purple with 92 Tracks.

--8]Return all the track names that have a song length longer than the average song length. 
-- Return the Name and milliseconds for each track. Order by the song length with the longest songs listed first.

-- Average song length
SELECT AVG(milliseconds) FROM track

-- Main Query
SELECT name,milliseconds FROM track
WHERE milliseconds>(SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC
-- Returned 494 Tracks out of 3503.

