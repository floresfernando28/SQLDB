/*

 Se desea crear un nuevo tipo de dato para utilizarlo en campos que almacenen números telefónicos, este campo podrá ser 
 nulo, y deberá de cumplir el formato de un número de teléfono (+000 0000-0000) donde 0 representa cualquier número
 
 */


USE  AdventureWorks2012;
GO

CREATE TABLE registros_Name(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Usuario varchar(50) Not Null,
	Apellido VARCHAR(50) NOT NULL,
);

CREATE RULE dbo.NumeroTelefono AS
@values LIKE '+[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]';

ALTER TABLE registros_Name ADD Numero_Telefono VARCHAR (14)
EXEC sys.sp_bindrule 'dbo.NumeroTelefono', 'Registro_Name.N_Telefono'

CREATE TYPE dbo.Telefono FROM VARCHAR (14) Null


INSERT INTO registros_Name (Nombre_Usuario, Apellido, Numero_Telefono) VALUES ('juan jose', 'Ruiz Lopez','+505 8669-9317');
INSERT INTO registros_Name (Nombre_Usuario, Apellido, Numero_Telefono) VALUES ('Americo Jose', 'Ruiz Fonseca','+505 8899-0909');
INSERT INTO registros_Name (Nombre_Usuario, Apellido, Numero_Telefono) VALUES ('Luis Daniel', 'Sìu Peralta','+505 7898-1234');
INSERT INTO registros_Name (Nombre_Usuario, Apellido, Numero_Telefono) VALUES ('Rosa Guadalupee', 'Calvo Lopez','+505 8675-9675');


SELECT * FROM Registros_Name