USE KudiTrustBank;

-- PORTFOLIOi 2 
--  SECTION: 1 SQL QUERIES 

-- Describes table structure 
describe transactions;
describe accounts;
describe customers;

-- Retrieve Customer Information & transaction info 
SELECT *
FROM customers;

select *
From transactions;

-- Shows all Acitve accounts 
Select *
From accounts
Where status = 'ACTIVE';

-- Shows cutomers information using JOIN 
SELECT
c.first_name,
c.last_name,
a.account_number,
a.balance
FROM Customers c
JOIN Accounts a
ON c.customer_id = a.customer_id;

 -- Section 2: Aggregate Functions 
 Select count(*) AS Total_Customers
 From customers;

Select sum(balance) AS Total_Balance
From accounts;

SELECT AVG(balance) AS Average_Balance
FROM Accounts;

-- SECTION 3: VIEWS

CREATE VIEW customer_accounts AS
SELECT
c.first_name,
c.last_name,
a.account_number,
a.balance
FROM Customers c
JOIN Accounts a
ON c.customer_id = a.customer_id;

Select *
From customer_accounts;

SELECT
c.customer_id,
c.first_name,
c.last_name,
a.account_number,
a.account_type,
a.balance
FROM Customers c
JOIN Accounts a
ON c.customer_id = a.customer_id;

-- SECTION 4: INDEXING 
CREATE INDEX idx_account_number
ON Accounts(account_number);

Show index
From accounts;

SELECT
    c.first_name,
    c.last_name,
    COUNT(a.account_id) AS total_accounts
FROM Customers c
LEFT JOIN Accounts a
    ON c.customer_id = a.customer_id
GROUP BY c.customer_id;

