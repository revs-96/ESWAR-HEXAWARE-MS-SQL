CREATE DATABASE CarRentalSystem;
USE CarRentalSystem;
CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    dailyRate DECIMAL(10, 2),
    status TINYINT, -- 1 for available, 0 for notAvailable
    passengerCapacity INT,
    engineCapacity INT
);
CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    phoneNumber VARCHAR(15)
);
CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    type VARCHAR(20), -- 'DailyLease' or 'MonthlyLease'
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);
CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);








INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES 
(1, 'Toyota', 'Camry',    2022, 50.00, 1, 4, 1450),
(2, 'Honda', 'Civic',     2023, 45.00, 1, 7, 1500),
(3, 'Ford', 'Focus',      2022, 48.00, 0, 4, 1400),
(4, 'Nissan', 'Altima',   2023, 52.00, 1, 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
(6, 'Hyundai', 'Sonata',   2023, 49.00, 0, 7, 1400),
(7, 'BMW', '3 Series',     2023, 60.00, 1, 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599),
(9, 'Audi', 'A4',		   2022, 55.00, 0, 4, 2500),
(10, 'Lexus', 'ES',        2023, 54.00, 1, 4, 2500);


INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES 
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');


INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES 
(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');



INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES 
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);
---------------------------------------Queries

UPDATE Vehicle
SET dailyRate = 68
WHERE make = 'Mercedes';
Select *from Vehicle;

DELETE FROM Payment
WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID = 1);
Select * from Payment;




EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';
Select * from Payment;

SELECT * 
FROM Customer
WHERE email = 'sarah@example.com'; 

UPDATE Lease
SET endDate = DATEADD(MONTH, 6, GETDATE()) 
WHERE endDate < GETDATE(); 

SELECT *
FROM Lease
WHERE customerID = 2
AND endDate > GETDATE(); 


SELECT Payment.*
FROM Payment
JOIN Lease ON Payment.leaseID = Lease.leaseID
JOIN Customer ON Lease.customerID = Customer.customerID
WHERE Customer.phoneNumber = '555-789-1234';



SELECT AVG(dailyRate) AS AverageDailyRate
FROM Vehicle
WHERE status = 1;


SELECT TOP 1 *
FROM Vehicle
ORDER BY dailyRate DESC;


SELECT Vehicle.*
FROM Vehicle
JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
WHERE Lease.customerID = 3;



SELECT TOP 1 *
FROM Lease
ORDER BY startDate DESC;



SELECT *
FROM Payment
WHERE YEAR(transactionDate) = 2023;



SELECT * 
FROM Customer
WHERE customerID NOT IN (
    SELECT DISTINCT customerID
    FROM Lease
    JOIN Payment ON Lease.leaseID = Payment.leaseID
);



SELECT Vehicle.vehicleID, Vehicle.make, Vehicle.model, Vehicle.year, Vehicle.dailyRate, Vehicle.status,
Vehicle.passengerCapacity, Vehicle.engineCapacity, 
       SUM(Payment.amount) AS TotalPayments
FROM Vehicle
LEFT JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Vehicle.vehicleID, Vehicle.make, Vehicle.model, Vehicle.year, Vehicle.dailyRate,
Vehicle.status, Vehicle.passengerCapacity, Vehicle.engineCapacity;




SELECT Customer.customerID, Customer.firstName, Customer.lastName, Customer.email, Customer.phoneNumber, 
       SUM(Payment.amount) AS TotalPayments
FROM Customer
LEFT JOIN Lease ON Customer.customerID = Lease.customerID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Customer.customerID, Customer.firstName, Customer.lastName, Customer.email, Customer.phoneNumber;




SELECT Lease.*, Vehicle.*
FROM Lease
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID;



SELECT Lease.*, Customer.*, Vehicle.*
FROM Lease
JOIN Customer ON Lease.customerID = Customer.customerID
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE Lease.endDate > GETDATE(); 

UPDATE Lease
SET endDate = DATEADD(MONTH, 6, GETDATE()) -- Adds 6 months to the current date
WHERE endDate < GETDATE(); -- Ensures only past end dates are updated



SELECT TOP 1 Customer.*, SUM(Payment.amount) AS TotalSpent
FROM Customer
JOIN Lease ON Customer.customerID = Lease.customerID
JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Customer.customerID, Customer.firstName, Customer.lastName, Customer.email, Customer.phoneNumber
ORDER BY TotalSpent DESC;





SELECT Vehicle.*, Lease.*
FROM Vehicle
LEFT JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID;
