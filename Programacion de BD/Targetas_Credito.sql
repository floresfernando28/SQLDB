/*

 Se desea crear un nuevo tipo de datos para ser utilizado en campos que almacenen números de tarjeta de crédito,
 este campo deberá de ser obligatorio y cumplir con el formato de una tarjeta de crédito (0000 0000 0000 0000) 
 donde 0 representa cualquier número 
 
 */

 USE AdventureWorks2012;
 GO


CREATE TABLE registros_Names(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Usuario VARCHAR(50) NOT NULL,
	Apellidos VARCHAR(50) NOT NULL,
);

CREATE RULE dbo.TargetaCredito AS
@values LIKE '[0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]';
ALTER TABLE registros_Names ADD Numero_Targeta VARCHAR (19)
EXEC sys.sp_bindrule 'TargetaCredito', 'registro_Names.Numero_Targeta'

CREATE TYPE dbo.TargetaCredito FROM VARCHAR (19) NOT Null

INSERT INTO registros_Names (Nombre_Usuario, Apellidos, Numero_Targeta) VALUES ('Sutanito', 'Perez Loasiga','4456 3456 1232 7890');
INSERT INTO registros_Names (Nombre_Usuario, Apellidos, Numero_Targeta) VALUES ('Fernando Jose', 'Flores Mendoza','4532 1123 6786 2312');
INSERT INTO registros_Names (Nombre_Usuario, Apellidos, Numero_Targeta) VALUES ('Bryan Ernesto', 'Flores Mendoza','4422 9876 4567 7890');
INSERT INTO registros_Names (Nombre_Usuario, Apellidos, Numero_Targeta) VALUES ('Carlos Jose', 'Perez Prado','4578 8999 2345 9809');


SELECT * FROM registros_Names
