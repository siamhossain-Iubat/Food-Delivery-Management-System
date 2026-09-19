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
							PART 01--LINE NO 28 TO 59
							PART 02--LINE NO 68 TO 468
							PART 03--LINE NO 477 TO 564
							PART 04--LINE NO 572 TO 612

*/
USE master
go
/*
<><><><><><><><><><><><><><><><><> Part 01 <><><><><><><><><><><><><><><><>
	 <#> Create Database with Name,Filename,Size,Maximum Size, Filegrowth
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/
CREATE DATABASE FDMS
ON
	( 
	  NAME='FDMS_DATAFILE',
	  FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\FDMS_DATAFILE.MDF',
	  SIZE=5MB,
	  MAXSIZE=100MB,
	  FILEGROWTH=5%
	)
LOG ON
	( 
	  NAME='FDMS_LOGFILE',
	  FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\FDMS_LOGFILE.LDF',
	  SIZE=2MB,
	  MAXSIZE=50MB,
	  FILEGROWTH=2%
	)
GO
--########## Assurance of Database Creation ###########--
IF EXISTS(SELECT name FROM SYS.databases WHERE name='FDMS')
	BEGIN
		PRINT 'DATABASE HAS BEEN FOUND'
	END
ELSE 
	BEGIN 
		PRINT 'THERE IS NO DATABASE FOUNF WITH THE NAME FDMS'
	END
GO
/*
<><><><><><><><><><><><><><><><><> Part 02 <><><><><><><><><><><><><><><><>
							<#> Create SQL Object
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>><><><>
*/
USE FDMS
GO
--############# Create a Sequence for customerid which will start from 1001 and Incremented for +1 ############--
CREATE SEQUENCE sqCusmtomerID
	START WITH 1001
	INCREMENT BY 1
	MINVALUE 1001
	MAXVALUE 1000001
	CYCLE 
GO

				/************************************************
								Creating Tables 
				************************************************/

CREATE TABLE CUSTOMERS
(
	ID INT PRIMARY KEY IDENTITY(1,1),
	cNAME NVARCHAR(50) NOT NULL,
	PHONE CHAR(15) UNIQUE NOT NULL  CHECK(PHONE LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	EMAIL NVARCHAR(50) UNIQUE CONSTRAINT ck_emailCheck CHECK (Email LIKE '%@%'),
	cADDRESS NVARCHAR(100) NOT NULL
)
GO

CREATE TABLE RIDERS
(
	ID INT PRIMARY KEY  DEFAULT (NEXT VALUE FOR sqCusmtomerID),
	rNAME NVARCHAR(30) NOT NULL,
	PHONE CHAR(15) UNIQUE NOT NULL CHECK(PHONE LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	PAYACCOUNT VARCHAR(15) NOT NULL
)
GO

CREATE TABLE VENDORS 
( 
	ID INT IDENTITY(1000,1) PRIMARY KEY,
	vNAME NVARCHAR(100) NOT NULL,
	vLOCATION NVARCHAR(100) NOT NULL,
	PHONE CHAR(15) UNIQUE NOT NULL CHECK(PHONE LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	OpeningTime TIME,
	ClosingTime TIME 
) 
GO

CREATE TABLE CETAGORIES
(
	ID INT IDENTITY(100,100) PRIMARY KEY,
	cetagoryNAME NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE ORDERS
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	VendorID INT REFERENCES VENDORS(ID)NOT NULL,
	RiderID INT REFERENCES RIDERS(ID) NOT NULL,
	CustomerID INT REFERENCES CUSTOMERS(ID) NOT NULL,
	OrderDate DATETIME DEFAULT GETDATE(),
	OrderStatus NVARCHAR(30) CHECK (OrderStatus IN ('PENDING','ON THE WAY','DELIVARED','CANCELLED')) NOT NULL,
	DelivaryFee MONEY DEFAULT 50,
	TotalAmount MONEY CHECK (TotalAmount>0) NOT NULL
)
GO

CREATE TABLE ManuItems
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	VendorID INT REFERENCES VENDORS(ID) NOT NULL,
	CetagoryID INT REFERENCES CETAGORIES(ID),
	ItemName NVARCHAR(100) NOT NULL,
	PRICE MONEY CHECK (PRICE>0) NOT NULL
)
GO

CREATE TABLE OrderItem
(
	OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT REFERENCES ORDERS(ID) NOT NULL,
	ManuID INT REFERENCES ManuItems(ID) NOT NULL
	)
GO


CREATE TABLE PAYMENTS
(
	PaymentID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT REFERENCES ORDERS(ID) NOT NULL,
	AMOUNT DECIMAL(8,2) NOT NULL,
	PaymentMathod NVARCHAR(50) CHECK (PaymentMathod IN ('CASH','CARD','MOBILE BANGKING')) NOT NULL,
	PAYMENTDATE DATETIME DEFAULT GETDATE() NOT NULL
)
GO

CREATE TABLE RiderPayments
(
	RiderPaymentID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT REFERENCES ORDERS(ID),
	RiderID INT REFERENCES RIDERS(ID),
	PaymentDate DATETIME,
	AmountPaid DECIMAL(8,2)
)
GO

--########### Table with composite PRIMARY KEY #############--

CREATE TABLE RestaurantCategory
(
	VendorID INT REFERENCES VENDORS(ID),
	CetagoryID INT REFERENCES CETAGORIES(ID),
	PRIMARY KEY(VendorID,CetagoryID)
)
GO

					/************************************************
									Creating SCHEMA 
					************************************************/

CREATE SCHEMA rrr--(RIDER and Restuarent Review)
GO

--########### CREATE TABLE USING SCHEMA #############--
CREATE TABLE rrr.Reviews
(
	ReviewID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT REFERENCES ORDERS(ID),
	Retings NVARCHAR(50) NOT NULL CHECK (Retings IN('1','2','3','4','5')),
	Comments  NVARCHAR (250)
)
GO
						/************************************************
										Creating VIEWS
						************************************************/

--1.########### CREATE A VEIW FOR RETRIVING IMPORTENT ORDER DETAILS WITH ENCRYPTION #############--

CREATE VIEW vOrderDetails
WITH ENCRYPTION--(ENCRYPTION WILL NOT ALLOW OTHERS TO SEE THE VIEW TEXT OR WHAT THE VIEW CONTAIN)
AS
SELECT  O.ID AS 'ORDER iD',
		C.cNAME AS 'CUSTOMER NAME',
		C.PHONE AS 'CUSTOMER NUMBER',
		V.vNAME AS 'RESTAURANT NAME',
		V.vLOCATION AS 'RESTAURANT ADDRESS',
		V.PHONE AS 'RESTAURANT NUMBER',
		M.ItemName AS 'ITEMS',
		M.PRICE AS 'PRICE',
		R.rNAME AS 'DELIVARY HERO',
		R.PHONE AS 'RIDERS CONTACT',
		C.cADDRESS AS 'CUSTOMER ADDRESS',
SUM(M.PRICE) OVER (PARTITION BY O.ID) AS 'RESTAURANT BILL',
(SUM(M.PRICE) OVER (ORDER BY O.ID)*0.9) AS 'RESTAURANT NET BILL',
(SUM(M.PRICE) OVER (ORDER BY O.ID)+O.DelivaryFee) AS 'CUSTOMER BILL'
FROM ORDERS O
JOIN VENDORS V ON V.ID=O.VendorID
JOIN ManuItems M ON M.VendorID=O.VendorID
JOIN RIDERS R ON R.ID=O.RiderID
JOIN CUSTOMERS C ON C.ID=O.CustomerID
GO

--2.########### CREATE A  VEIW FOR INSERTING DATA INTO [CETAGORIES] TABLE #############--

CREATE VIEW vInsertIntoCETAGORIES
AS
SELECT ID,cetagoryNAME FROM CETAGORIES
GO

--3.########### CREATE A VIEW WITH SUB QUEARY #############--
CREATE VIEW vSUBQUERY
AS
SELECT ID AS OrderID,VendorID AS 'RESTUARENT ID', (SELECT vNAME FROM VENDORS V) AS 'RESTAURANT NAME',CustomerID,OrderDate,TotalAmount
FROM ORDERS 
WHERE OrderStatus='DELIVARED'
GO

--4.########### CREATE A VIEW CALCULATE A RESTAURANT TOTAL PAYMENT #############--
CREATE VIEW vCalculateRiderPayment
AS
SELECT RiderID,SUM(AmountPaid) AS 'TOTAL EARNINGS' FROM RiderPayments
GROUP BY RiderID
GO

--5.########### CREATE A VIEW FOR RESTRICT {ORDERS} DATA FROM DELETION #############--
CREATE VIEW dbo.vNoUpdateDelete
WITH SCHEMABINDING--(SCHEMABINDING WILL PREVENT USERS TO UPDATE AND DELETE DATA FROM THE BASE TABLE WHOM HAS BEEN USED IN THIS VIEW)
AS 
SELECT * FROM ORDERS
WHERE OrderStatus='DELIVARED'
GO

--5.########### CREATE A VIEW WITH TOP CLOSE AND ORDER BY #############--
CREATE VIEW vTopTenPaybleOrders
AS
SELECT TOP 10 
		ID,VendorID,CustomerID,OrderDate,OrderStatus,
		SUM(TotalAmount) OVER (PARTITION BY ID) AS 'BILL'  FROM ORDERS
WHERE OrderStatus='DELIVARED'
ORDER BY BILL
GO

							/************************************************
											Creating STORE PROCEDURE
							************************************************/

--1.########### CREATE STROE PROCEDURE FOR INSERTING DATA INTO [CUSTOMERS]  TABLE #############--
CREATE PROC spInsertInto_CUSTOMERS
									@NAME NVARCHAR(50),
									@PHONE CHAR(15),
									@MAIL NVARCHAR(50),
									@ADDRESS NVARCHAR(100)
AS
BEGIN
INSERT INTO CUSTOMERS(cNAME,PHONE,EMAIL,cADDRESS) VALUES (@NAME,@PHONE,@MAIL,@ADDRESS)
END
GO

--2.########### CREATE STROE PROCEDURE FOR INSERTING DATA USING (BEGIN TRY/CATCH TRY) #############--
CREATE PROC spInsertInto_CUSTOMERS_2
									@NAME NVARCHAR(50),
									@PHONE CHAR(15),
									@MAIL NVARCHAR(50),
									@ADDRESS NVARCHAR(100)
AS
BEGIN
	BEGIN TRY
		INSERT INTO CUSTOMERS(cNAME,PHONE,EMAIL,cADDRESS) values (@NAME,@PHONE,@MAIL,@ADDRESS)
		PRINT 'DATA HAS BEEN  INSERTED'
	END TRY
	BEGIN CATCH
		PRINT 'DATA HAS NOT BEEN INSERTED DEU TO A INVALID DATA INPUT'
	END CATCH
END
GO

--3.########### CREATE STROE PROCEDURE FOR INSERTING DATA USING [RAISERROR] #############--
CREATE PROC spInsertIntoWithRAISEERROR
									@NAME NVARCHAR(50),
									@PHONE CHAR(15),
									@MAIL NVARCHAR(50),
									@ADDRESS NVARCHAR(100)
AS
BEGIN
	BEGIN TRY
		INSERT INTO CUSTOMERS(cNAME,PHONE,EMAIL,cADDRESS) values (@NAME,@PHONE,@MAIL,@ADDRESS)
		PRINT 'DATA HAS BEEN  INSERTED'
	END TRY
	BEGIN CATCH
		RAISERROR('WRONG ENTRY',10,1)--RAISERROR USED TO SHOW A CUSTOM ERROR MESSEGE AND ERROR'S LAVEL
	END CATCH
END
GO

--4.########### CREATE STROE PROCEDURE FOR INSERTING DATA WITH OUTPUT PERAMETER #############--
CREATE PROC spInsertWithOutput
									@NAME NVARCHAR(50),
									@PHONE CHAR(15),
									@MAIL NVARCHAR(50),
									@ADDRESS NVARCHAR(100),
									@ID INT OUTPUT
AS
BEGIN
INSERT INTO CUSTOMERS(cNAME,PHONE,EMAIL,cADDRESS) VALUES (@NAME,@PHONE,@MAIL,@ADDRESS)
SELECT @ID=IDENT_CURRENT('CUSTOMERS')
END
GO

--5.########### CREATE STROE PROCEDURE FOR UPDATING DATA  #############--
CREATE PROC spUpdateAddress
									@ID INT,
									@NAME NVARCHAR(50),
									@PHONE CHAR(15),
									@MAIL NVARCHAR(50),
									@ADDRESS NVARCHAR(100)
AS
BEGIN
UPDATE CUSTOMERS
SET 
	cNAME=@NAME,
	PHONE=@PHONE,
	EMAIL=@MAIL,
	cADDRESS=@ADDRESS
WHERE ID=@ID
END
GO

--6.########### CREATE STROE PROCEDURE FOR DELETING A DATA #############--

CREATE PROC spDeleteData @ID INT
AS 
BEGIN
	DELETE FROM CUSTOMERS
	WHERE ID=@ID
END
GO
					/************************************************
								Creating USER DEFIND FUNCTION
					************************************************/
--1.########### CREATE SCALER FUNCTION #############--
CREATE FUNCTION fnCLC_riderPayment (@RiderID INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @TOTAL INT
		SELECT @TOTAL=SUM(DelivaryFee) FROM ORDERS
		WHERE RiderID=@RiderID AND OrderStatus='DELIVARDER'
	RETURN ISNULL(@TOTAL,0)
END
GO
--2.########### CREATE INLINE TABLE VALUED FUNCTION #############--
CREATE FUNCTION fnCLC_ridersPayment ()
RETURNS TABLE
AS
RETURN
	(SELECT RiderID,
	SUM(DelivaryFee) AS 'Total Earnig' FROM ORDERS
	WHERE OrderStatus='DELIVARDER'
	GROUP BY RiderID)
GO

--3.########### CREATE MULTISTATEMENT TABLE VALUED FUNCTION #############--
CREATE FUNCTION fnPaymentCalc ()
RETURNS @PaymentSummary TABLE
(
	OrderID INT,
	RiderID INT,
	RiderPayment MONEY,
	RestaurantPayment MONEY,
	CustomerPayment MONEY
)
AS
BEGIN
INSERT INTO @PaymentSummary(OrderID,RiderID,RiderPayment,RestaurantPayment,CustomerPayment)
	SELECT O.ID AS 'ORDERID',O.RiderID AS RiderID,SUM(O.DelivaryFee) AS 'RiderPayment',
	SUM(MI.PRICE)*0.90 AS 'RETAURANT BILL',
	SUM(MI.PRICE)+SUM(O.DelivaryFee) AS 'CUSTOMER BILL'
	FROM ORDERS O
	JOIN ManuItems MI ON O.VendorID=MI.VendorID
	JOIN OrderItem OI ON OI.OrderID=MI.ID
	WHERE O.OrderStatus='DELIVARED'
	GROUP BY O.ID,O.RiderID
	RETURN
END
GO


							/************************************************
											Creating TRIGGER
							************************************************/
--1.########### CREATE AFTER/FOR TRIGGER #############--
CREATE TRIGGER trUpdateDate
ON ORDERS 
FOR UPDATE--DELIVARY DATE WILL AUTO UPDATED WITH THE PRESENT DATE WHEN DELIVARY STATUS BECOMES [DELIVARED]
AS 
BEGIN
	UPDATE ORDERS
	SET DelivaryDate=GETDATE()
	FROM ORDERS O
	JOIN inserted I ON I.ID=O.ID
	WHERE I.OrderStatus='DELIVARED' AND O.DelivaryDate IS NULL
END
GO

--2.########### CREATE AFTER/FOR TRIGGER #############--
CREATE TRIGGER trUpdateOrderTotal
ON OrderItem
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    UPDATE o
    SET o.TotalAmount = 
		(
		SELECT SUM(mi.Price)
		FROM OrderItem oi
		INNER JOIN ManuItems mi ON oi.OrderItemID=mi.ID
		)+DelivaryFee 
		FROM Orders o
		INNER JOIN 
	(
        SELECT DISTINCT OrderID FROM inserted
        UNION
        SELECT DISTINCT OrderID FROM deleted
    )
	x ON o.ID = x.OrderID
END
GO

--2.########### CREATE AFTER/FOR TRIGGER #############--
CREATE TRIGGER trValidateRiderPayment
ON RiderPayments
INSTEAD OF INSERT--RIDERPAYMENT CAN BE ONLY UPDATED WHEN RIDER HAVE A DELIVERED ORDER
AS
BEGIN

    INSERT INTO RiderPayments (RiderID, AmountPaid, PaymentDate)
    SELECT i.RiderID, i.AmountPaid, i.PaymentDate
    FROM inserted i
    WHERE EXISTS 
				(
				SELECT 1 
				FROM Orders o
				WHERE o.RiderID = i.RiderID AND o.OrderStatus = 'Delivered'
			   	)
END
GO


/*
<><><><><><><><><><><><><><><><><> Part 03 <><><><><><><><><><><><><><><><>
								ALTER SQL OBJECTS
<><><><><><><><><><><><><><>>><><><><><><><><><><><><><><><><><><><><><><><>
*/

--1.########### ALTER A TABLE FROM CUSTOM SCHEMA {rrr} TO DEFAULT SCHEMA {dbo} #############--

ALTER SCHEMA dbo TRANSFER  rrr.Reviews
GO

--2.########### ALTER A TABLE TO ADD COLUMN #############--
ALTER TABLE ORDERS
ADD DELIVARYDATE DATETIME
GO

--3.########### ALTER A TABLE TO ADD COLUMN #############--

ALTER TABLE ORDERS
ADD DELIVARYTIME DATE
GO

--4.########### ALTER A TABLE TO DROP COLUMN #############--
ALTER TABLE ORDERS
DROP DELIVARYTIME 
GO

--5.########### ALTER A TABLE TO ADD CONSTRAINTS #############--
ALTER TABLE RIDERPAYMENTS
ADD CONSTRAINT CH_AMOUNTCHEKC CHECK(AMOUNTPAID>0)
GO

--6.########### ALTER A TABLE TO DROP CONSTRAINTS #############--
ALTER TABLE RIDERPAYMENTS
DROP CONSTRAINT CH_AMOUNTCHEKC 
GO

--7.########### ALTER AN INDEX #############--

ALTER INDEX [PK__VENDORS__3214EC2761E0CFF9]
ON VENDORS
REORGANIZE
GO

ALTER VIEW vCalculateRiderPayment
AS
SELECT RP.RiderID,SUM(RP.AmountPaid) AS 'TOTAL EARNINGS' FROM RiderPayments RP
JOIN ORDERS O ON O.RiderID=RP.RiderID
WHERE O.OrderStatus='DELIVARED'
GROUP BY RP.RiderID
GO

--8.########### ALTER  STORE PROCEDURE #############--

ALTER PROC spInsertInto_CUSTOMERS
									@NAME NVARCHAR(50),
									@PHONE CHAR(15),
									@MAIL NVARCHAR(50),
									@ADDRESS NVARCHAR(100)
AS
BEGIN
INSERT INTO CUSTOMERS(cNAME,PHONE,EMAIL,cADDRESS) VALUES (@NAME,@PHONE,@MAIL,@ADDRESS)

PRINT 'DATA INSERTED'
END
GO

--9.########### ALTER  UDF #############--
ALTER FUNCTION fnCLC_riderPayment (@RiderID INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @TOTAL INT
		SELECT @TOTAL=SUM(DelivaryFee) FROM ORDERS
		WHERE RiderID=@RiderID AND OrderStatus='DELIVARDER'
		GROUP BY RiderID
	RETURN @TOTAL
END
GO

--9.########### ALTER  TRIGGER #############--
ALTER TRIGGER trUpdateDate
ON ORDERS 
FOR UPDATE--DELIVARY DATE WILL AUTO UPDATED WITH THE PRESENT DATE WHEN DELIVARY STATUS BECOMES [DELIVARED]
AS 
BEGIN
	UPDATE O
	SET OrderDate=GETDATE()
	FROM ORDERS O
	JOIN inserted I ON I.ID=O.ID
	WHERE I.OrderStatus='DELIVARED' AND O.OrderDate IS NULL
END
GO
GO

/*
<><><><><><><><><><><><><><><><><> Part 04 <><><><><><><><><><><><><><><><>
								DROP SQL OBJECTS
<><><><><><><><><><><><><><>>><><><><><><><><><><><><><><><><><><><><><><><>
*/

--1.########### DROP  SCHEMA #############--
DROP SCHEMA rrr
GO

--2.########### DROP  SEQUENCE #############--
/*
DROP SEQUENCE sqCusmtomerID
GO
*/
GO

--3.########### DROP  COLUMN #############--
ALTER TABLE ORDERS
DROP DELIVARYTIME 
GO

--4.########### DROP  TABLE #############--
DROP TABLE [rrr].[Reviews]
GO

--5.########### DROP  VIEW #############--
DROP VIEW  vTopTenPaybleOrders
GO

--6.########### DROP  STORE PROCEDURE #############--\
DROP PROC spDeleteData
GO

--7.########### DROP  UDF #############--
--THIS STATMENT WILL BE UNDER COMMENT BECAUSE THE FUNCTION IS BEING USED
/*
DROP FUNCTION dbo.fnCLC_riderPayment 
GO
*/
GO
--8.########### DROP  TRIGGER #############--
--THIS STATEMENT WILL BE UNDER COMMENT BECAUSE THE TRIGGER IS BEING USED
/*
DROP TRIGGER trUpdateOrderTotal
GO
*/

/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
								END
<><><><><><><><><><><><><><>>><><><><><><><><><><><><><><><><><><><><><><><>
*/