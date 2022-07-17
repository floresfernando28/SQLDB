/*
 -Con esta condición decimos que si la base de datos que nosotros queremos 
  crear con el nombre que deseamos existe, si existe, con el mismo nombre, pues 
  que la elimine con la sentencia (drop database) y que use la base de datos por
  defecto que es la (master)
*/
 
IF DB_ID ('s_supermercado') IS NOT NULL
BEGIN USE MASTER DROP DATABASE s_supermercado END

/*--------------------------------------------------------------------------------*/

CREATE DATABASE s_supermercado
GO

--Usamos la base de datos creada
USE s_supermercado
GO

/*---------------------------------------------------------------------------------
  Procederemos a crear las tablas que contendra la Base de Datos
  
  -----ELEMENTOS-----

  -PRIMARY KEY (llave primaria)
  -IDENTITY (Significa que el id comience en 1 y aumente de 1 en 1
  -NOT NULL (Que es un campo obligatorio)
  -VARCHAR (tipo de datos de caracteres)
  -INT (tipo de dato entero)
  -DATETIME (registro de tiempo y hora)
  -DEFAULT (siginifica que si el usuario no ingresa fecha, que se ponga por defecto otra)
  -GETDATE() (Coloca por defecto la hora y fecha de la maquina
  -DATE (signifiaca registros de fechas)

*/

--TABLA USUARIO
CREATE TABLE usuario(
	Id_Usuario INT PRIMARY KEY IDENTITY(1,1), --Llave primaria
	Nombre_Usuario VARCHAR(60) not null,
	contrasenia VARCHAR(60) not null,
	Fecha_Registro DATETIME DEFAULT GETDATE() not null 
);

---------------------------------------------------------------------------------
--TABLA CARGO
CREATE TABLE Cargo(
    Id_Cargo INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Cargo VARCHAR(50) not null,
);

---------------------------------------------------------------------------------
--TABLA EMPLEADOS
CREATE TABLE Empleados(
    Id_Empleado INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Empleado VARCHAR(50) not null,
	Apellido_Empleado VARCHAR(50) not null,
	Fecha_Contratacion DATETIME not null DEFAULT GETDATE(),
    Edad INT not null,
	Fecha_Nacimiento DATE not null,
	Id_Cargo INT,
	Id_Usuario INT,
    FOREIGN KEY (Id_Cargo) REFERENCES Cargo(Id_Cargo),
	FOREIGN KEY (Id_Usuario) REFERENCES usuario(Id_Usuario)
);

--Por ejemplo si olvidamos o nos equivocamos en tipos de datos de las columnas
--podemos alterarlas fuera de la tabla, ya que si lo hacemos en la misma nos dara 
--error, entonces la forma de hacerlo es la siguiente

--Por ejemplo en la tabla Empleados, en la columna Nombre_Empleado, no la queriamos
--con un varchar 50, si no de 60

ALTER TABLE Empleados
ALTER COLUMN Nombre_Empleado VARCHAR(60) not null

--añadimos la columna sexo que olvide ponerla antes de ejecutar

ALTER TABLE Empleados
ADD sexo CHAR(8) 

--La alteramos la columna ya que el campo debe ser  not null

ALTER TABLE Empleados
ALTER COLUMN sexo CHAR (8) not null


---------------------------------------------------------------------------------
--TABLA PERMISO
CREATE TABLE Permiso(
    Id_Permiso INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Permiso VARCHAR(50) not null,
);

--------------------------------------------------------------------------------

CREATE TABLE Rol(
    Id_Rol INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Rol VARCHAR(50) not null,
);

---------------------------------------------------------------------------------
--TABLAN USUARIO_ROL CON SUS LLAVES FORANEAS

CREATE TABLE Usuario_Rol(
    Id_Usuario INT,
	Id_Rol INT,
	CONSTRAINT Pk_UsuarioRol PRIMARY KEY(Id_Usuario,Id_Rol),
	FOREIGN KEY(Id_Usuario) REFERENCES Usuario(Id_Usuario),
	FOREIGN KEY(Id_Rol) REFERENCES Rol(Id_Rol),
);

---------------------------------------------------------------------------------
--TABLA ROL_PERRMISO CON SUS LLAVES FORANEAS

CREATE TABLE Rol_Permiso(
    Id_Rol INT,
	Id_Permiso INT,
	CONSTRAINT PK_RolPermiso PRIMARY KEY(Id_Rol,Id_Permiso),
	FOREIGN KEY(Id_Rol) REFERENCES Rol(Id_Rol),
	CONSTRAINT FK_Permiso FOREIGN KEY(Id_Permiso) REFERENCES Permiso(Id_Permiso),
);

---------------------------------------------------------------------------------
--TABLA PROVEEDOR

Create table Proveedor(
    Id_Proveedor int primary key identity(1,1),
	Nombre_Proveedor VARCHAR(50) not null,
	Numero_Telefono VARCHAR(8) not null
);


--Alteramos la columna Proveedor para darle mas rango al tipo de dato 

ALTER TABLE Proveedor 
ALTER COLUMN Numero_Telefono VARCHAR (15) not null

---------------------------------------------------------------------------------

--TABLA PRODUCTOS

CREATE TABLE Productos(
   Id_Producto INT PRIMARY KEY IDENTITY(1,1),
   Nombre_Producto VARCHAR(50) not null UNIQUE,
   Precio_Producto DECIMAL(8,2) not null,
   Stock_Cantidad DECIMAL(10,2) not null,    --el (10,2) significa maximo de numeros es 10 y 2 decimales
   Id_Usuario_Realiza INT not null,
   Fecha_De_Registro DATETIME DEFAULT GETDATE() not null,
   Id_Categoria INT,
   CONSTRAINT [El precio del producto debe ser mayor a 0] CHECK (Precio_Producto>0) ,
   CONSTRAINT [El valor del stock debe ser mayor a 0] CHECK(Stock_Cantidad>=0),
   FOREIGN KEY(Id_Usuario_Realiza) REFERENCES Usuario(Id_Usuario)
);

-----------------------------------------------------------------------------------

--TABLA VENTAS

CREATE TABLE Ventas(
   Id_Venta INT PRIMARY KEY IDENTITY(1,1),
   Fecha_Venta DATETIME DEFAULT GETDATE() not null,
   Monto_Total DECIMAL(10,2) not null,
   Id_Usuario_Vendedor INT not null,
   CONSTRAINT ['EL MONTO TOTAL DEBE SER MAYOR A 0'] CHECK(Monto_Total>0),
   FOREIGN KEY (Id_Usuario_Vendedor) REFERENCES Usuario(Id_Usuario)
);

----------------------------------------------------------------------------------

--TABLA DETALLE_VENTA CON SUS LLAVES FORANEAS

CREATE TABLE Detalle_Venta(
	Id_Detalle_Venta INT PRIMARY KEY IDENTITY(1,1),
	Id_Venta INT not null,
	Id_Producto INT not null,
	Cantidad DECIMAL(8,2) not null,
	Precio_Venta DECIMAL(8,2) not null,
	Total_Detalle DECIMAL(8,2) not null,
	FOREIGN KEY(Id_Venta) REFERENCES Ventas(Id_Venta),
	FOREIGN KEY(Id_Producto) REFERENCES Productos(Id_Producto)
);

-----------------------------------------------------------------------------------

--TABLA CATEGORIA

CREATE TABLE Categoria(
  Id_Categoria INT PRIMARY KEY IDENTITY(1,1),
  Nombre_Categoria VARCHAR(50) not null,
);

--Alteramos la tabla Categoria

ALTER TABLE Categoria
ALTER COLUMN Nombre_Categoria NVARCHAR (60) not null

-----------------------------------------------------------------------------------

--TABLA PRODUCTO_CATEGORIA CON SUS LLAVES FORANEAS

CREATE TABLE Producto_Categoria(
  Id_Producto INT,
  Id_Categoria INT,
  CONSTRAINT productoCategoria PRIMARY KEY  (Id_Producto,Id_Categoria),
  FOREIGN KEY(Id_Producto) REFERENCES Productos(Id_Producto),
  CONSTRAINT FK_Categoria FOREIGN KEY(Id_Categoria) REFERENCES Categoria(Id_Categoria),
);

------------------------------------------------------------------------------------

--TABLA PEDIDOS CON SUS LLAVES FORANEAS

CREATE TABLE Pedidos(
    Numero_Pedido INT PRIMARY KEY IDENTITY(1,1),
	Fecha_Pedido DATETIME not null DEFAULT getdate(),
	Id_Proveedor INT not null,
	Usuario_Recibe_Pedido VARCHAR not null,
	Monto_Total_Pedido DECIMAL(10,2) not null,
	FOREIGN KEY (Id_Proveedor) REFERENCES Proveedor(Id_Proveedor),
	CONSTRAINT [El Monto debe ser mayor a 0] CHECK (Monto_Total_Pedido>0),
);

-----------------------------------------------------------------------------------

--TABLA DETALLE_PEDIDO CON SUS LLAVES FORANEAS

CREATE TABLE Detalle_Pedido(
   Id_Detalle_Pedido  INT PRIMARY KEY IDENTITY(1,1),
   Numero_Pedido INT not null,
   Id_Producto INT not null,
   Cantidad_Producto DECIMAL(8,2) not null,
   Precio DECIMAL(8,2) not null,
   Total_Detalle AS (Cantidad_Producto * Precio),
   FOREIGN KEY (Numero_Pedido) REFERENCES Pedidos(Numero_Pedido),
   FOREIGN KEY (Id_Producto) REFERENCES Productos(Id_Producto),
   CONSTRAINT [la cantidad de productos debe ser mayor a 0] CHECK(Cantidad_Producto>0),
   CONSTRAINT [El precio debe ser mayor a 0] CHECK(Precio>0)
);

-----------------------------------------------------------------------------------

--Comenzamos a colocar datos en cada tabla para luego trabajar las consultas

--TABLA USUARIO

insert into usuario (Nombre_Usuario, contrasenia) values ('ffio7678', 'menit6');
insert into usuario (Nombre_Usuario, contrasenia) values ('bbrayan', '234567');
insert into usuario (Nombre_Usuario, contrasenia) values ('mmaria', '45968686');
insert into usuario (Nombre_Usuario, contrasenia) values ('llopez', '9868848');
insert into usuario (Nombre_Usuario, contrasenia) values ('jjose', '12nf345678');
insert into usuario (Nombre_Usuario, contrasenia) values ('fflores67', '78965433');
insert into usuario (Nombre_Usuario, contrasenia) values ('ggloeue', '12567');
insert into usuario (Nombre_Usuario, contrasenia) values ('fflores686', '0899797');
insert into usuario (Nombre_Usuario, contrasenia) values ('fflores28', '75783636');
insert into usuario (Nombre_Usuario, contrasenia) values ('ppdloe', 'kr664');
insert into usuario (Nombre_Usuario, contrasenia) values ('nnfrajs', '94848n4nn4');
insert into usuario (Nombre_Usuario, contrasenia) values ('fflor59', '058585');
insert into usuario (Nombre_Usuario, contrasenia) values ('edgar9', '079797');
insert into usuario (Nombre_Usuario, contrasenia) values ('ggfpuppu', '6868686');
insert into usuario (Nombre_Usuario, contrasenia) values ('lluis3', '09846464');
insert into usuario (Nombre_Usuario, contrasenia) values ('mari5', '0797979');
insert into usuario (Nombre_Usuario, contrasenia) values ('sofi78', '567890');
insert into usuario (Nombre_Usuario, contrasenia) values ('alba78', '4488655');
insert into usuario (Nombre_Usuario, contrasenia) values ('vane464', '84141414');
insert into usuario (Nombre_Usuario, contrasenia) values ('ernesto787', 'p0900808');
insert into usuario (Nombre_Usuario, contrasenia) values ('ferflore8', '9799797');
insert into usuario (Nombre_Usuario, contrasenia) values ('floreu', '97997');
insert into usuario (Nombre_Usuario, contrasenia) values ('carlo3', '7899');
insert into usuario (Nombre_Usuario, contrasenia) values ('adrea9', '08080');
insert into usuario (Nombre_Usuario, contrasenia) values ('yoel67', '1230707');
insert into usuario (Nombre_Usuario, contrasenia) values ('henry6', '0909090');
insert into usuario (Nombre_Usuario, contrasenia) values ('elida565', 'fot769696');
insert into usuario (Nombre_Usuario, contrasenia) values ('alberto5', '57575');
insert into usuario (Nombre_Usuario, contrasenia) values ('vvictor', '86868');
insert into usuario (Nombre_Usuario, contrasenia) values ('franc', '555555');
insert into usuario (Nombre_Usuario, contrasenia) values ('jjoses', '44444444');
insert into usuario (Nombre_Usuario, contrasenia) values ('josdefina6', '66667778');
insert into usuario (Nombre_Usuario, contrasenia) values ('guadalup4', '88886677');
insert into usuario (Nombre_Usuario, contrasenia) values ('salimas8', '0855599797');
insert into usuario (Nombre_Usuario, contrasenia) values ('julio686', '88888888');
insert into usuario (Nombre_Usuario, contrasenia) values ('panchukskd', '696996');
insert into usuario (Nombre_Usuario, contrasenia) values ('nimgayddy', 't6565665');
insert into usuario (Nombre_Usuario, contrasenia) values ('676767', '058585');
insert into usuario (Nombre_Usuario, contrasenia) values ('bayrinyi5', '9997');
insert into usuario (Nombre_Usuario, contrasenia) values ('chibold', '6868686');
insert into usuario (Nombre_Usuario, contrasenia) values ('chili', '45464646');
insert into usuario (Nombre_Usuario, contrasenia) values ('rosmeyy5', '09846464');
insert into usuario (Nombre_Usuario, contrasenia) values ('marito87', '0797979');
insert into usuario (Nombre_Usuario, contrasenia) values ('keny', '88889');
insert into usuario (Nombre_Usuario, contrasenia) values ('henry7', '4488655');
insert into usuario (Nombre_Usuario, contrasenia) values ('isaav5858', '686886868');
insert into usuario (Nombre_Usuario, contrasenia) values ('nelson6', '99797');
insert into usuario (Nombre_Usuario, contrasenia) values ('ferflore8', '777oooo');
insert into usuario (Nombre_Usuario, contrasenia) values ('floru', '979977');
insert into usuario (Nombre_Usuario, contrasenia) values ('carlitos7', '789966');

---------------------------------------------------------------------------------------------

--DATOS DEL LA TABLA CARGO

insert into cargo (Nombre_Cargo) values ('Guarda de Seguridad');

----------------------------------------------------------------------------------------------
--DATOS DE LA TABLA EMPLEADOS

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Pedro Pablo', 'Mendoza', 19, '19830302', null ,1, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Brayan Ernesto', 'espinoza paz', 13, '20080707', 1 ,2, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Brandon Jose', 'Lopez Ruiz', 18, '20030504',1,3, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Gloria Del socorro', 'vanegas ruiz', 19, '20020305', null ,4, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Luisa Josefa', 'Sanchez matlack', 20, '20010305', null ,5, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Henry Alber', 'Gutierrez lezama', 20, '20010505', null ,6, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Fernando Jose', 'Flores Mendoza', 19, '20020306', null ,7, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Isaac Jose', 'requene lopez', 19, '20020308', null ,8, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Victor Manuel', 'Leiva Requene', 18, '20030309', null ,9, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Guadalupe rosa', 'salinas Mendoza', 19, '20020304', null ,10, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Pedro pablo', 'garcia Mendoza', 21, '20000101', null ,11, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('allison andrea', 'Espinoza fuentes', 19, '20020301', null ,12, 'F')

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Fernanda Allis', 'Ruiz poveda', 17, '20030302', null ,13, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Maritza Luisa', 'Mendoza Mendoza', 40, '19800405', null ,14, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Bryan Alberto', 'Romero Vindell', 19, '20020307', null ,15, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Brandon Alberto', 'Romero Vindell', 17, '20030307', null ,16, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Joel Jose', 'Ruiz Mendoza', 20, '20010307', null ,17, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Maria Jose', 'fuentes garcia', 17, '20040308', null ,18, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Fernando Luis', 'Fuentes Garcia', 18, '20030308', null ,19, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('kener Jose', 'lopez perez', 18, '20030309', null ,20, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Antonio de jesus ', 'garcia lopez ', 25, '19960304', null ,21, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Luis Rodrigo', 'Santos Lezama', 25, '19960101', null ,22, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Harintong Andrew', 'Vazquez Diaz', 27, '19940301', null ,23, 'M')

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Axell francisco', 'Bonilla poveda', 28, '19930302', null ,24, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Jharlyne Luisa', 'carvajal perez', 29, '19920405', null ,25, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('francisco jose', 'leyton perez', 29, '19920307', null ,26, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Jordan Marvin', 'Lopez perez', 30, '19910307', null ,27, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('anielka judith', 'Ruiz ruiz', 20, '20010307', null ,28, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Mario santos', 'bonilla garcia', 17, '20040308', null ,29, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Vladimir jose', 'ortega fonseca', 18, '20030308', null ,30, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('German Jose', 'Siu perez', 18, '20030309', null ,31, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('isais antonio', 'guerrero siu', 31, '19900304', null ,32, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Esmeralda pimentel ', 'trejos trejos', 31, '19900101', null ,33, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Andrea luisa', 'vasquez fuentes', 23, '19890301', null ,34, 'F')

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Heydi andrea ', 'fitoria niño ', 25, '19960302', null ,35, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Delvin antonio ', 'castillo peralta', 40, '19800405', null ,36, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Marcel Antonio ', 'castillo Vindell', 19, '20020307', null ,37, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Brayan luis', 'lezama castillo', 26, '19950307', null ,38, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Gabriela Guadalupe ', 'flores padilla ', 20, '20010307', null ,39, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Kelly Maria', 'Rojas padilla', 25, '19960308', null ,40, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Carolina gabriela ', 'ruiz Garcia', 20, '20010308', null ,41, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Kenneth Jose', 'castillo perez', 25, '19960309', null ,42, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Vicente Jose', 'siu Hernandez', 19, '20020304', null ,43, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Pedro Jasson', 'herrera perez', 21, '20000122', null ,44, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Faty Francisco', 'trejos herrera', 19, '20020311', null ,45, 'M')

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Lesbia Liseeth', 'Valeria lacayo ', 30, '19910319', null ,46, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Andres German', 'santamarina valle', 40, '19801205', null ,47, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Jeferson Antonio', 'Obando Fonseca', 19, '20021107', null ,48, 'M');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Fernanda Maria', 'Lezama Herrera', 30, '19910307', null ,49, 'F');

insert into Empleados (Nombre_Empleado, Apellido_Empleado, Edad, Fecha_Nacimiento, Id_Cargo, Id_Usuario, sexo)
values ('Joel vladimir', 'flores vaca', 20, '20010607', null ,50, 'M');

----------------------------------------------------------------------------------------
-------------------------------------------------------------------------

----EJEMPLOS DE LA TABLA ROL

insert into Rol(Nombre_Rol) values ('Administrador');
insert into Rol(Nombre_Rol) values ('Cajero');
insert into Rol(Nombre_Rol) values ('Responsanble de Bodega');

-------------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA PERMISO

insert into Permiso(Nombre_Permiso) values ('Crea y Edita Usuario');
insert into Permiso(Nombre_Permiso) values ('Realiza ventas');
insert into Permiso(Nombre_Permiso) values ('Crea nuevos productos');

--------------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA ROL_PERMISO

insert into Rol_Permiso(Id_Rol,Id_Permiso) VALUES (1,1);
insert into Rol_Permiso(Id_Rol,Id_Permiso) VALUES (2,3);
insert into Rol_Permiso(Id_Rol,Id_Permiso) VALUES (2,1);
insert into Rol_Permiso(Id_Rol,Id_Permiso) VALUES (3,1);
insert into Rol_Permiso(Id_Rol,Id_Permiso) VALUES (3,3);


--------------------------------------------------------------------------------
--EJEMPLOS DE LA TABLA USUARIO_ROL

insert into Usuario_Rol(Id_Usuario,Id_Rol) values (1,1);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (2,2);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (3,3);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (4,1);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (6,1);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (15,2);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (17,3);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (10,1);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (14,2);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (18,2);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (19,1);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (20,2);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (21,1);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (22,1);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (31,2);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (32,2);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (33,2);
insert into Usuario_Rol(Id_Usuario,Id_Rol) values (34,2);
---------------------------------------------------------------------------------

--EJEMPLOS DE LA TABLA CATEGORIA DE LOS PRODUCTOS AGRUPADOS

insert into categoria (Nombre_categoria) values ('Granos Basicos');
insert into categoria (Nombre_categoria) values ('Productos de limpieza');
insert into categoria (Nombre_categoria) values ('Gaseosas');
insert into categoria (Nombre_categoria) values ('Cereales');
insert into categoria (Nombre_categoria) values ('Verduras y Frutas');
insert into categoria (Nombre_categoria) values ('Lacteos');
insert into categoria (Nombre_categoria) values ('Carnes');
insert into categoria (Nombre_categoria) values ('Embutidos');
insert into categoria (Nombre_categoria) values ('Galletas');
insert into categoria (Nombre_categoria) values ('Helados');
---------------------------------------------------------------------------------

--EJEMPLOS DE LA TABLA PRODUCTOS

insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('pepsi 2lt', 32, 10, 1, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('pepsi light', 42, 15, 2, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('coca cola 2lt', 32, 10, 1, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('coca cola zero', 40, 20, 4, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('sprite 1litro', 20, 15, 4, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('fanta 2lit', 32, 14, 6, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('fanta zero 1 litro', 33, 10, 4, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Kola shaler 2litro', 46, 20, 1, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('big cola 2litro', 32, 10, 1, 3);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('big cola roja 2litros', 33, 10, 4, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('big cola verde 2litros', 34, 10, 1, 3); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('ajonjoli lb', 17, 10, 5, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('aguacate', 25, 17, 5, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('limon docena', 15, 10, 8, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('manzana unidad', 36, 40, 7, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('melocoton unidad', 38, 14, 5, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('melon unidad', 20, 56, 7, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('naranja docena', 30, 10, 5, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('alverja china', 35, 11, 6, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('brocoli lb', 24, 36, 7, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('chile pimiento lb', 22, 34, 8, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('papa lb', 45, 44, 8, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('repollo', 15, 18, 8, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('tomate lb', 50, 10, 5, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('zanahoria lb', 10, 40, 5, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('remolacha lb', 20, 55, 6, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('quequisque lb', 18, 100, 5, 5);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Yuca lb', 20, 10, 6, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('pipian lb', 20, 10, 5, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('ayote', 23, 10, 5, 5); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Leche en polvo', 79, 89, 9, 6); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('yogur', 22, 10, 9, 6); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('queso lb', 37, 10, 5, 6);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('queso para freir lb', 34, 55, 5, 6); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('mantequilla barra', 39, 20, 9, 6); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('dulce de leche', 38, 10, 5, 6); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('cuajada seca', 41, 50, 9, 6);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Arroz Faisan lb', 18, 50, 9, 1);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Azucar lb', 17, 78, 5, 1); 
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Arroz doña maria lb', 15, 50, 9, 1);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('frijol rojo lb', 22, 50, 9, 1);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('frijol negro lb', 14, 50, 9, 1);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('aceite vegetal lt', 46, 50, 9, 1);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('sorgo lb', 17, 57, 9, 1);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('esponjas y paños', 47, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Detergente espumil', 35, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Ace xedex', 44, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('cepillo para baño', 69, 57, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Jabon maravilla', 45, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('jabon protex', 25, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('jabon 10/12', 46, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Guantes', 16, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Pasta dental colgate', 48, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('total 12 pasta dental', 88, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Palmolive lt', 77, 66, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('head shoulder lt', 103, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('crema cabello head shoulder', 66, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('sedal lt', 41, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('cloro', 18, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('jabon gel', 11, 55, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('jabon antibacterial', 17, 7, 10, 2);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('cork flakes', 57, 60, 11, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('chips ahoy', 60, 60, 11, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('vamos animo!', 55, 55, 10, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('crunch', 45, 60, 10, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('todos juntos', 44, 55, 11, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('frosted flakes', 70, 68, 11, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('cheerios', 79, 67, 11, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('apple jacks', 46, 60, 10, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('nesquik', 50, 40, 10, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('fitnnes', 74, 67, 10, 4);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Carne Molida especial lb', 74, 67, 40, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('costilla alta lb', 90, 67, 40, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('trasera de secina lb', 70, 67, 50, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('trocitos de carne lb', 74, 67, 50, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('pechuga con ala lb', 50, 67, 40, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('pechuga especial lb', 79, 67, 30, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('pollo rey entero ', 80, 67, 44, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('jamon de pollo', 45, 67, 10, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Menudo Pollo lb', 28, 64, 10, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Higado Pollo', 44, 67, 10, 7);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Recorte de Pollo lb', 47, 67, 10, 7);

insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Longaniza', 47, 65, 10, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('jamon iberico', 47, 44, 14, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('fiambre', 47, 77, 14, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('mortadela', 47, 63, 19, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('jamon', 47, 78, 13, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('salami', 47, 33, 10, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Jamon cerrano', 99, 59, 33, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('lomo embuchado', 99, 99, 22, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('butifarra', 32, 7, 22, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('salchicha', 47, 65, 33, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Filetes', 99, 65, 2, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Longaniza Especial', 90, 65, 23, 8);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Orbita', 85, 44, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Krispik', 55, 44, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Apetitas', 66, 55, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Galletas Maria', 44, 55, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Galletas de leche', 23, 44, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Girasoles', 40, 44, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Oreo', 45, 66, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Troyanas', 20, 44, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Chokis', 55, 44, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Ritz Con queso', 67, 44, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Ritz sin queso', 57, 44, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Club social', 44, 67, 43, 9);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Helado de Vainilla', 103, 80, 30, 10);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Helado de coco', 140, 80, 30, 10);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Helado de Chocolate', 103, 80, 30, 10);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Helado de fresa', 200, 80, 31, 10);
insert into productos ( Nombre_producto, Precio_producto, stock_cantidad, id_usuario_realiza,id_categoria)
values ('Helado de Mint', 110, 50, 30, 10);

------------------------------------------------------------------------------------

--DATOS EN LA TABLA PROVEEDOR

insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Procesadora de Arroz S.A',28255567);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Parmalat S.A',24545678);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Productos Ramos',23434523);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Compañia de Limpieza S.A',21226787);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Alimentos del valle S.A',27896654);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('industrias S.A',21225587);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Coca Cola S.A',24626787);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Granos Basícos S.A',24626787);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('carnes san Martin S.A',26626787);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Matadero Centarl S.A',24626766);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Campos UX S.A',24646787);
insert into proveedor(Nombre_Proveedor, numero_telefono)
values ('Cam. Heladeria',24645587);

------------------------------------------------------------------------------------

--EJEMPLOS DE LA TABLA VENTAS

insert into ventas(Monto_total, id_usuario_vendedor)
values (450,2);
insert into ventas(Monto_total, id_usuario_vendedor)
values (675,17);
insert into ventas(Monto_total, id_usuario_vendedor)
values (450,2);
insert into ventas(Monto_total, id_usuario_vendedor)
values (795,17);
insert into ventas(Monto_total, id_usuario_vendedor)
values (1245,2);

----------------------------------------------------------------------------------
--EJEMPLOS DE LA TABLA PEDIDOS

insert into pedidos(id_proveedor, usuario_recibe_pedido, monto_total_pedido)
values( 1, 3, 450);

insert into pedidos(id_proveedor, usuario_recibe_pedido, monto_total_pedido)
values( 2, 4, 675);

insert into pedidos(id_proveedor, usuario_recibe_pedido, monto_total_pedido)
values( 4, 6, 450);

-----------------------------------------------------------------------------
--EJEMPLOS DE LA TABLA DETALLE_PEDIDOS

insert into detalle_venta(id_venta, id_producto, cantidad, precio_venta, total_detalle)
values (1,1,5,32, 5);

insert into detalle_pedido( numero_pedido, id_producto, cantidad_producto,
			precio)
			values( 2, 2, 745, 42)

insert into detalle_pedido( numero_pedido, id_producto, cantidad_producto,
			precio)
			values( 2, 3, 5, 32)
insert into detalle_pedido( numero_pedido, id_producto, cantidad_producto,
			precio)
			values( 3, 8, 56, 46)

----------------------------------------------------------------------------

--EJEMPLOS DE LA TABLA DETALLE_VENTA

insert into detalle_venta(id_venta, id_producto, cantidad, precio_venta, total_detalle)
values(1, 1, 5, 450, 495);
insert into detalle_venta(id_venta, id_producto, cantidad, precio_venta, total_detalle)
values(1, 1, 7, 555, 7557);
insert into detalle_venta(id_venta, id_producto, cantidad, precio_venta, total_detalle)
values(1, 1, 5, 57, 495);
insert into detalle_venta(id_venta, id_producto, cantidad, precio_venta, total_detalle)
values(1, 1, 5, 8979, 706848);


------------------------------------------------------------------------------------

--EJEMPLOS EN LA TABLA PRODUCTO_CATEGORIA

insert into producto_categoria(id_producto, id_categoria) values (1,3);
insert into producto_categoria(id_producto, id_categoria) values (2,3);
insert into producto_categoria(id_producto, id_categoria) values (3,3);
insert into producto_categoria(id_producto, id_categoria) values (4,3);
insert into producto_categoria(id_producto, id_categoria) values (5,3);
insert into producto_categoria(id_producto, id_categoria) values (6,3);
insert into producto_categoria(id_producto, id_categoria) values (7,3);
insert into producto_categoria(id_producto, id_categoria) values (8,3);
insert into producto_categoria(id_producto, id_categoria) values (9,3);
insert into producto_categoria(id_producto, id_categoria) values (10,3);
insert into producto_categoria(id_producto, id_categoria) values (11,3);
insert into producto_categoria(id_producto, id_categoria) values (12,5);
insert into producto_categoria(id_producto, id_categoria) values (13,5);
insert into producto_categoria(id_producto, id_categoria) values (14,5);
insert into producto_categoria(id_producto, id_categoria) values (15,5);
insert into producto_categoria(id_producto, id_categoria) values (16,5);
insert into producto_categoria(id_producto, id_categoria) values (17,5);
insert into producto_categoria(id_producto, id_categoria) values (18,5);
insert into producto_categoria(id_producto, id_categoria) values (19,5);
insert into producto_categoria(id_producto, id_categoria) values (20,5);
insert into producto_categoria(id_producto, id_categoria) values (21,5);
insert into producto_categoria(id_producto, id_categoria) values (22,5);
insert into producto_categoria(id_producto, id_categoria) values (23,5);
insert into producto_categoria(id_producto, id_categoria) values (24,5);
insert into producto_categoria(id_producto, id_categoria) values (25,5);
insert into producto_categoria(id_producto, id_categoria) values (26,5);
insert into producto_categoria(id_producto, id_categoria) values (27,5);
insert into producto_categoria(id_producto, id_categoria) values (28,5);
insert into producto_categoria(id_producto, id_categoria) values (29,5);
insert into producto_categoria(id_producto, id_categoria) values (30,5);
insert into producto_categoria(id_producto, id_categoria) values (31,6);
insert into producto_categoria(id_producto, id_categoria) values (32,6);
insert into producto_categoria(id_producto, id_categoria) values (33,6);
insert into producto_categoria(id_producto, id_categoria) values (34,6);
insert into producto_categoria(id_producto, id_categoria) values (35,6);
insert into producto_categoria(id_producto, id_categoria) values (36,6);
insert into producto_categoria(id_producto, id_categoria) values (37,6);
insert into producto_categoria(id_producto, id_categoria) values (38,1);
insert into producto_categoria(id_producto, id_categoria) values (39,1);
insert into producto_categoria(id_producto, id_categoria) values (40,1);
insert into producto_categoria(id_producto, id_categoria) values (41,1);
insert into producto_categoria(id_producto, id_categoria) values (42,1);
insert into producto_categoria(id_producto, id_categoria) values (43,1);
insert into producto_categoria(id_producto, id_categoria) values (44,2);
insert into producto_categoria(id_producto, id_categoria) values (45,2);
insert into producto_categoria(id_producto, id_categoria) values (46,2);
insert into producto_categoria(id_producto, id_categoria) values (47,2);
insert into producto_categoria(id_producto, id_categoria) values (48,2);
insert into producto_categoria(id_producto, id_categoria) values (49,2);
insert into producto_categoria(id_producto, id_categoria) values (50,2);
insert into producto_categoria(id_producto, id_categoria) values (51,2);
insert into producto_categoria(id_producto, id_categoria) values (52,2);
insert into producto_categoria(id_producto, id_categoria) values (53,2);
insert into producto_categoria(id_producto, id_categoria) values (54,2);
insert into producto_categoria(id_producto, id_categoria) values (55,2);
insert into producto_categoria(id_producto, id_categoria) values (56,2);
insert into producto_categoria(id_producto, id_categoria) values (57,2);
insert into producto_categoria(id_producto, id_categoria) values (58,2);
insert into producto_categoria(id_producto, id_categoria) values (59,2);
insert into producto_categoria(id_producto, id_categoria) values (60,2);
insert into producto_categoria(id_producto, id_categoria) values (61,4);
insert into producto_categoria(id_producto, id_categoria) values (62,4);
insert into producto_categoria(id_producto, id_categoria) values (63,4);
insert into producto_categoria(id_producto, id_categoria) values (64,4);
insert into producto_categoria(id_producto, id_categoria) values (65,4);
insert into producto_categoria(id_producto, id_categoria) values (66,4);
insert into producto_categoria(id_producto, id_categoria) values (67,4);
insert into producto_categoria(id_producto, id_categoria) values (68,4);
insert into producto_categoria(id_producto, id_categoria) values (69,4);
insert into producto_categoria(id_producto, id_categoria) values (70,4);
insert into producto_categoria(id_producto, id_categoria) values (71,1);
insert into producto_categoria(id_producto, id_categoria) values (72,7);
insert into producto_categoria(id_producto, id_categoria) values (73,7);
insert into producto_categoria(id_producto, id_categoria) values (74,7);
insert into producto_categoria(id_producto, id_categoria) values (75,7);
insert into producto_categoria(id_producto, id_categoria) values (76,7);
insert into producto_categoria(id_producto, id_categoria) values (77,7);
insert into producto_categoria(id_producto, id_categoria) values (78,7);
insert into producto_categoria(id_producto, id_categoria) values (79,7);
insert into producto_categoria(id_producto, id_categoria) values (80,7);
insert into producto_categoria(id_producto, id_categoria) values (81,7);
insert into producto_categoria(id_producto, id_categoria) values (82,7);
insert into producto_categoria(id_producto, id_categoria) values (83,8);
insert into producto_categoria(id_producto, id_categoria) values (84,8);
insert into producto_categoria(id_producto, id_categoria) values (85,8);
insert into producto_categoria(id_producto, id_categoria) values (86,8);
insert into producto_categoria(id_producto, id_categoria) values (87,8);
insert into producto_categoria(id_producto, id_categoria) values (88,8);
insert into producto_categoria(id_producto, id_categoria) values (89,8);
insert into producto_categoria(id_producto, id_categoria) values (90,8);
insert into producto_categoria(id_producto, id_categoria) values (91,8);
insert into producto_categoria(id_producto, id_categoria) values (92,8);
insert into producto_categoria(id_producto, id_categoria) values (93,8);
insert into producto_categoria(id_producto, id_categoria) values (94,8);
insert into producto_categoria(id_producto, id_categoria) values (95,9);
insert into producto_categoria(id_producto, id_categoria) values (96,9);
insert into producto_categoria(id_producto, id_categoria) values (97,9);
insert into producto_categoria(id_producto, id_categoria) values (98,9);
insert into producto_categoria(id_producto, id_categoria) values (99,9);
insert into producto_categoria(id_producto, id_categoria) values (100,9);
insert into producto_categoria(id_producto, id_categoria) values (101,9);
insert into producto_categoria(id_producto, id_categoria) values (102,9);
insert into producto_categoria(id_producto, id_categoria) values (103,9);
insert into producto_categoria(id_producto, id_categoria) values (104,9);
insert into producto_categoria(id_producto, id_categoria) values (105,9);
insert into producto_categoria(id_producto, id_categoria) values (106,9);
insert into producto_categoria(id_producto, id_categoria) values (107,10);
insert into producto_categoria(id_producto, id_categoria) values (108,10);
insert into producto_categoria(id_producto, id_categoria) values (109,10);
insert into producto_categoria(id_producto, id_categoria) values (110,10);
insert into producto_categoria(id_producto, id_categoria) values (111,10);

--------------------------------FIN DE PROYECTO----------------------------------


--Consultas para ver las tablas

SELECT * FROM usuario
SELECT * FROM Empleados
SELECT * FROM Cargo
--ROLES Y PERMISOS
SELECT * FROM Rol
SELECT * FROM Permiso
SELECT * FROM Rol_Permiso
SELECT * FROM Usuario_Rol
--PRODUCTOS
SELECT * FROM Productos
SELECT * FROM Categoria
SELECT * FROM Producto_Categoria
SELECT * FROM Proveedor
SELECT * FROM Ventas
SELECT * FROM Detalle_Pedido
SELECT * FROM Detalle_Venta