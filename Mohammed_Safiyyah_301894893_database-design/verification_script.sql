USE KudiTrustBank;
SELECT DATABASE ();

SELECT
    COUNT(*) AS invalid_to_account_ids
FROM transactions AS t
LEFT JOIN accounts AS a
    ON t.to_account_id = a.account_id
WHERE t.to_account_id IS NOT NULL
  AND a.account_id IS NULL;


ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_to
FOREIGN KEY (to_account_id)
REFERENCES accounts (account_id);

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = DATABASE()
AND REFERENCED_TABLE_NAME IS NOT NULL;

SELECT 'Customers' AS table_name, COUNT(*) AS total_records
FROM customers

UNION ALL

SELECT 'Accounts', COUNT(*)
FROM accounts

UNION ALL

SELECT 'Transactions', COUNT(*)
FROM transactions;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_number,
    t.transaction_type,
    t.amount,
    t.status
FROM customers AS c
JOIN accounts AS a
    ON c.customer_id = a.customer_id
JOIN transactions AS t
    ON a.account_id = t.from_account_id;
    
    SELECT
    a.account_id,
    a.customer_id
FROM accounts AS a
LEFT JOIN customers AS c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT
    t.transaction_id,
    t.from_account_id,
    t.to_account_id
FROM transactions AS t
LEFT JOIN accounts AS a
    ON t.from_account_id = a.account_id
LEFT JOIN accounts AS b
    ON t.to_account_id = b.account_id
WHERE
    (t.from_account_id IS NOT NULL AND a.account_id IS NULL)
    OR
    (t.to_account_id IS NOT NULL AND b.account_id IS NULL);
    
    SELECT
    transaction_id,
    reference,
    transaction_type,
    from_account_id,
    to_account_id,
    amount,
    status,
    transaction_time
FROM transactions
ORDER BY transaction_id;

UPDATE transactions
SET reference = 'KUDI-TXN-002'
WHERE transaction_id = 5;

UPDATE transactions
SET reference = 'KUDI-TXN-003'
WHERE transaction_id = 6;

SELECT transaction_id, reference
FROM transactions
ORDER BY transaction_id;

SELECT DISTINCT transaction_type
FROM transactions;

SELECT DISTINCT status
FROM transactions;

SELECT DISTINCT transaction_type
FROM transactions;

SELECT
    transaction_id,
    amount
FROM transactions
WHERE amount <= 0;

SELECT transaction_id, amount
FROM transactions;

SELECT COUNT(*) AS total_transactions
FROM transactions;

SELECT
    account_id,
    account_number,
    account_type,
    balance,
    status
FROM accounts
ORDER BY account_id;

SELECT
    COUNT(*) AS accounts_with_invalid_balance
FROM accounts
WHERE balance IS NULL
   OR balance < 0;
   
   SHOW CREATE TABLE transactions;