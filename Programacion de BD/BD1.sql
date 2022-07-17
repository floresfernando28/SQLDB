use TSQL2012;
GO

/*
	Las reglas definen los valores aceptables de la columna
	o tipo de datos al que se le aplican

	* Esta caracteristica sera removida de futuras 
	implementaciones

	Sintaxis

	CREATE RULE [esquema].[nombre_regla]
	AS condicion(es)
*/

-- Creando Regla
CREATE RULE dbo.mayorEdad
AS
@rango>=18;

CREATE TABLE tempTable (
	id int primary key identity(1,1),
	nombre varchar(25) not null,
	edad int not null
)

insert into tempTable (nombre, edad) values ('Juanito',10)
select * from tempTable

/* 
	aplicando regla a campo edad utilizando el sp sp_bindrule 

	sp_bindrule 'nombre_regla' objeto

*/
exec sys.sp_bindrule 'mayorEdad', 'tempTable.edad'

insert into tempTable(nombre,edad) 
values ('Anita', 18);

-- Creando regla de departementos

CREATE RULE dbo.deptosPermitidos
AS
@list IN ('Managua', 'Leon', 'Chinandega')
GO

ALTER TABLE tempTable add departemento varchar(20);

insert into tempTable(nombre,edad,departemento)
values ('Karlita',21,'Esteli')

select * from tempTable

-- aplicando regla a la columna departemento

exec sys.sp_bindrule 'deptosPermitidos', 'tempTable.departemento'

insert into tempTable(nombre,edad,departemento)
values ('Karlito',19,'Managua')


/*
	Regla con patrones usando like
	
	Comodines

	% cualquier cadena con 0 o más caracteres
	_ Cualquier caracter (uno)
	[] Cualquier caracter (uno), permite definir el conjunto de caracteres
	[^] Cualquier caracter (uno), permite definir el conjunto de caracteres
		no validos
*/


-- Creando regla para que la cadena coicida con el formato de la cedula

CREATE RULE dbo.formatoCedula
AS
@values LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]';


ALTER TABLE tempTable add noCedula varchar(16)

EXEC sys.sp_bindrule 'formatoCedula', 'tempTable.noCedula'

insert into tempTable (nombre, edad, departemento, noCedula)
VALUES (
	'Camila',
	21,
	'Leon',
	'001-010203-0000Z'
);


/*
	Proceso para modificar reglas

	1. desenlazar la reglas de los campos enlazados con ella
		exec sp_unbindrule 'objeto'
	2. elimnar la regla
		drop rule 'nombreRegla'
	3. crear la regla nuevamento modificada
	4. enlzar nuevamente la regla
*/

-- Modificando la regla mayorEdad
-- 1. desenlazando regla
EXEC sys.sp_unbindrule 'tempTable.edad'

-- 2. eliminando regla
DROP RULE dbo.mayorEdad;

-- 3. Crear la regla nuevamente modificada
CREATE RULE dbo.mayorEdad
AS
@rango>=16;

-- 4. Enlazar la regla nuevamente
exec sys.sp_bindrule 'mayorEdad', 'tempTable.edad'

insert into tempTable (nombre, edad, departemento, noCedula)
VALUES (
	'Camila',
	16,
	'Leon',
	'001-010203-0000Z'
);

/*
	Tipos de datos definidos por el usuario

	SQL permite definir tipos de datos personalizado, ya se en base a un tipo
	de datos nativo (int, varchar, float, bit ...) o un tipo de datos Tabla 
	compuesto por columnas, sobre la que se puede realizar consultas.

	Sintaxis

	CREATE TYPE [esquema].[nombreTipo] FROM [tipoDato] (longitud) ...
*/


-- Creando un nuevo tipo de datos para los numeros de telefono obligatorios

CREATE TYPE dbo.noTelefonoReq FROM varchar(8) not null
CREATE TYPE dbo.noTelefono FROM varchar(8) null;

CREATE TYPE dbo.noTelefonoMod FROM varchar(7) null;

ALTER TABLE tempTable add noTelefono noTelefono

ALTER TABLE tempTable ALTER COLUMN noTelefono noTelefonoMod

/* Creando tipos de datos y combinando con reglas */

CREATE TYPE dbo.noCedula FROM varchar(16) not null



EXEC sys.sp_bindrule 'formatoCedula', 'dbo.noCedula'

CREATE TABLE tempTable2 (
	id int primary key identity(1,1),
	Cedula noCedula
)

insert into tempTable2 (Cedula)
VALUES ('001-010203-0405A')