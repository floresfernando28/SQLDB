drop database mercado
go 
use mercado;

create table destinopais(
	Id_Pais int primary key identity (1,1),
	nombre_pais varchar (60) not null
);

create table pasajero(

	Id_pasajero int primary key identity (1,1),
	nombre varchar (60) not null,
	apellido varchar (60) not null,
	edad int not null,
	Constraint [la edad debe ser mayor a 0] check (edad>0),
	movil int not null,
	fecha_Registro datetime default getdate() not null ,
	Id_pais int not null,
	foreign key (Id_pais) references destinopais(Id_pais)
);


insert into destinopais  ( nombre_pais) values ('Nicaragua');

insert into destinopais  ( nombre_pais) values ('Peru');

insert into destinopais  ( nombre_pais) values ('Honduras');

insert into destinopais  ( nombre_pais) values ('Portugal');

insert into destinopais  ( nombre_pais) values ('Francia');

insert into destinopais  ( nombre_pais) values ('España');

insert into destinopais  ( nombre_pais) values ('Estados Unidos');

insert into destinopais  ( nombre_pais) values ('Inglaterra');

--Insertando datos en la tabla pasajero

insert into pasajero (nombre , apellido, edad , movil, Id_pais )
values ('José', 'flores', 19 , 5768594,2);

insert into pasajero (nombre , apellido, edad , movil,Id_pais)
values ('Joel', 'Narvaez', 21 , 573883, 4);

insert into pasajero (nombre , apellido, edad , movil,Id_pais )
values ('Ronny', 'Sequeira', 19 , 5768594,1);

insert into pasajero (nombre , apellido, edad , movil,Id_pais )
values ('elias', 'jarquin', 4, 5768594,1);


-- seleccionando los datos de la tabla destinopais

select * from destinopais 

-- seleccionando los datos de la tabla pasajeros

select * from pasajero

-- Eliminar un solo dato de la tabla destino pais 

delete destinopais where Id_Pais = 5

-- modificando un dato de la base de datos

update destinopais set nombre_pais = 'finlandia' where Id_Pais = 6

--consultas

select nombre_pais from destinopais where Id_Pais = 4