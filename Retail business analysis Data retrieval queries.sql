## Retail Business analysis MySQL project Solution file-01 ##

-- Creating and using DATABASE
Create database `DB_for_Mosh`;
Use `DB_for_Mosh`;

## Data Retrieval

-- Give a list of unique states from ‘customers’ table
SELECT DISTINCT state
FROM customers;

-- A new price for products is set as the 1.1times the unit_price. How would the new price look like in ‘products’ table?
SELECT name, unit_price, (unit_price *1.1) AS new_price
FROM products;

-- Show all the important data from the ‘invoices’ table after the invoice_date June 2019
SELECT invoice_id, client_id, invoice_total, payment_total, invoice_date, due_date
FROM invoices
WHERE invoice_date > '2019-06-30';

-- Identify those customers who were born after 1990 having points more than 1000
SELECT *
FROM customers
WHERE birth_date >= '1990-01-01' AND points > 1000;

-- Find out the details of those clients from payments table with client_id 5 having amount more than 20.00
SELECT * 
FROM payments
WHERE client_id = 5 AND amount > 20.00;

-- Identify those products which are less expensive than lettuce from products table
SELECT *
FROM products
WHERE unit_price < (
	SELECT unit_price 
	FROM products
    WHERE name REGEXP('lettuce')
);

## SQL Joins

-- All possible payment_method names by joining payments and payment_methods tables
SELECT *
FROM payments as pay
INNER JOIN payment_methods as pm
	ON pay.payment_method = pm.payment_method_id
;

-- Joining the tables: clients, invoices to show which clients ordered what
SELECT cl.client_id, name, state, payment_total, due_date, payment_date, phone
FROM clients as cl
JOIN invoices as inv
	ON cl.client_id = inv.client_id
;

