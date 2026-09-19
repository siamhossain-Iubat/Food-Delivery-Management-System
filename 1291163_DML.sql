/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$																													$
$																													$
$																													$
$					Project Title :Design and Iplementation of a Food Delivary Managment System Using SQL			$
$											Trainee Name : Abdul Mazed												$
$											  Treinee ID : 1291163													$
$												Batch ID : CS/PNTL-A/67/01											$
$																													$
$																													$
$							                	***Instructed By MD AZMAN ALI***									$
$								  Faculty of Cross Platform Apps using ASP.NET, Angular & React						$
$														  PeopleNTech												$
$																													$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

/*
 Table of Contents for DDL :
							PART 01--INSERT DATA USING INSERT INTO KAYWORD
							PART 02--INSERT, UPDATE, DELETE USING A VIEW	
							PART 03--INSERT, UPDATE, DELETE USING STORED PROCEDURE
							PART 04--RETRIEVE DATA USING USER-DEFINED FUNCTIONS (UDF)	
							PART 05--DML OPERATIONS WITH TRIGGERS
							PART 06--DML QUERIES
						   (:: All types of JOIN								      
							:: ALL, DISTINCT, TOP, PERCENT, WITH TIES
							:: String Expressions, Concatenate				       
							:: GROUP BY, HAVING
							:: Arithmetic Expressions							  
							:: ROLLUP, CUBE, GROUPING SETS
							:: Logical Operator (AND, OR, NOT)							
							:: Comparison Operator, BETWEEN
							:: Range of Selected Rows (OFFSET FETCH)		  
							:: Compound Join
							:: UNION, UNION ALL, EXCEPT, INTERSECT   
							:: Subqueries											   
							:: CTE, Recursive CTE
							:: MERGE												   
							:: CAST, CONVERT, TRY_CONVERT				   
							:: Numeric Functions
							:: Date Functions										   
							:: COALESCE, ISNULL, CASE
							:: IIF, CHOOSE										   
							:: Temporary Tables, Table Variables
							:: Ranking Functions								  	   
							:: Analytic Functions
						    )
							PART 07--VARIABLE DICLARETION


*/
USE FDMS
GO
/*
<><><><><><><><><><><><><><><><><> Part 01 <><><><><><><><><><><><><><><><>
					DATA INSERTION USING INTO INTO KEYWORD
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/

INSERT INTO CUSTOMERS (cNAME, PHONE, EMAIL, cADDRESS)
VALUES 
('Alice Rahman', '01712345678', 'alice@gmail.com', 'Dhaka'),
('Babul Khan', '01898765432', 'babul@gmail.com', 'Chittagong'),
('Chitra Das', '01911223344', 'chitra@gmail.com', 'Sylhet')
SELECT * FROM CUSTOMERS
GO



INSERT INTO RIDERS (rNAME, PHONE, PAYACCOUNT)
VALUES 
('Rafiq', '01711111111', 'bkash'),
('Shuvo', '01822222222', 'nagad'),
('Mita', '01933333333', 'rocket')
SELECT * FROM RIDERS
GO

INSERT INTO VENDORS (vNAME, vLOCATION, PHONE, OpeningTime, ClosingTime)
VALUES 
('Pizza Palace', 'Banani', '01744444444', '08:00', '22:00'),
('Burger Hub', 'Dhanmondi', '01855555555', '10:00', '22:00'),
('Sushi World', 'Gulshan', '01966666666', '10:00', '23:00')
SELECT * FROM VENDORS
GO


INSERT INTO CETAGORIES (cetagoryNAME)
VALUES 
('Fast Food'),
('Asian Cuisine'),
('Desserts')
SELECT * FROM CETAGORIES
GO

INSERT INTO ORDERS (VendorID, RiderID, CustomerID, OrderStatus, TotalAmount)
VALUES 
(1000, 1001, 1, 'PENDING', 500),
(1001, 1002, 2, 'ON THE WAY', 750),
(1002, 1003, 3, 'DELIVARED', 1200)
SELECT * FROM ORDERS
GO

INSERT INTO ManuItems (VendorID, CetagoryID, ItemName, PRICE)
VALUES 
(1000, 100, 'Pepperoni Pizza', 450),
(1001, 100, 'Cheese Burger', 300),
(1002, 200, 'Salmon Sushi', 600)
SELECT * FROM ManuItems
GO


INSERT INTO OrderItem (OrderID, ManuID)
VALUES 
(3, 1),
(4, 2),
(5, 3)
SELECT * FROM OrderItem
GO

INSERT INTO PAYMENTS (OrderID, AMOUNT, PaymentMathod)
VALUES 
(3, 500, 'CASH'),
(4, 750, 'CARD'),
(5, 1200, 'MOBILE BANGKING')
SELECT * FROM PAYMENTS
GO

INSERT INTO RiderPayments (OrderID, RiderID, PaymentDate, AmountPaid)
VALUES 
(3, 1001, GETDATE(), 50),
(4, 1002, GETDATE(), 50),
(5, 1001, GETDATE(), 50)
SELECT * FROM RiderPayments
GO


INSERT INTO RestaurantCategory (VendorID, CetagoryID)
VALUES 
(1000, 100),
(1001, 100),
(1002, 200)
SELECT * FROM RestaurantCategory
GO

INSERT INTO rrr.Reviews (OrderID, Retings, Comments)
VALUES 
(3, '5', 'Excellent service!'),
(4, '4', 'Tasty food, but delivery was slow.'),
(5, '3', 'Average experience.')
SELECT * FROM rrr.Reviews
GO

/*
<><><><><><><><><><><><><><><><><> Part 02 <><><><><><><><><><><><><><><><>
					INSERT, UPDATE, DELETE USING A VIEW
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/
INSERT INTO vInsertIntoCETAGORIES VALUES
('BANGALI CUISINE'),
('KABAB'),
('SEA FOOD')
SELECT * FROM vInsertIntoCETAGORIES
GO


--UPDATE THOUGH VEIW
UPDATE vInsertIntoCETAGORIES
SET CETAGORYNAME='CHINISE FOOD'
WHERE ID=400
SELECT * FROM vInsertIntoCETAGORIES
GO


--DELETE THOUGH VEIW
DELETE FROM vInsertIntoCETAGORIES
WHERE ID=400
SELECT * FROM vInsertIntoCETAGORIES
GO

/*
<><><><><><><><><><><><><><><><><> Part 03 <><><><><><><><><><><><><><><><>
				INSERT, UPDATE, DELETE USING STORED PROCEDURE
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/
--INSERT USING STORE PROCEDURE
EXEC spInsertInto_CUSTOMERS 'KAMAL KHAN','01720202020','kamal@gmail.com',Jatrabari
EXEC spInsertInto_CUSTOMERS 'JAMAL KHAN','01720202121','jamal@gmail.com',WARI 
EXEC spInsertInto_CUSTOMERS 'TOMAL KHAN','01720203030','tomal@gmail.com','GREND AREA' 
SELECT * FROM CUSTOMERS
GO

--UPDATE USING STORE PROCEDURE
EXEC spUpdateAddress 1,HASAN,'01511122233','hasan@gmail.com',KAMLAPUR
SELECT * FROM CUSTOMERS
GO

--DELETE THOUGH STORE PROCEDURE
EXEC spDeleteData 5
SELECT * FROM CUSTOMERS
GO

/*
<><><><><><><><><><><><><><><><><> Part 04 <><><><><><><><><><><><><><><><>
				RETRIEVE DATA USING USER-DEFINED FUNCTIONS (UDF)
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/

--RETRIEVE DATA THOUGH SCALER FUNCTION
 SELECT * FROM dbo.fnCLC_riderPayment(1003) 
 GO


 --RETRIEVE DATA THOUGH INLINE TABLE VALUED FUNCTION
 SELECT * FROM dbo.fnCLC_ridersPayment()
 GO


 --RETRIEVE DATA THOUGH MULTI STATEMENT TABLE VALUED FUNCTION
 SELECT * FROM  dbo.fnPaymentCalc()
 GO


 /*
<><><><><><><><><><><><><><><><><> Part 05 <><><><><><><><><><><><><><><><>
						DML OPERATIONS WITH TRIGGERS
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/


--TEST AFTER TRIGGER FOR AUTO UPDATING DELIVARYTIME
INSERT INTO ORDERS(VendorID,RiderID,CustomerID,OrderDate,OrderStatus,TotalAmount) VALUES
(1000,1002,4,'2025-09-16','DELIVARED',1050)
SELECT * FROM ORDERS

--TEST AFTER TRIGGER FOR INSERT/DELETE/UPDATE
UPDATE OrderItem
SET ManuID=2
WHERE OrderItemID=3
GO

--TEST INSTED OF TRIGGER

INSERT INTO RiderPayments(OrderID,RiderID,PaymentDate,AmountPaid) VALUES
(6,1002,GETDATE(),50)
SELECT * FROM RiderPayments
GO


 /*
<><><><><><><><><><><><><><><><><> Part 06 <><><><><><><><><><><><><><><><>
								DML QUARIES
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/

--########## All types of JOIN #############
-- INNER JOIN: Customer with their orders
SELECT c.cNAME,o.OrderDate, o.TotalAmount,o.OrderStatus
FROM CUSTOMERS c
INNER JOIN ORDERS o ON c.ID = o.CustomerID
GO

-- LEFT JOIN: All customers, even if they haven't ordered
SELECT c.cNAME, o.TotalAmount
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.ID = o.CustomerID
GO

-- FULL OUTER JOIN: All vendors and their menu items
SELECT v.vNAME, m.ItemName
FROM VENDORS v
FULL OUTER JOIN ManuItems m ON v.ID = m.VendorID
GO

--############### ALL, DISTINCT, TOP, PERCENT, WITH TIES ##############--


--USING ALL IN QUARIES
SELECT * FROM CUSTOMERS --* SYMBLE INDICATE ALL IN THE SELECT STATEMENT


-- USE OF DISTINCT IN SELECT STATEMENT
SELECT DISTINCT * FROM ORDERS  --DISTINCT USE FOR IGNORING REETATIVE DATA
GO

--USE OF TOP CLUASE
SELECT TOP 2 * FROM ORDERS
GO


--USE OF PERCENT
SELECT TOP 10 PERCENT * 
FROM ManuItems 
ORDER BY PRICE DESC
GO


--USE OF WITH TIES
SELECT TOP 3 WITH TIES * 
FROM ORDERS 
ORDER BY TotalAmount DESC
GO

--############### String Expressions AND Concatenation ##############--

SELECT cNAME + ' lives in ' + cADDRESS AS Info
FROM CUSTOMERS
GO

--######### GROUP BY, HAVING ############--

SELECT VendorID, COUNT(*) AS TotalOrders
FROM ORDERS
GROUP BY VendorID
HAVING COUNT(*) > 1
GO


--############ Arithmetic Expressions ############

SELECT ID,(TotalAmount + DelivaryFee) AS FinalBill
FROM ORDERS
GO

--################ ROLLUP, CUBE, GROUPING SETS #############--

--ROLLUP
SELECT VendorID, OrderStatus, COUNT(*) AS Total
FROM ORDERS
GROUP BY ROLLUP (VendorID, OrderStatus)
GO


--CUBE
SELECT VendorID, OrderStatus, COUNT(*) AS Total
FROM ORDERS
GROUP BY CUBE (VendorID, OrderStatus)
GO

--GROUPING SETS
SELECT VendorID, OrderStatus, COUNT(*) AS Total
FROM ORDERS
GROUP BY GROUPING SETS ((VendorID), (OrderStatus))
GO


--##########  Logical Operator (AND, OR, NOT)	###########

--AND
SELECT * FROM ORDERS
WHERE TotalAmount > 500 AND OrderStatus = 'DELIVARED'
GO

--OR
SELECT * FROM ORDERS
WHERE TotalAmount > 500 OR OrderStatus = 'DELIVARED'
GO

--NOT
SELECT * FROM ORDERS
WHERE NOT OrderStatus = 'CANCELLED'
GO

--##########  Comparison Operator, BETWEEN ##########

SELECT * FROM ORDERS
WHERE TotalAmount BETWEEN 500 AND 1000
GO


--####### Range of Selected Rows (OFFSET FETCH) #######--

SELECT * FROM ORDERS
ORDER BY ID
OFFSET 2 ROWS 
FETCH NEXT 5 ROWS ONLY
GO

--######### Compound Join #########--
SELECT o.ID, c.cNAME, r.rNAME
FROM ORDERS o
JOIN CUSTOMERS c ON o.CustomerID = c.ID
JOIN RIDERS r ON o.RiderID = r.ID
GO

--########  UNION,  EXCEPT, INTERSECT  #######--

--UNION
SELECT cNAME FROM CUSTOMERS
UNION
SELECT rNAME FROM RIDERS
GO



--EXCEPT
SELECT cNAME FROM CUSTOMERS
EXCEPT
SELECT rNAME FROM RIDERS
GO


--INTERSECT
SELECT cNAME FROM CUSTOMERS
INTERSECT
SELECT rNAME FROM RIDERS
GO

--######### Subqueries #########

--NESTED SUBQUERY
SELECT * FROM ORDERS
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM ORDERS)
GO

--CORRELETED SUBQUERY
SELECT O.ID,(SELECT vNAME FROM VENDORS V WHERE O.VendorID=V.ID ) AS 'RESTAURANT NAME'
FROM ORDERS O
GO

--###### CTE ##########--

-- Simple CTE
WITH OrderCount AS 
(
  SELECT CustomerID, COUNT(*) AS TotalOrders
  FROM ORDERS
  GROUP BY CustomerID
)
SELECT * FROM OrderCount WHERE TotalOrders > 1

--######### MERGE ###########--
MERGE INTO CUSTOMERS AS Target
USING 
(SELECT 'Rafi', '017777777777', 'rafi@example.com', 'Barisal') AS Source(cNAME, PHONE, EMAIL, cADDRESS)
ON Target.PHONE = Source.PHONE
WHEN MATCHED THEN UPDATE SET Target.cADDRESS = Source.cADDRESS
WHEN NOT MATCHED THEN INSERT (cNAME, PHONE, EMAIL, cADDRESS)
VALUES (Source.cNAME, Source.PHONE, Source.EMAIL, Source.cADDRESS);
GO


--##########  CAST, CONVERT, TRY_CONVERT ###########--

--CAST
SELECT 
	CAST(TotalAmount AS VARCHAR) AS AmountText
FROM ORDERS
GO

--CONVERT
SELECT 
	CONVERT(DATE, OrderDate) AS OrderDateOnly 
FROM ORDERS
GO
--###### Numeric Functions #######--

SELECT 
	ROUND(PRICE, 0) AS 'ROUND',
	CEILING(PRICE)'CEILING',
	FLOOR(PRICE)'FLOOR'
FROM ManuItems
GO

--##### Date Functions #######--

SELECT GETDATE() AS Today,
       DATEPART(YEAR, OrderDate) AS OrderYear,
       DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysSinceOrder
FROM ORDERS
GO


--##### COALESCE, ISNULL, CASE ######-

--COALESCE
SELECT 
	COALESCE(EMAIL, 'No Email') AS 'COALESCE' 
FROM CUSTOMERS
GO


--ISNULL
SELECT 
	ISNULL(DelivaryDate,GETDATE()) AS 'ISNULL'
FROM ORDERS
GO

--CASE
SELECT CASE 
         WHEN TotalAmount > 1000 THEN 'High'
         WHEN TotalAmount > 500 THEN 'Medium'
         ELSE 'Low'
       END AS OrderLevel
FROM ORDERS
GO

--###### IIF, CHOOSE ########--
--IFF
SELECT 
	IIF(OrderStatus = 'DELIVARED', 'Success', 'Pending') AS StatusFlag
FROM ORDERS
GO

--CHOOSE
SELECT 
	CHOOSE(2, 'First', 'Second', 'Third')AS 'CHOOSE' -- Returns 'Second'
GO

--######  Temporary Tables, Table Variables ######--

DECLARE @TempOrders TABLE 
(
	OrderID INT,
	TotalAmount MONEY
)
INSERT INTO @TempOrders
	SELECT ID, TotalAmount FROM ORDERS WHERE TotalAmount > 500
SELECT * FROM @TempOrders
GO

--#### Ranking Functions ####--

SELECT ID, TotalAmount,
       RANK() OVER (ORDER BY TotalAmount DESC) AS Rank,
       DENSE_RANK() OVER (ORDER BY TotalAmount DESC) AS DenseRank,
       ROW_NUMBER() OVER (ORDER BY TotalAmount DESC) AS RowNum
FROM ORDERS
GO

--#### Analytic Functions ####
SELECT ID, TotalAmount,
       AVG(TotalAmount) OVER (PARTITION BY VendorID) AS AvgByVendor,
       SUM(TotalAmount) OVER (ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ORDERS
GO

 /*
<><><><><><><><><><><><><><><><><> Part 07 <><><><><><><><><><><><><><><><>
							VARIABLE DICLARETION
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/
-- DATA TYPE TEMPORARY VARIABLE
DECLARE @AGE INT
SET @AGE=25--KNOWN VALUE
GO

--ANOTHER WAY TO DECLARE
DECLARE @AGE INT=25
GO

--GLOBAL VARIABLE
DECLARE @@TOTAL MONEY
SELECT @@TOTAL=TotalAmount FROM ORDERS
WHERE TotalAmount BETWEEN 500 AND 1000
GO


 /*
<><><><><><><><><><><><><><><><><> Part 08 <><><><><><><><><><><><><><><><>
								TRANSECTION
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/
BEGIN TRANSACTION;

BEGIN TRY
    -- Declare variables
    DECLARE @CustomerName NVARCHAR(50) = 'Sadia Akter'
    DECLARE @Phone CHAR(15) = '017888888888'
    DECLARE @Email NVARCHAR(50) = 'sadia@example.com'
    DECLARE @Address NVARCHAR(100) = 'Zindabazar, Sylhet'

    -- Insert into CUSTOMERS
    INSERT INTO CUSTOMERS (cNAME, PHONE, EMAIL, cADDRESS)
    VALUES (@CustomerName, @Phone, @Email, @Address)

    COMMIT TRANSACTION;
    PRINT ' Customer inserted successfully.'
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT ' Failed to insert customer: ' + ERROR_MESSAGE()
END CATCH
GO

 /*
<><><><><><><><><><><><><><><><><><><><><><<><><><><><><><><><><><><><><><>
									END
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/