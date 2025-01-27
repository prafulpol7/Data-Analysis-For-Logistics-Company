-- SQL PROJECT(LOGISTICS COMPANY)

CREATE DATABASE SQLP;

USE SQLP;

SELECT * FROM Cust;
SELECT * FROM Pay;
SELECT * FROM Ship;

-- Changing the NAME of Columns

-- 1.For Customer Table
ALTER TABLE Cust RENAME  COLUMN CustomerID TO  C_ID;

SELECT * FROM Cust;


-- 2. For Payment Table

ALTER TABLE Pay RENAME COLUMN PaymentID TO P_ID;
ALTER TABLE Pay RENAME COLUMN CustomerID TO C_ID;

SELECT * FROM Pay;


-- 3.For Shipment table

ALTER TABLE Ship RENAME COLUMN ShipmentID TO S_ID;
ALTER TABLE Ship RENAME COLUMN CustomerID TO C_ID;

SELECT * FROM Ship;


SELECT * FROM Cust;
SELECT * FROM Pay;
SELECT * FROM Ship;

-- TASKS

-- Q.1 Extract all the Customer Names staring with Letter 'A'.

SELECT * FROM Cust
WHERE CustomerName LIKE('A%'); 



-- Q.2 Find the Total Number Of Customers.

SELECT COUNT(*) AS Total_Customers FROM Cust;



-- Q.3 List All the Customers with their Emails.

SELECT CustomerName,CustomerEmail FROM Cust;



-- Q.4 Calculate the Total Number of Shipments Made.

SELECT COUNT(*) AS Total_Shipments FROM Ship;



-- Q.5 Find the Shipment with Highest Shipment Cost.

SELECT * FROM Ship 
WHERE ShipmentCost ORDER BY ShipmentCost DESC LIMIT 1;



-- Q.6 List all the Shipments Made on May 1, 2024.

SELECT * FROM Ship
WHERE ShipmentDate = '01-05-2024';



-- Q.7 Calculate the Average Shipment Cost.

SELECT AVG(ShipmentCost) AS Average_Shipment_Cost FROM Ship;



-- Q.8 Find the Customers who made the Orders of Shipments Costing More Than $25.

SELECT C.CustomerName, S.ShipmentCost
FROM Cust AS C
JOIN Ship AS S
ON C.C_ID = S.C_ID
WHERE S.ShipmentCost > 25;



-- Q.9 Calculate the Shipment Cost for Each Customer.

SELECT C.CustomerName, S.ShipmentCost
FROM Cust AS C
JOIN Ship AS S
ON C.C_ID = S.C_ID;



-- Q.10 List all the Shipments Delivered to the Address of Containing "Block". 

SELECT * FROM Ship
WHERE DestinationAddress LIKE ('%Block%');



-- Q.11 Calculate Number of Shipments Made using Each Payment Method. 

SELECT PaymentMethod, COUNT(*) AS No_of_Shipments_Made
FROM Pay
GROUP BY PaymentMethod;



-- Q.12 Find the Average Shipment Cost for each Payment Method. 

SELECT P.PaymentMethod, AVG(ShipmentCost) AS AVG_Ship_Cost
FROM Pay AS P
JOIN Ship AS S 
ON P.C_ID = S.C_ID
GROUP BY PaymentMethod
ORDER BY PaymentMethod DESC; 



-- Q.13 List all the Shipments where the Shipment Cost is Greater Than Average Shipment Cost. 

SELECT * FROM Ship
WHERE 
ShipmentCost > (SELECT AVG(ShipmentCost) 
FROM Ship);



-- Q.14 Find Top 5 Customers who have the Highest Shipment Cost. 

SELECT C.CustomerName,SUM(ShipmentCost) AS SUMSC
FROM Cust AS C
JOIN Ship AS S 
ON C.C_ID = S.C_ID
GROUP BY CustomerName
ORDER BY SUMSC DESC LIMIT 5;



-- Q.15 Calculate the Percentage Share of Each Shipment Method in Total Shipment Cost.

SELECT ShipmentMethod,
SUM(ShipmentCost) * 100 / (SELECT SUM(ShipmentCost) FROM Ship) AS Sum_Of_SC
FROM Ship
GROUP BY Shipmentmethod;



-- Q.16 List the Customers who haven't made any shipments. 

SELECT C.CustomerName
FROM Cust AS C
JOIN Ship AS S ON C.C_ID = S.C_ID
WHERE C.CustomerName IS NULL;



-- Q.17 Create a View and Show Customers Who have spent more than $50. 

CREATE VIEW CustSpent AS
SELECT C.CustomerName, S.ShipmentCost
FROM Cust AS C
JOIN Ship AS S ON C.C_ID = S.C_ID
WHERE S.ShipmentCost > 50;

SELECT * FROM CustSpent;



-- Q.18 Find the Number of Payments that were made using Payment Method. 

SELECT PaymentMethod, Count(*) AS No_Of_Payments
FROM Pay
GROUP BY PaymentMethod;



-- Q.19 Find the Payment Method where the Highest Amount was Paid. 

SELECT  PaymentMethod, MAX(PaymentAmount) AS Highest_Amount_Paid
FROM Pay
GROUP BY PaymentMethod
ORDER BY Highest_Amount_Paid DESC LIMIT 1;



-- Q.20 Combine Payment_ID, Customer_ID and Shipment_ID columns and Generate Insights from them. 

SELECT C.C_ID, C.CustomerName, C.CustomerType,
       P.P_ID, P.PaymentMethod, P.PaymentAmount,
       S.S_ID, S.ShipmentMethod, S.ShipmentCost
FROM Cust AS C
LEFT JOIN Pay AS P ON C.C_ID = P.C_ID
LEFT JOIN Ship S ON C.C_ID = S.C_ID;



SELECT * FROM Cust;
SELECT * FROM Ship;
SELECT * FROM Pay;