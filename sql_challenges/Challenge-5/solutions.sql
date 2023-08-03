--	1. How many pubs are located in each country?
SELECT 
	country, 
	COUNT(pub_id) AS num_pubs
FROM 
	challenge_5.pubs
GROUP BY 
	country;

--	2. What is the total sales amount for each pub, including the beverage price and quantity sold?
SELECT 
	p.pub_name, 
	SUM(s.quantity * b.price_per_unit) AS total_sales_amount
FROM 
	challenge_5.sales s
JOIN 
	challenge_5.pubs p 
		ON s.pub_id = p.pub_id
JOIN 
	challenge_5.beverages b 
		ON s.beverage_id = b.beverage_id
GROUP BY 
	p.pub_name;

--	3. Which pub has the highest average rating?
SELECT 
	p.pub_name, 
	AVG(rating) AS avg_rating
FROM 
	challenge_5.ratings r
JOIN 
	challenge_5.pubs p 
		ON p.pub_id = r.pub_id 
GROUP BY 
	p.pub_name
ORDER BY 
	avg_rating DESC
LIMIT 1;

--	4. What are the top 5 beverages by sales quantity across all pubs?
SELECT 
	b.beverage_name, 
	SUM(s.quantity) AS total_quantity_sold
FROM 
	challenge_5.sales s
JOIN 
	challenge_5.beverages b 
		ON s.beverage_id = b.beverage_id
GROUP BY 
	b.beverage_name
ORDER BY 
	total_quantity_sold DESC
LIMIT 5;

--	5. How many sales transactions occurred on each date?
SELECT 
	transaction_date, 
	COUNT(*) AS num_transactions
FROM 
	challenge_5.sales
GROUP BY 
	transaction_date;

--	6. Find the name of someone that had cocktails and which pub they had it in.
SELECT 
	r.customer_name, 
	p.pub_name
FROM 
	challenge_5.ratings r
JOIN 
	challenge_5.sales s 
		ON r.pub_id = s.pub_id
JOIN 
	challenge_5.beverages b 
		ON s.beverage_id = b.beverage_id
JOIN 
	challenge_5.pubs p 
		ON s.pub_id = p.pub_id
WHERE 
	b.category = 'Cocktail';

--	7. What is the average price per unit for each category of beverages, excluding the category 'Spirit'?
SELECT 
	category, 
	AVG(price_per_unit) AS average_price_per_unit
FROM 
	challenge_5.beverages
WHERE 
	category != 'Spirit'
GROUP BY 
	category;

--	8. Which pubs have a rating higher than the average rating of all pubs?
SELECT 
	p.pub_name, 
	AVG(r.rating) AS average_rating
FROM 
	challenge_5.pubs p
JOIN 
	challenge_5.ratings r 
		ON p.pub_id = r.pub_id
GROUP BY 
	p.pub_name
HAVING AVG(r.rating) > (SELECT 
							AVG(rating) 
						FROM 
							challenge_5.ratings
						);

--	9. What is the running total of sales amount for each pub, ordered by the transaction date?
SELECT 
	p.pub_name, 
	s.transaction_date, 
	SUM(b.price_per_unit * s.quantity) OVER (PARTITION BY p.pub_id ORDER BY s.transaction_date) AS running_total
FROM 
	challenge_5.sales s
JOIN 
	challenge_5.pubs p 
		ON s.pub_id = p.pub_id
JOIN 
	challenge_5.beverages b 
		ON s.beverage_id = b.beverage_id
ORDER BY 
	p.pub_name, 
	s.transaction_date;

--	10. For each country, what is the average price per unit of beverages in each category, and what is the overall average price per unit of beverages across all categories?
SELECT 
	p.country, 
	b.category, 
	AVG(b.price_per_unit) AS avg_price_per_unit
FROM 
	challenge_5.beverages b
JOIN 
	challenge_5.sales s 
		ON b.beverage_id = s.beverage_id
JOIN 
	challenge_5.pubs p 
		ON s.pub_id = p.pub_id
GROUP BY 
	p.country, 
	b.category
UNION ALL
SELECT 
	'Overall', 
	b.category, 
	AVG(b.price_per_unit) AS avg_price_per_unit
FROM 
	challenge_5.beverages b
GROUP BY 
	b.category;

--	11. For each pub, what is the percentage contribution of each category of beverages to the total sales amount, and what is the pub's overall sales amount?
 SELECT 
 	p.pub_name, 
 	b.category, 
    SUM(b.price_per_unit * s.quantity) / (SELECT 
    										SUM(b.price_per_unit * s.quantity) 
      										FROM 
      											challenge_5.sales s
        									JOIN 
        										challenge_5.beverages b 
        											ON s.beverage_id = b.beverage_id
        									WHERE s.pub_id = s.pub_id) * 100 AS percentage_contribution,
	SUM(b.price_per_unit * s.quantity) AS pub_sales_amount
FROM 
	challenge_5.sales s
JOIN 
	challenge_5.beverages b 
		ON s.beverage_id = b.beverage_id
JOIN 
	challenge_5.pubs p 
		ON s.pub_id = p.pub_id
GROUP BY 
	p.pub_name, 
	b.category
ORDER BY 
	p.pub_name;

