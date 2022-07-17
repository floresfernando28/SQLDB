
--Diseño de Base de datos
--Integrante: Maria José Terán

IF DB_ID('SalesDBB') IS NOT NULL BEGIN  --si la BD existe la eliminamos para crear la nuestra
USE master DROP DATABASE SalesDBB
END

CREATE DATABASE SalesDBB
GO
USE SalesDBB
GO

CREATE TABLE ProductCategory(
	ProductCategoryID INT PRIMARY KEY IDENTITY(1,1),
	ParentProductCategoryID INT,
	Names VARCHAR(100) NOT NULL,
	ModifiedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE ProductModel(
	ProductModelID INT PRIMARY KEY IDENTITY(1,1),
	Names VARCHAR(60) NOT NULL,
	CatologDescripcion VARCHAR(60) NOT NULL,
	ModifiedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE product(
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	Names VARCHAR(60) NOT NULL,
	ProductNumber NVARCHAR(25) NOT NULL,
	Color NVARCHAR(25) NOT NULL,
	StandardCost MONEY NOT NULL,
	ListPrice MONEY NOT NULL,
	Size NVARCHAR(5) NOT NULL,
	WeightP DECIMAL(8,2) NOT NULL,
	ProductCategoryId INT,
	ProductModelID INT,
	SellStarDate DATETIME DEFAULT GETDATE(),
	SellEndDate DATETIME DEFAULT GETDATE(),
	DiscontinuedDate DATETIME DEFAULT GETDATE() NOT NULL,
	ThumbNailPhoto VARBINARY(MAX) NOT NULL,
	ThumbnailPhotoFileName NVARCHAR(50) NOT NULL,
	ModifiedDate DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (ProductCategoryId) REFERENCES ProductCategory(ProductCategoryId),  --UNIÓN CON LA TABLA ProductCategory 
	FOREIGN KEY (ProductModelID) REFERENCES ProductModel(ProductModelID) --UNIÓN DE LA TABLA ProductModel
);

CREATE TABLE ProductDescripcion(
	ProductDescripcionID INT PRIMARY KEY IDENTITY(1,1),
	Descripcion NVARCHAR(120) NOT NULL,
	ModifiedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE ProductModelProductDescripcion(
	ProductModelID INT,
	ProductDescripcionID INT,
	CONSTRAINT PK_ProductModelProductDescripcion PRIMARY KEY(ProductModelID, ProductDescripcionID),
	Culture NVARCHAR(6),
	FOREIGN KEY (ProductModelID) REFERENCES ProductModel(ProductModelID),
	FOREIGN KEY (ProductDescripcionID) REFERENCES ProductDescripcion(ProductDescripcionID),
);


--INSERTAMOS DATOS
--CATEGORIAS
INSERT INTO ProductCategory(ParentProductCategoryID,Names)
VALUES (1,'Bebidas Gaseosas')
INSERT INTO ProductCategory(ParentProductCategoryID,Names)
VALUES (2,'Galletas LEGO')

--MODELOS
INSERT INTO ProductModel(Names,CatologDescripcion) 
VALUES ('FantaEmpremar','1.3ONZAS Rojita')

--PRODUCTOS
INSERT INTO product(Names,ProductNumber,Color,StandardCost,ListPrice,
			Size,WeightP,ProductCategoryId,ProductModelID,
			ThumbNailPhoto,ThumbnailPhotoFileName)
VALUES(
	'Galletas de avena',2,'Avena :)',13,229.6,470,450.444,2,1,1,'Galletas lego :('
)
INSERT INTO product(Names,ProductNumber,Color,StandardCost,ListPrice,
			Size,WeightP,ProductCategoryId,ProductModelID,
			ThumbNailPhoto,ThumbnailPhotoFileName)
VALUES(
	'Gaseosa rojita',1,'rojita :)',12,89.6,70,40.44,1,1,1,'Pepsi :('
)


--PRODCTOS DESCRIPCION
INSERT INTO ProductDescripcion(Descripcion) VALUES ('Bebida Gaseosa inoxidable')
INSERT INTO ProductDescripcion(Descripcion) VALUES ('Galletas lego estandar 2:(')

--PRODUCTOS-MODEL --- PRODUCT-DESCRIPCION
INSERT INTO ProductModelProductDescripcion(ProductDescripcionID,ProductModelID,Culture)
VALUES(1,1,NULL)

--CONSULTAS DE LOS DATOS INGRESADOS EN LAS TABLAS
SELECT * FROM product
SELECT * FROM ProductCategory
SELECT * FROM ProductModel
SELECT * FROM ProductDescripcion
SELECT * FROM ProductModelProductDescripcion


--FIN :(


