CREATE DATABASE KudiTrustBank;
USE KudiTrustBank;

SHOW DATABASES;

CREATE TABLE Customers (
customer_id INT auto_increment PRIMARY KEY,
first_name VARCHAR (50) NOT NULL,
last_name VARCHAR (50) NOT NULL,
email VARCHAR (100) NOT NULL UNIQUE,
phone VARCHAR (20),
Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Accounts (
account_id INT auto_increment PRIMARY KEY,
customer_id INT NOT NULL,
account_number VARCHAR (10) NOT NULL UNIQUE,
account_type VARCHAR (20) NOT NULL,
balance DECIMAL (15, 2) NOT NULL DEFAULT 0.00,	
status VARCHAR (20) NOT NULL DEFAULT 'ACTIVE',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT fk_accounts_customer
FOREIGN KEY (customer_id)
REFERENCES Customers (customer_id),

CONSTRAINT chk_account_balance
CHECK		(balance >= 0),

CONSTRAINT chk_account_type
CHECK		(account_type IN ('SAVINGS', 'CURRENT')),

CONSTRAINT chk_account_status
CHECK		(status IN ('ACTIVE', 'FROZEN', 'CLOSED'))
);

 CREATE TABLE Transactions (
 transaction_id INT auto_increment PRIMARY KEY,
 reference VARCHAR (50) NOT NULL UNIQUE,
 transaction_type VARCHAR (20) NOT NULL,
 from_account_id INT NULL,
 to_account_id INT NULL,
 amount DECIMAL (15, 2) NOT NULL,
 status VARCHAR (20) NOT NULL DEFAULT 'PENDING', 
transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT fk_transactions_from
FOREIGN KEY (from_account_id)
REFERENCES Accounts (account_id),

CONSTRAINT chk_transaction_amount
CHECK		(amount > 0),

CONSTRAINT chk_transaction_type
CHECK (
	transaction_type IN('DEPOSIT', 'WITHDRAWAL', 'TRANSFER')
    ),
    CONSTRAINT chk_transaction_status
    CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED'))
);

SHOW TABLES;
DESCRIBE Customers;
DESCRIBE Accounts;
DESCRIBE Transactions;


INSERT INTO Customers 
	(first_name, last_name, email, phone)
VALUES
	('Nathan', 'Smith', 'natsmith@kudi.com', '08012345678'),
    ('Ryan', 'Omer', 'romer@kudi.com','08023456789'),
    ('Aya', 'Ahmad', 'aamad@kudi.com', '08034567890'),
    ('Harris', 'Ibrahim', 'harrisib@kudi.com', '09045678901'),
    ('Ann_Marie', 'Sanches', 'amaries@kudi.com', '09056789012');
    
   INSERT INTO Accounts
	(customer_id, account_number, account_type, balance) 
VALUES
	(1, '0123456789', 'SAVINGS', 50000.00),
    (1, '0123456790', 'CURRENT', 120000.00),
    (2, '0123456791', 'SAVINGS', 75000.00),
    (3, '0123456792', 'SAVINGS', 30000.00 ),
    (5, '0123456793', 'CURRENT', 750000.00);
    
     INSERT INTO Transactions
		(reference, transaction_type, from_account_id, to_account_id, amount, status) 
    VALUES
		('KUDI-TXN-001', 'DEPOSIT', NULL, 1, 1000.00, 'COMPLETED'),
		('KUDI-TNX-002', 'WITHDRAWAL', 2, NULL, 5000.00, 'COMPLETED'),
		('KUDI-TNX-003', 'TRANSFER', 1, 3, 2500.00, 'COMPLETED');
        
  DESCRIBE Accounts;
  
SET FOREIGN_KEY_CHECKS = 1;

DROP TABLE Accounts;

select * from customers;
select * from transactions;
select * from accounts;

SELECT
	c.first_name,
    c.last_name,
    a.account_number,
    a.account_type,
    a.balance
FROM Customers AS c
JOIN Accounts AS a
	ON c.customer_id =a.customer_id;