--Task 1

--1
CREATE DATABASE HMBank;
--2
CREATE TABLE HMBank.dbo.Customer(Customer_Id INT IDENTITY PRIMARY KEY, First_Name VARCHAR(65), Last_Name VARCHAR(65), 
DOB DATE, Email VARCHAR(65), Address VARCHAR(65))
CREATE TABLE HMBank.dbo.Accounts(Account_Id INT IDENTITY PRIMARY KEY, Customer_ID INT FOREIGN KEY REFERENCES HMBank.dbo.Customer(Customer_Id));
ALTER TABLE HMBank.dbo.Accounts ADD
										Account_Type VARCHAR(65), Balance INT;
CREATE TABLE HMBank.dbo.Transactions(Transaction_Id INT IDENTITY PRIMARY KEY, Account_Id INT FOREIGN KEY REFERENCES HMBank.dbo.Accounts(Account_ID), 
Transaction_Type VARCHAR(65), Amount INT, Transaction_Date DATE);

--DROP TABLE HMBank.dbo.Transactions;
--DROP TABLE HMBank.dbo.Accounts;
--DROP TABLE HMBank.dbo.Customer;
--DROP DATABASE HMBank;


--Task 2
------------------------------------------------------Inserting Data->
--1
INSERT INTO HMBank.dbo.Customer (First_Name, Last_Name, DOB, Email, Address)
VALUES 
('John', 'Doe', '1985-05-15', 'john.doe@example.com', '123 Elm Street'),
('Jane', 'Smith', '1990-07-23', 'jane.smith@example.com', '456 Oak Avenue'),
('Emily', 'Johnson', '1992-11-30', 'emily.johnson@example.com', '789 Pine Road'),
('Michael', 'Brown', '1988-03-10', 'michael.brown@example.com', '101 Maple Boulevard'),
('Emma', 'Jones', '1995-04-17', 'emma.jones@example.com', '202 Birch Lane'),
('David', 'Miller', '1993-09-19', 'david.miller@example.com', '303 Cedar Drive'),
('Sophia', 'Davis', '1987-08-22', 'sophia.davis@example.com', '404 Walnut Street'),
('William', 'Garcia', '1991-12-01', 'william.garcia@example.com', '505 Spruce Way'),
('Olivia', 'Martinez', '1994-02-14', 'olivia.martinez@example.com', '606 Redwood Place'),
('James', 'Wilson', '1989-06-07', 'james.wilson@example.com', '707 Chestnut Street');

--select * from HMBank.dbo.Customer;

INSERT INTO HMBank.dbo.Accounts (Customer_ID, Account_Type, Balance)
VALUES
(1, 'Savings', 1500),
(2, 'Checking', 5000),
(3, 'Savings', 3000),
(4, 'Checking', 2500),
(5, 'Savings', 1000),
(6, 'Checking', 4500),
(7, 'Savings', 200),
(8, 'Checking', 3200),
(9, 'Savings', 500),
(10, 'Checking', 800);


INSERT INTO HMBank.dbo.Transactions (Account_Id, Transaction_Type, Amount, Transaction_Date)
VALUES
(1, 'Deposit', 1000, '2024-01-01'),
(2, 'Withdrawal', 2000, '2024-02-15'),
(3, 'Deposit', 500, '2024-03-05'),
(4, 'Withdrawal', 1000, '2024-04-22'),
(5, 'Deposit', 700, '2024-05-30'),
(6, 'Withdrawal', 1500, '2024-06-15'),
(7, 'Deposit', 200, '2024-07-10'),
(8, 'Deposit', 1200, '2024-08-20'),
(9, 'Withdrawal', 300, '2024-09-05'),
(10, 'Deposit', 800, '2024-09-18');

--select * from HMBank.dbo.Transactions;
-- 2.1
SELECT C.First_Name, C.Last_Name, C.Email, A.Account_Type
FROM HMBank.dbo.Customer C
JOIN HMBank.dbo.Accounts A ON C.Customer_Id = A.Customer_ID;

--2.2
SELECT C.First_Name, C.Last_Name, T.Transaction_Id, T.Transaction_Type, T.Amount, T.Transaction_Date
FROM HMBank.dbo.Customer C
JOIN HMBank.dbo.Accounts A ON C.Customer_Id = A.Customer_ID
JOIN HMBank.dbo.Transactions T ON A.Account_Id = T.Account_Id;

--2.3
UPDATE HMBank.dbo.Accounts
SET Balance = Balance + 500 
WHERE Account_Id = 1; 

--select * from HMBank.dbo.Accounts;

--2.4
SELECT CONCAT(First_Name, ' ', Last_Name) AS full_name
FROM HMBank.dbo.Customer;



-- 2.5 Delete the related transactions first
DELETE FROM HMBank.dbo.Transactions
WHERE Account_Id IN (SELECT Account_Id FROM HMBank.dbo.Accounts WHERE Balance = 0 AND Account_Type = 'Savings');

-- Now, delete the accounts
DELETE FROM HMBank.dbo.Accounts
WHERE Balance = 0 AND Account_Type = 'Savings';

SELECT * FROM HMBank.dbo.Accounts;

--2.6
SELECT * FROM HMBank.dbo.Customer
WHERE Address LIKE '%Oak%'; 

--2.7
SELECT Balance
FROM HMBank.dbo.Accounts
WHERE Account_Id = 1; 

--2.8
SELECT * FROM HMBank.dbo.Accounts
WHERE Account_Type = 'Checking' AND Balance > 1000;


--2.9
SELECT * FROM HMBank.dbo.Transactions
WHERE Account_Id = 1;

--2.10
SELECT Account_Id, Balance, (Balance * 0.03) AS Interest_Accrued
FROM HMBank.dbo.Accounts
WHERE Account_Type = 'Savings';

--2.111
SELECT * FROM HMBank.dbo.Accounts
WHERE Balance < -500; 

--2.12
SELECT * FROM HMBank.dbo.Customer
WHERE Address NOT LIKE '%oak%'; 

---------------------------------TASK 3
--1
SELECT AVG(Balance) AS Avg_Balance
FROM HMBank.dbo.Accounts;

--2
SELECT TOP 10 * 
FROM HMBank.dbo.Accounts
ORDER BY Balance DESC;


--3
SELECT SUM(Amount) AS Total_Deposits
FROM HMBank.dbo.Transactions
WHERE Transaction_Type = 'Deposit' AND Transaction_Date = '2024-03-05'; 

--4
-- Oldest customer
SELECT TOP 1 * 
FROM HMBank.dbo.Customer
ORDER BY DOB ASC;

-- Newest customer
SELECT TOP 1 * 
FROM HMBank.dbo.Customer
ORDER BY DOB DESC;

--5
SELECT T.Transaction_Id, T.Transaction_Type, T.Amount, A.Account_Type
FROM HMBank.dbo.Transactions T
JOIN HMBank.dbo.Accounts A ON T.Account_Id = A.Account_Id;

--6
SELECT C.First_Name, C.Last_Name, A.Account_Id, A.Account_Type, A.Balance
FROM HMBank.dbo.Customer C
JOIN HMBank.dbo.Accounts A ON C.Customer_Id = A.Customer_ID;

--7
SELECT C.First_Name, C.Last_Name, T.Transaction_Id, T.Transaction_Type, T.Amount, T.Transaction_Date
FROM HMBank.dbo.Customer C
JOIN HMBank.dbo.Accounts A ON C.Customer_Id = A.Customer_ID
JOIN HMBank.dbo.Transactions T ON A.Account_Id = T.Account_Id
WHERE A.Account_Id = 1; 

--8
SELECT C.First_Name, C.Last_Name, COUNT(A.Account_Id) AS Account_Count
FROM HMBank.dbo.Customer C
JOIN HMBank.dbo.Accounts A ON C.Customer_Id = A.Customer_ID
GROUP BY C.First_Name, C.Last_Name
HAVING COUNT(A.Account_Id) > 1;

--9
SELECT Account_Id, 
       SUM(CASE WHEN Transaction_Type = 'Deposit' THEN Amount ELSE 0 END) -
       SUM(CASE WHEN Transaction_Type = 'Withdrawal' THEN Amount ELSE 0 END) AS Transaction_Difference
FROM HMBank.dbo.Transactions
GROUP BY Account_Id;

SELECT Account_Id, AVG(Balance) AS Avg_Daily_Balance
FROM HMBank.dbo.Transactions
WHERE Transaction_Date BETWEEN '2024-01-01' AND '2024-12-31' 
GROUP BY Account_Id;

--10
-- Calculate the average daily balance for each account over a specified period
SELECT A.Account_Id, 
       AVG(Total_Daily_Amount) AS Avg_Daily_Balance
FROM (
    -- Subquery 
    SELECT T.Account_Id, T.Transaction_Date, SUM(T.Amount) AS Total_Daily_Amount
    FROM HMBank.dbo.Transactions T
    WHERE T.Transaction_Date BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY T.Account_Id, T.Transaction_Date
) AS DailyTotals
JOIN HMBank.dbo.Accounts A ON A.Account_Id = DailyTotals.Account_Id
GROUP BY A.Account_Id;


--11
SELECT Account_Type, SUM(Balance) AS Total_Balance
FROM HMBank.dbo.Accounts
GROUP BY Account_Type;

--12
SELECT A.Account_Id, COUNT(T.Transaction_Id) AS Transaction_Count
FROM HMBank.dbo.Accounts A
JOIN HMBank.dbo.Transactions T ON A.Account_Id = T.Account_Id
GROUP BY A.Account_Id
ORDER BY Transaction_Count DESC;

--13
SELECT C.First_Name, C.Last_Name, A.Account_Type, SUM(A.Balance) AS Total_Balance
FROM HMBank.dbo.Customer C
JOIN HMBank.dbo.Accounts A ON C.Customer_Id = A.Customer_ID
GROUP BY C.First_Name, C.Last_Name, A.Account_Type
HAVING SUM(A.Balance) >= 5000;

--14
SELECT Transaction_Id, Account_Id, Amount, Transaction_Date, COUNT(*)
FROM HMBank.dbo.Transactions
GROUP BY Account_Id, Amount, Transaction_Date
HAVING COUNT(*) > 1;

---------------------------------TASK 4

--1

SELECT C.First_Name, C.Last_Name, A.Balance
FROM HMBank.dbo.Customer C
JOIN HMBank.dbo.Accounts A ON C.Customer_Id = A.Customer_ID
WHERE A.Balance = (SELECT MAX(Balance) FROM HMBank.dbo.Accounts);

--2
SELECT AVG(A.Balance) AS Avg_Balance
FROM HMBank.dbo.Accounts A
WHERE A.Customer_ID IN (
   SELECT Customer_ID
   FROM HMBank.dbo.Accounts
   GROUP BY Customer_ID
   HAVING COUNT(Account_Id) > 1
);

-- Insert accounts that don't have any transactions
INSERT INTO HMBank.dbo.Accounts (Customer_ID, Account_Type, Balance)
VALUES
(1, 'Savings', 700),  -- New account with no transactions
(2, 'Checking', 2000);  -- Another account with no transactions




--3
SELECT * 
FROM HMBank.dbo.Transactions
WHERE Amount > (SELECT AVG(Amount) FROM HMBank.dbo.Transactions);

--4
SELECT C.First_Name, C.Last_Name
FROM HMBank.dbo.Customer C
WHERE NOT EXISTS (
   SELECT 1 FROM HMBank.dbo.Transactions T
   JOIN HMBank.dbo.Accounts A ON T.Account_Id = A.Account_Id
   WHERE C.Customer_Id = A.Customer_ID
);

--5
SELECT SUM(Balance)
FROM HMBank.dbo.Accounts A
WHERE NOT EXISTS (
   SELECT 1 FROM HMBank.dbo.Transactions T
   WHERE T.Account_Id = A.Account_Id
);


--6
SELECT TOP 10 *
FROM HMBank.dbo.Accounts
ORDER BY Balance DESC;

-- Insert a customer with both a Savings and a Checking account
INSERT INTO HMBank.dbo.Accounts (Customer_ID, Account_Type, Balance)
VALUES
(1, 'Checking', 2500), 
(3, 'Checking', 3000); 


--7
SELECT C.First_Name, C.Last_Name
FROM HMBank.dbo.Customer C
WHERE C.Customer_Id IN (
   SELECT Customer_ID
   FROM HMBank.dbo.Accounts
   GROUP BY Customer_ID
   HAVING COUNT(DISTINCT Account_Type) > 1
);

--8
SELECT Account_Type, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM HMBank.dbo.Accounts) AS Percentage
FROM HMBank.dbo.Accounts
GROUP BY Account_Type;

--9
SELECT T.*
FROM HMBank.dbo.Transactions T
JOIN HMBank.dbo.Accounts A ON T.Account_Id = A.Account_Id
WHERE A.Customer_ID = 1; 


--10
SELECT Account_Type, 
       (SELECT SUM(Balance) FROM HMBank.dbo.Accounts A2 WHERE A2.Account_Type = A.Account_Type) 
	   AS Total_Balance
FROM HMBank.dbo.Accounts A
GROUP BY Account_Type;




