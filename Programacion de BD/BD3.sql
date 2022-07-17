/*
   REGLAS (rules)

  Las reglas es una caracteristica que definen los valores aceptables de la columna o tipo de dato al se enlazan
  
  ***Esta caracteristiac sera removidas en versiones futuras

  SINTAXIS 
  CREATE RULE [ESQUEMA].[NombreRegla]
  As Condicion(es)
 
 */

 use TSQL2012;

CREATE TABLE temporal(
     id int primary key identity(1,1),
	 nombre varchar(25) not null,
	 edad int not null
);

insert into temporal(nombre,edad) values ('juam',15)

select * from temporal;
go

---se crea una regla para registra en la tabla temporal, la cual es que la persona debe ser mayor de edad

CREATE RULE dbo.mayorEdad
AS
@rango>=18;


