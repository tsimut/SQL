USE sakila;
SELECT first_name, last_name FROM actor;
SELECT CONCAT_WS(" ",first_name,last_name) 
AS "Actor Name" FROM actor;
SELECT actor_id,first_name,last_name FROM actor
WHERE first_name="Joe";
SELECT first_name,last_name FROM actor
WHERE last_name LIKE "%gen%";
SELECT last_name,first_name FROM actor
WHERE last_name LIKE "%li%";
SELECT country_id,country FROM country
WHERE country IN ("Afghanistan","Bangladesh","China");
ALTER TABLE actor
ADD description BLOB;
ALTER TABLE actor
DROP COLUMN description;
SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name;
SELECT last_name, COUNT(*)
FROM actor 
GROUP BY last_name
HAVING COUNT(*)>1;
UPDATE actor
SET first_name="HARPO",last_name="WILLIAMS"
WHERE first_name="GROUCHO";
UPDATE actor SET first_name="GROUCHO" WHERE first_name="HARPO";
SHOW CREATE TABLE address;
SELECT staff.first_name,staff.last_name,address.address
FROM address
INNER JOIN staff ON address.address_id=staff.address_id;
SELECT staff.first_name, payment.payment_date, SUM(payment.amount) total_payment
FROM payment
INNER JOIN staff ON payment.staff_id=staff.staff_id
WHERE YEAR(payment.payment_date)="2005" AND MONTH(payment.payment_date)="08" 
GROUP BY staff.first_name,payment.payment_date;
SELECT film.title, COUNT(film_actor.actor_id) total_actors
FROM film
INNER JOIN film_actor ON film.film_id=film_actor.film_id
GROUP BY film.title;
SELECT COUNT(film_id) FROM film
WHERE title="hunchback impossible";
SELECT customer.first_name, customer.last_name, SUM(payment.amount) Total_Amount_Paid
FROM payment
INNER JOIN customer ON payment.customer_id=customer.customer_id
GROUP BY customer.customer_id
ORDER BY last_name ASC;
SELECT title FROM film
WHERE language_id in
	(SELECT language_id 
	FROM language
	WHERE name = "English" )
AND (title LIKE "K%") OR (title LIKE "Q%");
SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));
SELECT customer.first_name, customer.email,country.country
FROM country
LEFT JOIN customer ON country.country_id=customer.customer_id
WHERE country="canada";
SELECT title, category
FROM film_list
WHERE category = 'Family';
SELECT inventory.film_id, film_text.title, COUNT(rental.inventory_id) total_rentals
FROM inventory 
INNER JOIN rental 
ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_text 
ON inventory.film_id = film_text.film_id
GROUP BY rental.inventory_id
ORDER BY COUNT(rental.inventory_id) DESC;
SELECT store.store_id, SUM(payment.amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment  
ON payment.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);
SELECT store.store_id, city, country
FROM store 
INNER JOIN customer 
ON store.store_id = customer.store_id
INNER JOIN staff 
ON store.store_id = staff.store_id
INNER JOIN address 
ON customer.address_id = address.address_id
INNER JOIN city 
ON address.city_id = city.city_id
INNER JOIN country 
ON city.country_id = country.country_id;
SELECT category.name Top_Five, SUM(payment.amount) Gross 
FROM category 
JOIN film_category  ON (category.category_id=film_category.category_id)
JOIN inventory  ON (film_category.film_id=inventory.film_id)
JOIN rental  ON (inventory.inventory_id=rental.inventory_id)
JOIN payment  ON (rental.rental_id=payment.rental_id)
GROUP BY category.name ORDER BY Gross  LIMIT 5;
CREATE VIEW top_five_genres 
AS SELECT category.name Top_Five, SUM(payment.amount) Gross 
FROM category 
JOIN film_category  ON (category.category_id=film_category.category_id)
JOIN inventory  ON (film_category.film_id=inventory.film_id)
JOIN rental  ON (inventory.inventory_id=rental.inventory_id)
JOIN payment  ON (rental.rental_id=payment.rental_id)
GROUP BY category.name ORDER BY Gross  LIMIT 5;
SELECT * FROM top_five_genres;
DROP VIEW top_five_genres;

       
        
        
        














