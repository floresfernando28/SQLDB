create database Mercado
go

use Mercado 

create table categoria(
	Id_categoria int primary key identity (1,1),
	nombre_categoria varchar (60) not null
);


create table producto(
	Id_producto int primary key identity (1,1),
	nombre_producto varchar (60) not null,
	precio decimal (8,2) not null,
	Constraint [El precio debe ser mayor 0] check (precio>0),
	stock_cantidadp int not null,
	fecha_Registro datetime default getdate() not null,
	Id_categoria int not null,
	foreign key (Id_categoria) references categoria (Id_categoria)
);

alter table producto alter column nombre_producto varchar(60) not null

create table cargo(
	Id_cargo int primary key identity (1,1),
	nombre_cargo varchar (60) not null,
);
create table sexo (
	Id_sexo int primary key,
	nombre_sexo varchar (60) not null
);
create table empleados(
	Id_empleados int primary key identity (1,1),
	nombre_empleados varchar (60) not null,
	edad_empleados int not null,
	apellido_empleados varchar (60) not null,
	telefono int not null,
	Id_cargo int not null,
	Id_sexo int not null,
	foreign key (Id_sexo) references sexo(Id_sexo),
	foreign key (Id_cargo) references cargo(Id_cargo)
);

create table usuario (
	Id_usuario int primary key identity (1,1),
	nombre_usuario varchar (60) unique not null,
	contrasenia int not null,
	fecha_Registro datetime default getdate() not null,
	Id_empleados int not null,
	foreign key (Id_empleados) references empleados (Id_empleados)
);

--Insertando datos en la tabla cargo

insert into cargo ( nombre_cargo ) values ('Guarda_seguridad')

insert into cargo ( nombre_cargo ) values ('Impector')

insert into cargo ( nombre_cargo ) values ('Vendedor')

insert into cargo ( nombre_cargo ) values ('Cajero')

--Insertando datos en la tabla categoria

insert into categoria ( nombre_categoria ) values ('Granos Basicos')

insert into categoria ( nombre_categoria ) values ('lacteos')

insert into categoria ( nombre_categoria ) values ('Postre')

insert into categoria ( nombre_categoria ) values ('Porducto de limpieza')

insert into categoria ( nombre_categoria ) values ('Gaeseosa')

--insertando datos en la tabla producto 

insert into producto ( nombre_producto, precio, stock_cantidadp, id_categoria)
values  ('Gaseosa', 12.00, 30, 5)
insert into producto ( nombre_producto, precio, stock_cantidadp, id_categoria)
values ('leche', 12.21 , 24, 2)
insert into producto ( nombre_producto, precio, stock_cantidadp, id_categoria)
values ('pan', 24.45, 45, 3)
insert into producto ( nombre_producto, precio, stock_cantidadp, id_categoria)
values ('galletas', 13.12, 14, 1)

--insertando datos en tabla sexo

insert into sexo (Id_sexo, nombre_sexo) values ( 1, 'masculino')
insert into sexo (Id_sexo, nombre_sexo) values ( 2, 'femenino')

--insertando datos en la tabla empleado

insert into empleados ( nombre_empleados, edad_empleados, apellido_empleados , telefono, Id_cargo, Id_sexo)
values (' victor', 19, 'leiva', 57353410, 1 , 1)   
insert into empleados ( nombre_empleados, edad_empleados, apellido_empleados , telefono, Id_cargo, Id_sexo)
values ('joel', 20, 'narvaez', 8668686, 1, 1)
insert into empleados ( nombre_empleados, edad_empleados, apellido_empleados , telefono, Id_cargo, Id_sexo)
values ('Paola', 28, 'Gonzales', 958383, 2 , 2)
insert into empleados ( nombre_empleados, edad_empleados, apellido_empleados , telefono, Id_cargo, Id_sexo)
values ('ana', 38, 'peralta', 84829382, 2,2)

--insertando datos en la tabla usuario

insert into usuario ( nombre_usuario, contrasenia, Id_empleados)
values ('jnarvaez', 28172, 5)
insert into usuario ( nombre_usuario, contrasenia, Id_empleados)
values ('vleiva', 37281, 3)
insert into usuario ( nombre_usuario, contrasenia, Id_empleados)
values ('pgonzales', 738273, 4)
insert into usuario ( nombre_usuario, contrasenia, Id_empleados)
values ('Aperalhe', 67343, 6)






