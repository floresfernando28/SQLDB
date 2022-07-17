/*

 Se desea crear un nuevo tipo de dato para utilizarlo en campos que almacenen n�meros telef�nicos, este campo podr� ser 
 nulo, y deber� de cumplir el formato de un n�mero de tel�fono (+000 0000-0000) donde 0 representa cualquier n�mero
 
 */

use  AdventureWorks2012
go


CREATE TABLE tempTable6 (
	id int primary key identity(1,1),
	nombre varchar(25) not null,
	
);

CREATE RULE HR.formatoTelefono3
AS
@values LIKE '+[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]';


ALTER TABLE tempTable6 add noTelefono3 varchar(14)

EXEC sys.sp_bindrule 'HR.formatoTelefono3', 'tempTable6.noTelefono3'

CREATE TYPE HR.noTelefono2 FROM varchar(14)null

insert into tempTable6 (nombre, noTelefono3)
VALUES (
	'MAYDAY',
	'+505 8669-9317'
);
SELECT * FROM tempTable6

/*

 Se desea crear un nuevo tipo de datos para ser utilizado en campos que almacenen n�meros de tarjeta de cr�dito,
 este campo deber� de ser obligatorio y cumplir con el formato de una tarjeta de cr�dito (0000 0000 0000 0000) 
 donde 0 representa cualquier n�mero 
 
 */


CREATE TABLE PersonCreditCard (
	Id int primary key identity(1,1),
	Nombre varchar(25) not null
);


CREATE RULE dbo.formatoCreditCard
AS
@values LIKE '[0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9]';

ALTER TABLE PersonCreditCard add NoCreditCard varchar(19)

EXEC sys.sp_bindrule 'formatoCreditCard', 'PersonCreditCard.NoCreditCard'

CREATE TYPE dbo.formatoCreditCard FROM varchar(19)  NOT null

insert into PersonCreditCard (Nombre, NoCreditCard)
VALUES (
	'brayan flores',
	'4220 1221 1234 4565'
);


insert into PersonCreditCard (Nombre, NoCreditCard)
VALUES (
	'fernando flores',
	'4112 1234 5678 9876'
);

SELECT * FROM [PersonCreditCard]