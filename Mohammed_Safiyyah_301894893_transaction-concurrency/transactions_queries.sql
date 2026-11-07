-- Account Transfer
START TRANSACTION;
UPDATE Accounts
SET balance = balance - 5000
WHERE account_id = 1;
UPDATE Accounts
SET balance = balance + 5000
WHERE account_id = 3;
COMMIT;

Select 
c.customer_id,
c.first_name,
c.last_name,
a.account_number,
a.account_type,
a.balance
From Customers c
Join Accounts a
ON c.customer_id = a.customer_id;

-- ROLLBACK 
START TRANSACTION;
UPDATE Accounts
SET balance = balance - 10000
WHERE account_id = 1;
ROLLBACK;

SELECT *
FROM Accounts
WHERE account_id = 1;

-- TRANSASCTION LOGGING
INSERT INTO Transactions
(
reference,
transaction_type,
from_account_id,
to_account_id,
amount,
status
)
VALUES
(
'KUDI-TXN-004',
'TRANSFER',
1,
3,
5000,
'COMPLETED'
);

-- CONSISTENCY
SELECT
account_number,
balance
FROM Accounts;