/*

 Se desea crear un nuevo tipo de dato para utilizarlo en campos que almacenen números telefónicos, este campo podrá ser 
 nulo, y deberá de cumplir el formato de un número de teléfono (+000 0000-0000) donde 0 representa cualquier número
 
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

 Se desea crear un nuevo tipo de datos para ser utilizado en campos que almacenen números de tarjeta de crédito,
 este campo deberá de ser obligatorio y cumplir con el formato de una tarjeta de crédito (0000 0000 0000 0000) 
 donde 0 representa cualquier número 
 
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