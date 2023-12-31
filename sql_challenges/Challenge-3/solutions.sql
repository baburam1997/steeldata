--	1. What are the names of all the countries in the country table?
SELECT
	country_name
FROM
	challenge_3.country;


--	2. What is the total number of customers in the customers table?
SELECT 
	COUNT(*) AS total_customers
FROM 
	challenge_3.customers;

--	3. What is the average age of customers who can receive marketing emails (can_email is set to 'yes')?
SELECT 
	AVG(age) AS average_age
FROM 
	challenge_3.customers
WHERE 
	can_email = 'yes';

--	4. How many orders were made by customers aged 30 or older?
SELECT 
	COUNT(*) AS order_count
FROM 
	challenge_3.orders o
JOIN 
	challenge_3.customers c 
		ON o.customer_id = c.customer_id
WHERE 
	c.age >= 30;

--	5. What is the total revenue generated by each product category?
SELECT 
	p.category, SUM(p.price) AS total_revenue
FROM 
	challenge_3.products p
JOIN 
	challenge_3.baskets b 
		ON p.product_id = b.product_id
GROUP BY 
	p.category;

--	6. What is the average price of products in the 'food' category?
SELECT 
	AVG(price) AS average_price
FROM 
	challenge_3.products
WHERE 
	category = 'food';

--	7. How many orders were made in each sales channel (sales_channel column) in the orders table?
SELECT 
	sales_channel, COUNT(*) AS order_count
FROM 
	challenge_3.orders
GROUP BY 
	sales_channel;

--	8. What is the date of the latest order made by a customer who can receive marketing emails?
SELECT 
	MAX(date_shop) AS latest_order_date
FROM 
	challenge_3.orders o
JOIN 
	challenge_3.customers c 
		ON o.customer_id = c.customer_id
WHERE 
	c.can_email = 'yes';

--	9. What is the name of the country with the highest number of orders?
SELECT 
	c.country_name, COUNT(*) AS order_count
FROM 
	challenge_3.orders o
JOIN 
	challenge_3.country c 
		ON o.country_id = c.country_id
GROUP BY 
	c.country_name
ORDER BY 
	order_count DESC
LIMIT 1;

--	10. What is the average age of customers who made orders in the 'vitamins' product category?
SELECT 
	AVG(c.age) AS average_age
FROM 
	challenge_3.customers c
JOIN 
	challenge_3.orders o 
		ON c.customer_id = o.customer_id
JOIN 
	challenge_3.baskets b 
		ON o.order_id = b.order_id
JOIN 
	challenge_3.products p 
		ON b.product_id = p.product_id
WHERE 
	p.category = 'vitamins';

