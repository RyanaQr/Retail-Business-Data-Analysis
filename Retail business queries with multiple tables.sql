## Retail Business analysis MySQL project Solution file-02 ##

## Data Manipulation from Multiple tables and complex queries

-- Clients without invoice
SELECT *
FROM clients c
WHERE NOT EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
);

-- Data about clients who have invoice_total larger than client 3 from invoices and clients table
WITH invoice_table as (
              SELECT invoice_total, client_id
              FROM invoices
              WHERE invoice_total > ALL (SELECT invoice_total
                  FROM invoices
                  WHERE client_id = 3)
            )
SELECT c.client_id, name, address, state, phone, invoice_total
FROM clients as c
INNER JOIN invoice_table as it
       ON c.client_id = it.client_id           
;
-- Splitting
SELECT inv.client_id, SUM(invoice_total) 
FROM invoices as inv
group by inv.client_id
;
SELECT client_id, name, address, city, state, phone
FROM clients
WHERE client_id = 1 OR client_id = 5
;

-- Group and rank the clients based on their invoice_total from invoices 
SELECT *, SUM(invoice_total) OVER(partition by client_id) as total_invoice, 
ROW_number() OVER(partition by client_id ORDER BY client_id) AS Row_client,
RANK() OVER(partition by client_id ORDER BY client_id) AS Rank_client
FROM invoices
;

-- Find out the clients with at least 2 invoices from clients and invoices tables
SELECT c.client_id, name, count(c.client_id) as count
FROM clients as c
JOIN invoices as i
	ON c.client_id = i.client_id
GROUP BY client_id
HAVING `count` > 2
;

-- Retrieve the number from invoices table who chose payment method-1 in payments 
SELECT i.client_id, number, p.payment_method
FROM invoices as i
JOIN payments as p
	ON i.client_id = p.client_id
    WHERE payment_method = 1
;


