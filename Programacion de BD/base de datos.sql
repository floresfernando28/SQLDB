CREATE DATABASE Sistema_De_Mercado_Ingeneri;
go

USE Sistema_De_Mercado_Ingeneri;
go
-------------------------------------------------------------------------------------------------
/*                UNIVERSIDAD POLITECNICA DE NICARAGUA
                     "SIRVIENDO ALA COMUNIDAD"

       INTEGRANTES
	  1. Fernando Jose Flores Mendoza
	  2. Elida Marcela Vallecillo Carballo
	  3. Benjamin

	  Maestro: ING. Pedro Pablo Mendoza Garcia

      Curso: Diseño de Base de Datos

	  Carrera: Ingeneria en sistemas de informacion

*/

-------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA USUARIO 

CREATE TABLE Usuario(
    CodigoUsuario int primary key identity(1,1),
	NombreUsuario varchar(50),
	Contrasenia varchar(50),
	fechaCrea datetime not null default getdate(),
);
----------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA ROL

CREATE TABLE Rol(
    CodigoRol int primary key identity(1,1),
	NombreRol varchar(50) not null,
);

---------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA PERMISO

CREATE TABLE Permiso(
    CodigoPermiso int primary key identity(1,1),
	NombrePermiso varchar(50) not null,
);

---------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA USUARIO_ROL

CREATE TABLE UsuarioRol(
    CodigoUsuario int,
	CodigoRol int,
	CONSTRAINT Pk_UsuarioRol primary key(CodigoUsuario,CodigoRol),
	FOREIGN KEY(CodigoUsuario) REFERENCES Usuario(CodigoUsuario),
	FOREIGN KEY(CodigoRol) REFERENCES Rol(CodigoRol),
);

-----------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA ROL_PERMISO

CREATE TABLE RolPermiso(
    CodigoRol int,
	CodigoPermiso int,
	CONSTRAINT PK_RolPermiso PRIMARY KEY(CodigoRol,CodigoPermiso),
	FOREIGN KEY(CodigoRol) REFERENCES Rol(CodigoRol),
	CONSTRAINT FK_Permiso FOREIGN KEY(CodigoPermiso) REFERENCES Permiso(CodigoPermiso),
);

-----------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA CARGO

CREATE TABLE Cargo(
    CodigoCargo int primary key identity(1,1),
	NombreCargo varchar(50) not null,
);

------------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA EMPLEADO

CREATE TABLE Empleado(
    CodigoEmpleado int primary key identity(1,1),
	NombreEmpleado varchar(50) not null,
	ApellidoEmpleado varchar(50) not null,
	FechaContratacion datetime not null default getdate(),
	CodigoCargo int,
    FOREIGN KEY (CodigoCargo) REFERENCES Cargo(CodigoCargo)
);

-------------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA PROVEEDOR

CREATE TABLE Proveedor(
    IdProveedor int primary key identity(1,1),
	NombreProveedor varchar(50) not null,
	NumeroTelefono varchar(8) not null
);

------------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA PRODUCTO

CREATE TABLE Producto(
   CodigoProducto int primary key identity(1,1),
   NombreProducto varchar(50) not null UNIQUE,
   PrecioProducto decimal(8,2) not null,
   Stock decimal(8,2) not null,
   IdUsuarioRealiza int not null,
   FechaDeRegistro datetime default getdate() not null,
   CodigoCategoria int,
   CHECK (PrecioProducto>0),
   CONSTRAINT ['EL VALOR DEL STOCK NO DEBE SER NEGATIVO'] CHECK(Stock>=0),
   FOREIGN KEY(IdUsuarioRealiza) REFERENCES Usuario(CodigoUsuario)

);

----------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA VENTAS

CREATE TABLE Ventas(
   IdVenta int primary key identity(1,1),
   FechaVenta datetime default getdate() not null,
   MontoTotal decimal(10,2) not null,
   IdUsuarioVendedor int not null,
   CONSTRAINT ['EL MONTO TOTAL DEBE SER MAYOR A 0'] CHECK(MontoTotal>0),
   FOREIGN KEY (IdUsuarioVendedor) REFERENCES Usuario(CodigoUsuario)
);

----------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA DETALLE_VENTA

CREATE TABLE DetalleVenta(
	IdDetalleVenta int primary key identity(1,1),
	IdVenta int not null,
	CodigoProducto int not null,
	Cantidad decimal(8,2) not null,
	PrecioVenta decimal(8,2) not null,
	TotalDetalle decimal(8,2) not null,
	FOREIGN KEY(IdVenta) REFERENCES Ventas(IdVenta),
	FOREIGN KEY(CodigoProducto) REFERENCES Producto(CodigoProducto)
);

-----------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA CATEGORIA

CREATE TABLE Categoria(
  CodigoCategoria int primary key identity(1,1),
  NombreCategoria varchar(50) not null,
);

----------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA PRODUCTO_CATEGORIA

CREATE TABLE ProductoCategoria(
  CodigoProducto int,
  CodigoCategoria int,
  CONSTRAINT PK_ProductoCategoria PRIMARY KEY (CodigoProducto,CodigoCategoria),
  FOREIGN KEY(CodigoProducto) REFERENCES Producto(CodigoProducto),
  CONSTRAINT FK_Categoria FOREIGN KEY(CodigoCategoria) REFERENCES Categoria(CodigoCategoria),
);

---------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA PEDIDO

CREATE TABLE Pedido(
    NumeroPedido int primary key identity(1,1),
	FechaPedido datetime not null default getdate(),
	IdProveedor int not null,
	UsuarioRecibePedido varchar not null,
	MontoTotalPedido decimal(10,2) not null,
	FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor),
	CHECK (MontoTotalPedido>0),
);

--------------------------------------------------------------------------------------------------

---PROCEDEMOS ALA CREACION DE LA TABLA DETALLE_PEDIDO

CREATE TABLE DetallePedido(
   IdDetallePedido  int primary key identity(1,1),
   NumeroPedido int not null,
   CodigoProducto int not null,
   CantidadProducto decimal(8,2) not null,
   Precio decimal(8,2) not null,
   TotalDetalle as CantidadProducto*Precio,
   FOREIGN KEY (NumeroPedido) REFERENCES Pedido(NumeroPedido),
   FOREIGN KEY (CodigoProducto) REFERENCES Producto(CodigoProducto),
   CHECK(CantidadProducto>0),
   CHECK(Precio>0)
);


-------------------------------------------------------------------------------------------------
        /*COMENZAMOS A COLOCAR VALORES PARA MOSTRARLOS COMO EJEMPLO EN LAS TABLAS*/
-------------------------------------------------------------------------------------------------

---EJEMPLO DE LA TABLA CARGO

INSERT INTO Cargo(NombreCargo) VALUES ('Guardas de Seguridad');

SELECT * FROM Cargo;

-----------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA EMPLEADOS

INSERT INTO Empleado(NombreEmpleado,ApellidoEmpleado)
VALUES ('Fernando','Flores');

INSERT INTO Empleado(NombreEmpleado,ApellidoEmpleado)
VALUES ('Elida','Vallecillo');

INSERT INTO Empleado(NombreEmpleado,ApellidoEmpleado)
VALUES ('Benjamin','Lacayo');

INSERT INTO Empleado(NombreEmpleado,ApellidoEmpleado)
VALUES ('Norman','Santamarina');

INSERT INTO Empleado(NombreEmpleado,ApellidoEmpleado)
VALUES ('Brayan','Mendoza');

              /*EJEMPLOS DE LA TABLA EMPLEADOS PERO AGREGANDO EL CODIGO DE CARGO 
                    A LOS TRABAJADORES EN GUARDA DE SEGURIDAD*/


INSERT INTO Empleado(CodigoCargo,NombreEmpleado,ApellidoEmpleado)
VALUES (1,'Felipe','Ruiz');

INSERT INTO Empleado(CodigoCargo,NombreEmpleado,ApellidoEmpleado)
VALUES (1,'Josefa','Guadamuz');

INSERT INTO Empleado(CodigoCargo,NombreEmpleado,ApellidoEmpleado)
VALUES (1,'Elian','Fonseca');

INSERT INTO Empleado(CodigoCargo,NombreEmpleado,ApellidoEmpleado)
VALUES (1,'Samuel','Gutierrez');

SELECT * FROM Empleado;


----------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA USUARIO

INSERT INTO Usuario(NombreUsuario,Contrasenia)
VALUES ('fflores','280425373');
INSERT INTO Usuario(NombreUsuario,Contrasenia)
VALUES ('eelida','12353788');
INSERT INTO Usuario(NombreUsuario,Contrasenia)
VALUES ('bbenjamin','97835363');
INSERT INTO Usuario(NombreUsuario,Contrasenia)
VALUES ('nnorman','099577443');
INSERT INTO Usuario(NombreUsuario,Contrasenia)
VALUES ('mmendoza','2345577443');


SELECT * FROM Usuario;

-------------------------------------------------------------------------

----EJEMPLOS DE LA TABLA ROL

INSERT INTO Rol(NombreRol) VALUES ('Administrador');
INSERT INTO Rol(NombreRol) VALUES ('Cajero');
INSERT INTO Rol(NombreRol) VALUES ('Responsable de Bodega');

SELECT * FROM Rol;

-------------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA PERMISO

INSERT INTO Permiso(NombrePermiso) VALUES ('Crea y Edita Usuario');
INSERT INTO Permiso(NombrePermiso) VALUES ('Realiza Ventas');
INSERT INTO Permiso(NombrePermiso) VALUES ('Crea Nuevos Productos');

SELECT * FROM Permiso;

--------------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA ROL_PERMISO

INSERT INTO RolPermiso(CodigoRol,CodigoPermiso) VALUES (1,1);
INSERT INTO RolPermiso(CodigoRol,CodigoPermiso) VALUES (2,2);
INSERT INTO RolPermiso(CodigoRol,CodigoPermiso) VALUES (3,3);

SELECT * FROM RolPermiso;

--------------------------------------------------------------------------------

               /*EN ESTA SECCION EL USUARIO TIENE UN ROL POR EJEMPLO EL USUARIO DE CODIGO 1, TIENE EL
                 EL ROL NUMERO 1, DONDE FERNANDO FLORES ES RESPONSABLE DE LA ADMINISTRACION*/

INSERT INTO UsuarioRol(CodigoUsuario,CodigoRol) VALUES (1,1);
INSERT INTO UsuarioRol(CodigoUsuario,CodigoRol) VALUES (2,3);
INSERT INTO UsuarioRol(CodigoUsuario,CodigoRol) VALUES (3,2);
INSERT INTO UsuarioRol(CodigoUsuario,CodigoRol) VALUES (4,2);
INSERT INTO UsuarioRol(CodigoUsuario,CodigoRol) VALUES (5,3);

SELECT * FROM UsuarioRol;

-------------------------------------------------------------------------------

----EJEMPLO DE LA TABLA CATEGORIA

INSERT INTO Categoria(NombreCategoria) VALUES('Granos Basicos');
INSERT INTO Categoria(NombreCategoria) VALUES('Cereales');
INSERT INTO Categoria(NombreCategoria) VALUES('Lacteos');
INSERT INTO Categoria(NombreCategoria) VALUES('Golosinas');
INSERT INTO Categoria(NombreCategoria) VALUES('Galletas');
INSERT INTO Categoria(NombreCategoria) VALUES('Productos de Limpieza');

SELECT * FROM Categoria;

---------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA PRODUCTOS

INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Arroz Doña Maria Lb',
	18,
	40,
	1,
	1
);

INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Jabon Marfil por Unidad',
	25,
	39,
	6,
	2
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Rotles Rojo',
	8,
	31,
	4,
	4
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Cereal Nestle',
	45,
	31,
	2,
	4
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Leche Fresa',
	17,
	32,
	3,
	4
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Frijol Rojo',
	21,
	34,
	1,
	2
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Ace Xedex Antibacterial',
	14,
	32,
	6,
	3
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Chocolita Medio litro',
	16,
	31,
	3,
	4
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Azucar La Hacienda Lb',
	15,
	31,
	1,
	4
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Galleta Chikys',
	7,
	38,
	5,
	4
);
INSERT INTO
    Producto(
	   NombreProducto,
	   PrecioProducto,
	   Stock,
	   CodigoCategoria,
	   IdUsuarioRealiza)
VALUES(
    'Galleta Ritz Bis',
	8,
	30,
	5,
	4
);


SELECT * FROM Producto;

----MOSTRAMOS LA TABLA PRODUCTO PERO TAMBIEN EL NOMBRE DE LA CATEGORIA DEL PRODUCTO

SELECT 
	P.CodigoProducto as 'Codigo', 
	P.NombreProducto as 'Nombre del Producto', 
	P.PrecioProducto as 'Precio Venta',
	C.NombreCategoria as 'Categoria'
FROM Producto as P inner join Categoria as C
ON P.CodigoCategoria = C.CodigoCategoria

---------------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA VENTAS

INSERT INTO Ventas(MontoTotal,IdUsuarioVendedor)
VALUES(
   36,
   1
);

INSERT INTO Ventas(MontoTotal,IdUsuarioVendedor)
VALUES(
   100,
   2
);

INSERT INTO Ventas(MontoTotal,IdUsuarioVendedor)
VALUES(
   24,
   3
);

INSERT INTO Ventas(MontoTotal,IdUsuarioVendedor)
VALUES(
   270,
   4
);

SELECT * FROM Ventas;

---------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA PROVEEDOR

INSERT INTO Proveedor(NombreProveedor,NumeroTelefono) VALUES ('Procesadora de Arroz S.A',28255567);
INSERT INTO Proveedor(NombreProveedor,NumeroTelefono) VALUES ('Parmalat S.A',24545678);
INSERT INTO Proveedor(NombreProveedor,NumeroTelefono) VALUES ('Productos Ramos',23434523);
INSERT INTO Proveedor(NombreProveedor,NumeroTelefono) VALUES ('Compañia de Limpieza S.A',21226787);
INSERT INTO Proveedor(NombreProveedor,NumeroTelefono) VALUES ('Alimentos del valle S.A',27896654);

SELECT * FROM Proveedor;

--------------------------------------------------------------------------------------------------------

----EJEMPLOS DE LA TABLA PEDIDO

INSERT INTO Pedido(IdProveedor,UsuarioRecibePedido,MontoTotalPedido)
VALUES(
   1,
   2,
   1200
);
INSERT INTO Pedido(IdProveedor,UsuarioRecibePedido,MontoTotalPedido)
VALUES(
   2,
   2,
   1000
);
INSERT INTO Pedido(IdProveedor,UsuarioRecibePedido,MontoTotalPedido)
VALUES(
   3,
   3,
   1300
);
INSERT INTO Pedido(IdProveedor,UsuarioRecibePedido,MontoTotalPedido)
VALUES(
   4,
   4,
   1543
);

SELECT * FROM Pedido;

-------------------------------------------------------------------------------------------------------

---EJEMPLOS DE LA TABLA DETALLE_PEDIDO

INSERT INTO DetallePedido(NumeroPedido,CodigoProducto,CantidadProducto,Precio)
VALUES(
  1,
  1,
  2,
  18
);

INSERT INTO DetallePedido(NumeroPedido,CodigoProducto,CantidadProducto,Precio)
VALUES(
  2,
  2,
  4,
  25
);

INSERT INTO DetallePedido(NumeroPedido,CodigoProducto,CantidadProducto,Precio)
VALUES(
  3,
  3,
  3,
  8
);

INSERT INTO DetallePedido(NumeroPedido,CodigoProducto,CantidadProducto,Precio)
VALUES(
  4,
  4,
  6,
  45
);

SELECT * FROM DetallePedido WHERE NumeroPedido=1;
SELECT * FROM DetallePedido WHERE NumeroPedido=2;
SELECT * FROM DetallePedido WHERE NumeroPedido=3;
SELECT * FROM DetallePedido WHERE NumeroPedido=4;


--------------------------------------------------------------------------------------------------------

                            /*FIN DE INTRUCCIONES*/