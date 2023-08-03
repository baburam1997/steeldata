--	1. What are the names of all the customers who live in New York?
SELECT 
	FirstName, 
	LastName
FROM 
	challenge_4.Customers
WHERE 
	City = 'New York';

--	2. What is the total number of accounts in the Accounts table?
SELECT 
	COUNT(*) AS total_accounts
FROM 
	challenge_4.Accounts;

--	3. What is the total balance of all checking accounts?
SELECT 
	SUM(Balance) AS total_balance
FROM 
	challenge_4.Accounts
WHERE 
	AccountType = 'Checking';

--	4. What is the total balance of all accounts associated with customers who live in Los Angeles?
SELECT 
	SUM(a.Balance) AS total_balance
FROM 
	challenge_4.Accounts a
JOIN 
	challenge_4.Customers c 
		ON a.CustomerID = c.CustomerID
WHERE 
	c.City = 'Los Angeles';

--	5. Which branch has the highest average account balance?
SELECT 
	b.BranchName, 
	AVG(a.Balance) AS average_balance
FROM 
	challenge_4.Branches b
JOIN 
	challenge_4.Accounts a 
		ON b.BranchID = a.BranchID
GROUP BY 
	b.BranchName
ORDER BY 
	average_balance DESC
LIMIT 1;

--	6. Which customer has the highest current balance in their accounts?
SELECT 
	c.FirstName, c.LastName, 
	MAX(a.Balance) AS highest_balance
FROM 
	challenge_4.Customers c
JOIN 
	challenge_4.Accounts a 
		ON c.CustomerID = a.CustomerID
GROUP BY 
	c.FirstName, 
	c.LastName
ORDER BY 
	highest_balance DESC
LIMIT 1;

--	7. Which customer has made the most transactions in the Transactions table?
SELECT 
	c.FirstName, 
	c.LastName, 
	COUNT(*) AS transaction_count
FROM 
	challenge_4.Customers c
JOIN 
	challenge_4.Accounts a 
		ON c.CustomerID = a.CustomerID
JOIN 
	challenge_4.Transactions t 
		ON a.AccountID = t.AccountID
GROUP BY 
	c.FirstName, c.LastName
ORDER BY 
	transaction_count DESC
LIMIT 1;

--	8. Which branch has the highest total balance across all of its accounts?
SELECT 
	b.BranchName, 
	SUM(a.Balance) AS total_balance
FROM 
	challenge_4.Branches b
JOIN 
	challenge_4.Accounts a 
		ON b.BranchID = a.BranchID
GROUP BY 
	b.BranchName
ORDER BY 
	total_balance DESC
LIMIT 1;

--	9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
SELECT 
	c.FirstName, 
	c.LastName, 
	SUM(a.Balance) AS total_balance
FROM 
	challenge_4.Customers c
JOIN 
	challenge_4.Accounts a 
		ON c.CustomerID = a.CustomerID
GROUP BY 
	c.FirstName, 
	c.LastName
ORDER BY 
	total_balance DESC
LIMIT 1;

--	10. Which branch has the highest number of transactions in the Transactions table?
SELECT 
	b.BranchName, 
	COUNT(*) AS transaction_count
FROM 
	challenge_4.Branches b
JOIN 
	challenge_4.Accounts a 
		ON b.BranchID = a.BranchID
JOIN 
	challenge_4.Transactions t 
		ON a.AccountID = t.AccountID
GROUP BY 
	b.BranchName
ORDER BY 
	transaction_count DESC
LIMIT 1;


