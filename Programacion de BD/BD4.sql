--11/10/21

--Temas: Reglas, tipos definidos, tipos tabla.

use TSQL2012;
GO

CREATE RULE dbo.mayorEdad
AS
@rango>=18;

CREATE TABLE temptable (
	id int primary key identity (1,1),
	nombre varchar (25) not null,
	edad int not null
)

INSERT INTO temptable (nombre, edad) values ('Juanito', 10)
select * from temptable

/*
	aplicando regla a campo edad utilizando el sp sp_brindrule

	sp_bindrule ' nombre_regla' objeto */


exec sys.sp_bindrule 'mayorEdad', 'temptable.edad'

insert into temptable(nombre, edad)
values ('Lolita', 20); --Ya se aplicò la regla, por lo tanto sòlo acepta edades mayor o iguales a 18

--Creando regla de departamento

CREATE RULE dbo.deptosPermitidos
AS
@list IN ('Managua', 'Leon', 'Chinandega')
GO

--Agregando nueva columna a la tabla
ALTER TABLE temptable add departamento varchar(20);

INSERT INTO temptable(nombre, edad, departamento)
values ('Karlita', 21, 'Esteli')

select * from temptable

--Aplicando regla a la columna departamento

exec sys.sp_bindrule 'deptosPermitidos', 'temptable.departamento'

insert into temptable (nombre, edad, departamento)
values ('Juana', 19, 'Managua')

/*
	Regla con patrones usando LIKE

	comodines:
	%: cualquier cadena con 0 o + caràcteres.
	_: cualquier caràcter (uno).
	[]: cualquier caràcter (uno), permite definir el conjunto de caràcteres.
	[^]: cualquier caràcter (uno), permite definir el conjunto de caràcteres no vàlidos.
*/

--Creando regla para que la cadena coincida con el formato de la cèdula

CREATE RULE dbo.formatocedula
AS
@values LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'

--Agregando nueva columna a la tabla
ALTER TABLE temptable add noCedula varchar (16)

EXEC sys.sp_bindrule 'formatocedula', 'temptable.noCedula'

insert into temptable(nombre, edad, departamento, noCedula)
values ('Aurora', 23, 'Chinandega', '001-010203-0000A')

select * from temptable


/*	
	Proceso para modificar regla
	1. Desenlazar la regla de los campos enlazados con ella 
		exec sp_unbindrule 'objeto'
		ejemplo:
		exec sys.sp_unbidrule 'temptable.edad';

    2. eliminar la regla
		drop rule 'nombreRgla'
		ejemplo:
		drop rule dbo.mayorEdad;

	3. Crear nueva regla modificada
		ejemplo:
		create rule dbo.mayorEdad
		as
		@rango>=16;

	4. Enlazar nuevamente la regla.
		ejemplo:

		exec sys.sp_bindrule 'mayorEdad', 'temptable.edad';
		
		luego se insertan los elementos
*/

/*
	Tipos de datos definidos 
	SQL permite definir tipos de datos personalizado, ya sea en base a un tipo de datos nativo (int, varchar, float..) o un 
	tipo de dato Tabla compuesto por columnas, sobre la que se puede realizar consultas.

	sintaxis:
	CREATE TYPE [esquema].[nombreTipo] from [tipoDato] (longitud) ...
*/

--Creando un nuevo tipo de datos para los numeros de telefonos obligatorios

CREATE TYPE dbo.noTelefonoReq FROM varchar (8) not null
CREATE TYPE dbo.noTelefono FROM varchar(8) null

ALTER TABLE temptable add noTelefono noTelefono -- tipo de dato

/*
	MODIFICACIONES
	1. crear el tipo de dato
	CREATE TYPE dbo.noTelefonoMod FROM varchar(7) null;

	2. Cambiar el tipo de dato de la columna
	ALTER TABLE temptable alter column noTelefono noTelefonoMod;
*/

--Creando tipos de datos y combinados con las reglas
CREATE TYPE dbo.noCedula FROM varchar (16) not null
EXEC sys.sp_bindrule 'formatocedula', 'dbo.noCedula'

CREATE TABLE tempTable2 (
	id int primary key identity(1,1),
	Cedula noCedula	
)

insert into tempTable2(Cedula)
values ('001-150203-1601J')

select * from tempTable2