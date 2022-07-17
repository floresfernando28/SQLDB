--Diseño de Bases de datos (SQL)
/*
	Integrante: Yatzari Salazar
	Maestro: Ingeniero Pedro Pablo Mendoza
	Carrera: Ingeniería en sistemas de Información

	NOTA:
	Verificamos si la Base de datos existe y si existe la eliminamos y usamos la master,
	Tener cuidado al eliminar la BD / Corre el riesgo de eliminar otras BD importantes
*/ 
IF DB_ID ('sistema_nomina') is not null
BEGIN
   USE MASTER
   DROP DATABASE sistema_nomina
END

--Creamos la Base de datos
CREATE DATABASE sistema_nomina
Go

--Usamos la BD creada
USE sistema_nomina
GO

--Creación de la tabla usuario
CREATE TABLE usuario(
	Id_Usuario INT PRIMARY KEY IDENTITY(1,1), --Llave primaria
	Nombre_Usuario VARCHAR(60) not null,
	contrasenia VARCHAR(60) not null,
	Fecha_Creacion_Usuario DATETIME DEFAULT GETDATE() not null 
);

--Creación de la tabla Cargo
CREATE TABLE Cargo(
    Id_Cargo INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Cargo VARCHAR(50) not null,
);


--Creación de la tabla Empleado
CREATE TABLE Empleados(
    Id_Empleado INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Empleado VARCHAR(50) not null,
	Apellido_Empleado VARCHAR(50) not null,
	Fecha_Contratacion DATETIME not null DEFAULT GETDATE(),
    Edad INT not null,
	Sexo VARCHAR(60) not null,
	Fecha_Nacimiento DATE not null,
	Salario DECIMAL(8,2) not null,
	CONSTRAINT ['EL SALARIO DEBE SER MAYOR A 0'] CHECK(Salario>0),
	Id_Usuario INT,
	Id_Cargo INT,
	FOREIGN KEY (Id_Usuario) REFERENCES usuario(Id_Usuario),
	FOREIGN KEY (Id_Cargo) REFERENCES Cargo(Id_Cargo)
);

--Alteramos la tabla Empleado (Más que todo ejemplo para mostrar el uso de alter)
--Queremos que el Nombre_Empleado tenga un varchar(60) y no de 50
ALTER TABLE Empleados
ALTER COLUMN Nombre_Empleado VARCHAR(60) not null


--Creamos la tabla permisos
CREATE TABLE Permiso(
    Id_Permiso INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Permiso VARCHAR(100) not null,
);

--Creamos la tabla Rol
CREATE TABLE Rol(
    Id_Rol INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Rol VARCHAR(50) not null,
);

--Creamos una tabla donde represente el codigo de Rol y los permisos del Rol
CREATE TABLE Rol_Permiso(
    Id_Rol INT,
	Id_Permiso INT,
	CONSTRAINT PK_RolPermiso PRIMARY KEY(Id_Rol,Id_Permiso),
	FOREIGN KEY(Id_Rol) REFERENCES Rol(Id_Rol),
	CONSTRAINT FK_Permiso FOREIGN KEY(Id_Permiso) REFERENCES Permiso(Id_Permiso),
);


--Creamos una tabla donde represente el codigo de usuario y sus roles
CREATE TABLE Usuario_Rol(
    Id_Usuario INT,
	Id_Rol INT,
	CONSTRAINT Pk_UsuarioRol PRIMARY KEY(Id_Usuario,Id_Rol),
	FOREIGN KEY(Id_Usuario) REFERENCES Usuario(Id_Usuario),
	FOREIGN KEY(Id_Rol) REFERENCES Rol(Id_Rol),
);


--Creamos la tabla deduccion
CREATE TABLE Deduccion(
  Id_Deduccion INT PRIMARY KEY IDENTITY(1,1),
  Nombre_Deduccion VARCHAR(50) not null,
  Monto_Deduccion DECIMAL(8,2)
);
--Para alterar la tabla 
--ALTER TABLE Deduccion ADD Monto_Deduccion DECIMAL(8,2)

--Creamos la tabla usuario y la peticion osea (deduccion que aplico)
CREATE TABLE Usuario_Deduccion(
    Id_Usuario INT,
	Id_Deduccion INT,
	CONSTRAINT Pk_UsuarioDeduccion PRIMARY KEY(Id_Usuario,Id_Deduccion),
	FOREIGN KEY(Id_Usuario) REFERENCES Usuario(Id_Usuario),
	FOREIGN KEY(Id_Deduccion) REFERENCES Deduccion(Id_Deduccion),
);

--Creamos la tabla Bonificación
CREATE TABLE Bonificacion(
	Id_Bonificacion INT PRIMARY KEY IDENTITY(1,1),
	Nombre_Bonificacion VARCHAR(60) not null,
	Monto_Bonificacion DECIMAL(8,2)
);

--Alteramos la tabla Bonificacion para añadir la columna monto
--ALTER TABLE Bonificacion ADD Monto_Bonificacion DECIMAL(8,2)

--Creamos una tabla aparte donde represente el usuario y su Bonificación
CREATE TABLE Usuario_Bonificacion(
    Id_Usuario INT,
	Id_Bonificacion INT,
	CONSTRAINT Pk_UsuarioBonificacion PRIMARY KEY(Id_Usuario,Id_Bonificacion),
	FOREIGN KEY(Id_Usuario) REFERENCES Usuario(Id_Usuario),
	FOREIGN KEY(Id_Bonificacion) REFERENCES Bonificacion(Id_Bonificacion),
);


--Creamos la tabla Nominas
CREATE TABLE Nominas(
   Id_Nomina INT PRIMARY KEY IDENTITY(1,1),
   Id_Usuario_Realiza INT not null,
   Id_Usuario_Aprobo INT not null,
   Fecha_De_Registro DATETIME DEFAULT GETDATE() not null,
   Monto_Total DECIMAL(10,2) not null,
   CONSTRAINT ['EL MONTO TOTAL DEBE SER MAYOR A 0'] CHECK(Monto_Total>0),
   FOREIGN KEY(Id_Usuario_Realiza) REFERENCES Usuario(Id_Usuario),
   FOREIGN KEY(Id_Usuario_Aprobo) REFERENCES Usuario(Id_Usuario)
);

--Creamos la tabla detalle de la nomina
CREATE TABLE Detalle_nomina(
	Id_Detalle_nomina INT PRIMARY KEY IDENTITY(1,1),
	Id_Nomina INT not null,
	Id_Empleado INT not null,
	Bonificacion DECIMAL(8,2) not null,
	Deduccion DECIMAL(8,2) not null,
	Salario_Base DECIMAL(8,2) not null,
	Pago_Recibir AS Salario_Base+Bonificacion-Deduccion,  --Se realiza la Operacion planteada en el sistema
	Id_Deduccion INT,
	Id_Bonificacion INT,
	FOREIGN KEY(Id_Nomina) REFERENCES Nominas(Id_Nomina),
	FOREIGN KEY(Id_Deduccion) REFERENCES Deduccion(Id_Deduccion),
	FOREIGN KEY(Id_Bonificacion) REFERENCES Bonificacion(Id_Bonificacion),
	FOREIGN KEY(Id_Empleado) REFERENCES Empleados(Id_Empleado)
);



--LAS TABLAS DE LA BASE DE DATOS ESTAN CREADAS!!!!

--INSERTAMOS ALGUNOS DATOS ALAS TABLAS

--Insertamos en la tabla usuario
INSERT INTO usuario (Nombre_Usuario, contrasenia) VALUES ('yysalazar09', '12345')
INSERT INTO usuario (Nombre_Usuario, contrasenia) VALUES ('fflores2803', 'frld995') 
INSERT INTO usuario (Nombre_Usuario, contrasenia) VALUES ('Mariajose997', 'dhfhf484') 
INSERT INTO usuario (Nombre_Usuario, contrasenia) VALUES ('pedromendoza', 'mesirve8696') 

--Insertamos en la tabla Cargo
INSERT INTO Cargo (nombre_cargo) VALUES ('Guarda de seguridad')
INSERT INTO Cargo (nombre_cargo) VALUES ('Encargados de limpieza')


--Insertamos en la tabla Empleados
INSERT INTO Empleados
	(Nombre_Empleado, Apellido_Empleado, Edad, Id_Usuario, Salario, Id_Cargo,Sexo,Fecha_Nacimiento)
VALUES
	('Yatzary Salazar', 'Fonseca', 20, 1,6674.56,1,'F', '2002-03-12')
INSERT INTO Empleados
	(Nombre_Empleado, Apellido_Empleado, Edad, Id_Usuario,Salario, Id_Cargo,Sexo, Fecha_Nacimiento)
VALUES
	('Fernando Flores', 'Mendoza', 20, 3,6000.99,2,'M', '2002-03-12')
INSERT INTO Empleados
	(Nombre_Empleado, Apellido_Empleado, Edad, Id_Usuario,Salario, Id_Cargo,Sexo, Fecha_Nacimiento)
VALUES
	('Maria José ', 'Terán', 20, 3,6000.99,2,'F', '2001-03-09')
INSERT INTO Empleados
	(Nombre_Empleado, Apellido_Empleado, Edad, Id_Usuario,Salario, Id_Cargo,Sexo, Fecha_Nacimiento)
VALUES
	('Pedro Pablo', 'Mendoza', 37, 3,6000.99,2,'M', '1983-06-08')
--Insertamos datos en la tabla Nominas
INSERT INTO Nominas(Id_Usuario_Realiza,Id_Usuario_Aprobo, Monto_Total)
VALUES (1, 1, 88659.23)
INSERT INTO Nominas(Id_Usuario_Realiza,Id_Usuario_Aprobo, Monto_Total)
VALUES (2, 2, 58659.23)


--Insertamos datos en la tabla Rol
INSERT INTO Rol(Nombre_Rol) VALUES('Administrador')
INSERT INTO Rol(Nombre_Rol) VALUES('Gerente de recursos humanos')
INSERT INTO Rol(Nombre_Rol) VALUES('Asistente de recursos humanos')

--Insertamos datos en la tabla Permiso
INSERT INTO Permiso(Nombre_Permiso) VALUES('Crear usuario, editar, ver reporte y aprobar nominas')
INSERT INTO Permiso(Nombre_Permiso) VALUES('Realizar nominas, ver reportes, puede registrar empleados')
INSERT INTO Permiso(Nombre_Permiso) VALUES('Realizar Nominas y registrar empleados')

--Insertamos datos en la tabla Deduccion
INSERT INTO Deduccion(Nombre_Deduccion,Monto_Deduccion) VALUES('INSS', 540.66)
INSERT INTO Deduccion(Nombre_Deduccion,Monto_Deduccion) VALUES('IR', 65.66)
INSERT INTO Deduccion(Nombre_Deduccion,Monto_Deduccion) VALUES('LLegadas tardes', 500.55)
INSERT INTO Deduccion(Nombre_Deduccion,Monto_Deduccion) VALUES('Inasistencias', 5455.66)

--Inserttamos datos en la tabla usuario_Deducciones
INSERT INTO Usuario_Deduccion(Id_Usuario, Id_Deduccion) VALUES (1,1)

--Insertamos datos en la  tabla Bonificacion
INSERT INTO Bonificacion(Nombre_Bonificacion,Monto_Bonificacion) VALUES('Bonificacion por horas Extras', 900.56)

--Insertamos datos en la tabla usuario_bonificacion
INSERT INTO Usuario_Bonificacion(Id_Usuario, Id_Bonificacion) VALUES (1,1)
INSERT INTO Usuario_Bonificacion(Id_Usuario, Id_Bonificacion) VALUES (2,1)
--Insertamos datos en la tabla Rol_permiso
INSERT INTO Rol_Permiso(Id_Rol, Id_Permiso) VALUES (1,1)
INSERT INTO Rol_Permiso(Id_Rol, Id_Permiso) VALUES (2,2)
INSERT INTO Rol_Permiso(Id_Rol, Id_Permiso) VALUES (3,2)

--Insertamos datos en la tabla Usuario_rol
INSERT INTO Usuario_Rol(Id_Usuario, Id_Rol) VALUES (1,1)
INSERT INTO Usuario_Rol(Id_Usuario, Id_Rol) VALUES (2,2)
INSERT INTO Usuario_Rol(Id_Usuario, Id_Rol) VALUES (3,1)
INSERT INTO Usuario_Rol(Id_Usuario, Id_Rol) VALUES (4,3)

--Insertamos datos en la tabla Detalle_Nomina
INSERT INTO Detalle_nomina(Id_Nomina,Id_Empleado, Bonificacion, Deduccion, Salario_Base, Id_Deduccion, Id_Bonificacion)
	VALUES (1,1,900.56,65.66, 6674.56,1,1)
INSERT INTO Detalle_nomina(Id_Nomina,Id_Empleado, Bonificacion, Deduccion, Salario_Base, Id_Deduccion, Id_Bonificacion)
	VALUES (2,2,900.56,540.66, 6000.99,2,1)


--CONSULTAS
SELECT * FROM usuario
SELECT * FROM cargo
SELECT  * FROM Empleados
SELECT * FROM Rol
SELECT * FROM Permiso
SELECT * FROM Rol_Permiso
SELECT * FROM Usuario_Rol
SELECT * FROM Bonificacion
SELECT * FROM Usuario_Bonificacion
SELECT * FROM Deduccion
SELECT * FROM Usuario_Deduccion
SELECT * FROM Nominas
SELECT * FROM Detalle_nomina


--FIN--

