/*
	Cuando se trabaja con bases de datos y procedimientos almacenados, no veremes en la necesidad
	de pasa al procedimiento almacenado multiples valores en unico parametro.

	SQL Server no ofrece la posibilidad de crear tipos de tablas definidas por el usuario, con
	multiples columnas y tipos de datos.

	La ventaja de crear tipos de datos tabla, es que estos pueden ser reutilizados, en distintos
	procedimientos almacenados.

	Sintaxis
	
	CREATE TYPE [esquema].[nombreTipoTabla] AS TABLE
	(
		nombreColumna1 tipoDato(longitud),
		nombreColumna2 tipoDato(longitud)
	)
	GO

*/

USE TSQL2012;
GO

DROP TYPE Sales.OrderDetailUDT

CREATE TYPE Sales.OrderDetailUDT as TABLE(
	orderId int null,
	productId int not null,
	unitPrice money not null,
	qty smallint not null,
	discount numeric(4,3) not null
)
GO

declare @detalles Sales.OrderDetailUDT

insert into @detalles(productId, unitPrice,qty, discount)
VALUES (
	1, 10.5,1,0
)

SELECT * from @detalles
GO

CREATE PROCEDURE Sales.spCreateOrder
	@custId int null,
	@empId int,
	@requiredDate datetime,
	@shipperId int,
	@freight money,
	@shipName nvarchar(40),
	@shippAddress nvarchar(60),
	@shipCity nvarchar(15),
	@shipRegion nvarchar(15) null,
	@shipPostalCode nvarchar(10) null,
	@shipCountry nvarchar(15),
	@orderDetails Sales.OrderDetailUDT READONLY
AS
BEGIN
	INSERT INTO Sales.Orders(
		custid,
		empid,
		orderdate,
		requireddate,
		shipperid,
		freight,
		shipname,
		shipaddress,
		shipcity,
		shipregion,
		shippostalcode,
		shipcountry)
	VALUES(
		@custId, @empId, GETDATE(), @requiredDate,@shipperId,@freight,@shipName,
		@shippAddress,@shipCity, @shipRegion,@shipPostalCode,@shipCountry
	)

	declare @orderId int
	set @orderId=@@IDENTITY


	declare @orderDetailToInsert Sales.OrderDetailUDT

	INSERT INTO @orderDetailToInsert 
	SELECT * from @orderDetails


	UPDATE @orderDetailToInsert set orderId=@orderId

	insert into Sales.OrderDetails(orderid,productid,unitprice,qty,discount)	
	select orderId,productId,unitPrice,qty,discount
	FROM @orderDetailToInsert
END
GO


----------------------------------------------


DECLARE @detalles Sales.OrderDetailUDT

insert into @detalles(productId,unitPrice,qty,discount)
VALUES (1,10.5,2,0)

insert into @detalles(productId,unitPrice,qty,discount)
VALUES (2,18.5,4,0)

insert into @detalles(productId,unitPrice,qty,discount)
VALUES (3,100.25,40,0)

EXEC Sales.spCreateOrder 1,1,'20211224',1,3210.99,
	'La Barca','Mi casa','MGA',null,null,'Managua',@detalles

select * from Sales.Orders

select * from Sales.OrderDetails
WHERE orderid=11078