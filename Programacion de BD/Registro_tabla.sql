/*
  Crear un tipo de dato que pueda ser utilizado para registrar varios registros de la tabla
  Sales.SalesOrderDetail de la base de datos AdventureWorks2012
*/

USE AdventureWorks2012;
GO


CREATE TYPE Sales.OrderDetailUDT0 as TABLE(
	SalesOrderId INT null,
	SalesOrderDetaillD INT not null,
	CarrierTrackingNumber NVARCHAR(25) null,
	OrderQty SMALLINT not null,
	ProductId INT not null,
	SpecialOfferId INT not null,
	UnitPrice MONEY not null,
	UnitPriceDiscount MONEY not null,
	Linetotal NUMERIC(38,6) not null,
	rowguid uniqueidentifier not null,
	ModifiedDate DATETIME not null
)
GO


CREATE PROCEDURE Sales.spCreateOrder0
	@RevisionNumber tinyint,
	@OrderDate DATETIME,
	@DueDate DATETIME,
	@ShipDate datetime null,
	@Status tinyint,
	@PurchaseOrderNumber NVARCHAR(25) null,
	@AccountNumber NVARCHAR(15) null,
	@CustomerId INT,
	@SalesPersonId INT null,
	@TerritoryId INT null,
	@BillToAddressId INT,
	@ShipToAddresId INT,
	@ShipMethodId INT,
	@CreditCardId INT null,
	@CreditCardApprovalCode VARCHAR(15) null,
	@CurrencyRateId INT null,
	@SubTotal MONEY,
	@TaxAmt MONEY,
	@Freight MONEY,
	@TotalDue MONEY,
	@Comment NVARCHAR(128) null,
	@rowguid uniqueidentifier,
	@ModifiedDate DATETIME,
	@orderDetails Sales.OrderDetailUDT0 READONLY
AS
BEGIN
	INSERT INTO Sales.SalesOrderHeader(
		RevisionNumber,OrderDate,DueDate,ShipDate,Status,PurchaseOrderNumber,AccountNumber,CustomerID,SalesPersonID,TerritoryID,BillToAddressID,
		ShipToAddressID,ShipMethodID,CreditCardID,CreditCardApprovalCode,CurrencyRateID,SubTotal,TaxAmt,Freight,TotalDue,Comment,rowguid,ModifiedDate)
	VALUES(
		@RevisionNumber, GETDATE(), @DueDate, @ShipDate,@Status,@PurchaseOrderNumber,@AccountNumber,@CustomerId,@SalesPersonId,@TerritoryId,@BillToAddressId,
		@ShipToAddresId,@ShipMethodId,@CreditCardId,@CreditCardApprovalCode,@CurrencyRateId,@SubTotal,@TaxAmt,@Freight,@TotalDue,@Comment,@rowguid,@ModifiedDate
	)
	DECLARE @SalesorderId INT
	SET @SalesorderId=@@IDENTITY


	DECLARE @orderDetailIngresar Sales.OrderDetailUDT0

	INSERT INTO @orderDetailIngresar
	SELECT * FROM @orderDetails


	UPDATE @orderDetailIngresar SET @SalesorderId=@SalesorderId

	INSERT INTO Sales.SalesOrderDetail ( SalesOrderId, SalesOrderDetailID, CarrierTrackingNumber ,OrderQty ,ProductId ,SpecialOfferId , UnitPrice ,UnitPriceDiscount , Linetotal , rowguid , ModifiedDate)
	SELECT SalesOrderId, SalesOrderDetaillD, CarrierTrackingNumber ,OrderQty ,ProductId ,SpecialOfferId , UnitPrice ,UnitPriceDiscount , Linetotal , rowguid , ModifiedDate
	FROM @orderDetailIngresar
END
GO