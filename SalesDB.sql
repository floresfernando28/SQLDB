--SISTEMATICO DE TABLAS RELACIONALES DE BD (SQL)
--Estudiante: Juan Andrés Aguilar Luna

CREATE DATABASE SalesDB
GO
USE SalesDB
GO

CREATE TABLE product(
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	NameProduct VARCHAR(60),
	ProductNumber NVARCHAR(25),
	Color NVARCHAR(25),
	StandardCost MONEY,
	ListPrice MONEY,
	Size NVARCHAR(5),
	WeightP DECIMAL(8,2),
	ProductCategoryId INT,
	ProductModelID INT,
	SellStarDate DATETIME,
	SellEndDate DATETIME,
	DiscontinuedDate DATETIME,
	ThumbNailPhoto VARBINARY(MAX),
	ThumbnailPhotoFileName NVARCHAR(50),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY IDENTITY(1,1) ,
	NameStyle VARCHAR(50),
	Title NVARCHAR(100),
	FistName VARCHAR(50),
	MiddleName VARCHAR(50),
	LastName VARCHAR(50),
	Suffix NVARCHAR(10),
	CompanyName NVARCHAR(128),
	SalesPerson NVARCHAR(256),
	EmailAddress NVARCHAR(50),
	Phone VARCHAR(10),
	PasswordHash VARCHAR(128),
	PasswordSalt VARCHAR(10),
	ModifiedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE SalesOrderHeader(
	SalesOrderID INT PRIMARY KEY IDENTITY(1,1),
	RevisionNumber TINYINT NOT NULL,
	OrderDate DATETIME DEFAULT GETDATE(),
	DueDate DATETIME DEFAULT GETDATE(),
	ShipDate DATETIME DEFAULT GETDATE(),
	StatusSales TINYINT NOT NULL,
	OnlineOrderFlag VARCHAR(50),
	SalesOrderNumber VARCHAR(120),
	PurchaseOrderNumber VARCHAR(50),
	AccountNumber VARCHAR(50),
	CustomerID INT,
	ShipToAddressID INT,
	BillToAddressID INT,
	ShipMethod NVARCHAR(50),
	CreditCardApprovalCode VARCHAR(15),
	SubTotal MONEY,
	TaxAmt MONEY,
	Freight MONEY ,
	TotalDue VARCHAR(120),
	Comment NVARCHAR(MAX),
	ModifiedDate DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE SalesOrderDetail(
	SalesOrderDetailID INT PRIMARY KEY IDENTITY(1,1),
	SalesOrderId INT,
	ProductID INT,
	OrderQTY SMALLINT,
	UnitPrice MONEY,
	UnitPriceDiscount MONEY,
	LineTotal VARCHAR(120),
	ModifiedDate DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
	FOREIGN KEY (SalesOrderID) REFERENCES SalesOrderHeader(SalesOrderID)
);
