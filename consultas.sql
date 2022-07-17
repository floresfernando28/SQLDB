--Base de Datos Relacional de un sistema de supermercado
--Este scrip contiene todo tipo de consultas que ayudaran a entender más 
--sobre programación de Bases de datos

use sistema_supermercado
go

select * from usuario
select * from empleados
select * from usuario_rol
select * from rol
select * from permiso
select * from productos
select * from categoria
select * from proveedor
select * from ventas
select * from rol_permiso
select * from detalle_venta
select * from pedidos
select * from detalle_pedido
select * from cargo
select * from Producto_Categoria

-------------------------------------------------------------------------------------
--[SELECT] 

--Ejercicio #1
--Consultar todos los datos de las columnas de la tabla usuario

select * from usuario

--Ejercicio #2
--Consultar solamente los datos de las columnas [Nombre_usuario] y [contraseña] de
--la tabla usuario

select Nombre_usuario, contrasenia from usuario

--Ejercicio #3
--Consultar solamente los datos de las columnas [Nombre_usuario] , [contrasenia] 
--y [fecha_registro] de la tabla usuario

select Nombre_usuario, contrasenia, fecha_registro from usuario

--Ejercicio #4 
--Consultar solamente los datos de las columnas [id_usuario] y [fecha_registro] 
--de la tabla usuario

select id_usuario, fecha_registro from usuario

--------------------------------------------------------------------------------------

--[AS]
--Ejercicio #5 
--Consultar los datos de la columna [Nombre_empleado] de la tabla empleados
--y colocar un alias o sobreNombre

select Nombre_empleado as [Empleados] from empleados


--Ejercicio #6 
--Consultar los datos de la columna [Apellido_empleado] y [edad] de la tabla empleados
--y colocar un alias o sobreNombre a cada tabla

select Apellido_empleado as [Apellidos], edad as [Edad Actual] from empleados

--Ejercicio #7 
--Consultar los datos de la columna [Fecha_nacimiento] de la tabla empleado
--y colocar un alias o sobreNombre a la tabla

select fecha_nacimiento as [Nacimiento_Edad] from empleados

--Ejercicio #8
--Consultar los datos de las columnas [id_empleado], [fecha_contratacion], [id_usuario]
-- y [sexo] de la tabla empleados; ademas colocar un alias a cada tabla 

select id_empleado as [codigo Empleado], fecha_contratacion as [Inicio a Trabajar],
id_usuario as [codigo Usuario], sexo as [Genero] from empleados

--------------------------------------------------------------------------------------

--[CONCAT] y concatenación Simple 

--Ejercicio #9
--Consultar los datos de las columnas [Nombre_empleado] y [apellido_empleado] de la tabla 
--empleados y unir ambas columnas en una sola, ademas colocar un alias

select Nombre_empleado + ' ' + apellido_empleado as [Nombres y Apellidos de Empleados]
from empleados

--Ejercicio #10
--Consultar los datos de las columnas [Nombre_empleado] y [apellido_empleado] de la tabla 
--empleados usando la función CONCAT(), y unir ambas columnas en una sola,
--ademas colocar un alias

select Concat (Nombre_empleado, ' ' ,apellido_empleado) as [Nombres y Apellidos de Empleados]
from empleados

--Ejercicio #11
--Consultar los datos de las columnas [Nombre_productos], [precio_producto] de la tabla 
--producto, concatenar las columnas con un guion, colocar un alias

select concat(Nombre_producto, '   -   ', precio_producto) as [productos]
from productos

------------------------------------------------------------------------------------

--[TOP] --Percent
--Ejemplo #12
--Consultar los primeros 10 productos de la tabla productos, con todas sus columnas

select top 10 * from productos

--Ejercicio #13
--Consultar los 3 primeros productos de la tabla productos, con todas sus columnas

select top 3 * from productos

--Ejercicio #14
--Consultar los  primeros empleados de la tabla empleados, con todas sus columnas

select top 5 * from empleados

--Ejercicio #15
--Consultar los nombres y apellidos de los primeros 17 empleados de la tabla empleados
--ademas deben concatenar los nombres y apellidos

select top 17 concat(nombre_empleado, ' ',Apellido_Empleado)  
 as [Nombres Y Apellidos] from empleados

 --Ejercicio #16
 --Consultar el 50% de todos los proveedores de la tabla proveedores

 select top 50 percent * from proveedor

 --Ejercicio #17
 --Consultar el 10% de todos los productos de la tabla productos

 select top 10 percent * from productos

 --Ejercicio #18
 --Consultar el 85% de todas las categorias de productos en la tabla categoria

 select top 85 percent * from categoria

 ------------------------------------------------------------------------------------

 --LA SENTENCIA UPDATE
 --Ejercicio #19
 /*Modificar el nombre_empleado, su edad y su apellido del empleado con el 
 id_empleado = 7 y colocar 'Germán Antonio' en su nuevo nombre, '20' en su edad y
 'Guerrero Valdéz' en su apellido_empleado*/

update Empleados set Nombre_Empleado = 'Germán Antonio', Edad = 20, 
Apellido_Empleado = 'Guerrero Valdéz' where Id_Empleado = 7
go

--Ejercicio #20
--Modificar el stock_cantidad por '100' del producto con el id = 50
--en la tabla producto

update Productos set Stock_Cantidad = '100' where Id_Producto = 50
go

--Ejercicio #21
--Modificar el Nombre_usuario de la tabla usuario, del id_usuario = 45

update usuario set Nombre_Usuario = 'theRock' where Id_Usuario = 45

-----------------------------------------------------------------------------------

--[Funciones Agregadas] SUM
--Hacer una consulta donde me sume todos los precios de los productos de la tabla productos

select sum(precio_producto) as [Total de Precio] from productos

------------------------------------------------------------------------------------

--AVG
--Hacer una consulta donde me muestre la media del precio de productos de la tabla productos

select avg(precio_producto) as [Media] from productos

------------------------------------------------------------------------------------

--MIN
--Hacer una consulta donde me muestre el precio menor de todos los productos de la tabla productos

select min(precio_producto) as [Costo Menor] from productos

-------------------------------------------------------------------------------------

--MAX
--Hacer una consulta donde me muestre el precio mayor de todos los productos de la tabla productos

select max(precio_producto) as [Costo Mayor] from productos

---------------------------------------------------------------------------------------

--COUNT()
--Hacer una consulta donde me muestre el total de productos que hay en la tabla productos

select count(*) as [Total Productos] from productos

--Hacer una consulta donde me muestre e total de productos, donde su precio_producto = 45
--Agregar un alias

select count(precio_producto) as [Precios = 45] from Productos where Precio_Producto = 45

--------------------------------------------------------------------------------------
--UPPER
--Hacer una consulta de todos los nombres de los empleados, pero sus apellidos deben
--ir en mayusculas, unir Nombres y apellidos en una columna

select concat(Nombre_empleado, ' ', upper(Apellido_empleado)) as [Nombres y Apellidos]
from empleados

------------------------------------------------------------------------------------------
--LOWER
--Hacer una consulta de todos los nombres de los empleados, pero sus apellidos iran 
--totalmente en minusculas, y sus nombres totalmente en mayusculas, concatenar ambos, 
--de la tabla empleados

select concat(upper(Nombre_empleado), ' ',lower(apellido_empleado)) as [Nombres y Apellidos]
from empleados

--------------------------------------------------------------------------------------
--LEN
--Hacer una consulta donde me muestre el numero de caracteres que tienen los nombres 
--de los empleados

select len(Nombre_empleado) as [Número Caracteres] from empleados 

---------------------------------------------------------------------------------------
--[LOS SUBSTRING]
--Hacer un programa que nos ayude a mostrar los primeros 40 productos de la tabla produtos
--Pero, queremos ver las primera cinco letras del nombre

select top 40  substring(Nombre_Producto,1,5) as [Nombres De los Productos]  from productos

------------------------------------------------------------------------------------------
--[Group By]
--Hacer una consulta donde agrupre el sexo de los trabajadores, cuente cuantos son varones y mujeres

select count(sexo) as [Sexos] from Empleados
group by sexo

-----------------------------------------------------------------------------------------

--[ORDER BY]
--Hacer una consulta donde muestre el precio de los productos ordenamos de manera 
--aascendente, los primeros 20 productos

select top 20 * from Productos
order by  Nombre_Producto asc

---Hacer una consulta donde muestre el precio de los productos de manera decendentes
--los primeros 40 porciento

select top 40 percent * from Productos
order by Precio_Producto desc
-------------------------------------------------------------------------------------
--[LIKE]
--Hacer una consulta donde muestre todos los empleados que su nombre empiecen con 'Fe'
--ordenar de manera ascendente el id_empleado, de la tabla empleados

select Id_empleado,nombre_empleado from Empleados
where Nombre_Empleado like 'fe%'
order by Id_Empleado asc
go
-------------------------------------------------------------------------------------
--[INNER JOIN]
--Hacer una consulta donde muestre los primeros 50 producto, su nombre, su id, su 
--Nombre de categoria

select top 50 p.id_producto, p.Nombre_producto, c.Nombre_categoria
from Productos p inner join Categoria c
on p.id_categoria=c.Id_Categoria
go

-------------------------------------------------------------------------------------
--[WHERE]
--Hacer una consulta que muestre solamente los datos del empleado con el id_empleado = 10

select * from Empleados where Id_Empleado = 10

--Hacer una consulta que muestre solamente el id_producto, stock_cantidad, nombre_producto y precio
--producto de la tabla productos, del id_producto = 78

select id_producto,Nombre_producto, precio_producto, stock_cantidad 
from Productos where Id_Producto = 78
go
------------------------------------------------------------------------------------

--[PROCEDIMIENTOS ALMACENADOS]
--Realizar un procedimiento almacenado donde permita buscar un empleado en la tabla
--empleados, solamente por su Nombre_empleado, Verificar si el procedimiento existe
--si existe, debera ser eliminado

if OBJECT_ID('Prueba') is not null
begin
	drop proc Prueba
end
go
create procedure Prueba
@Empleado varchar(50)
as
	select * from Empleados where Nombre_Empleado = @Empleado
go

exec Prueba 'Germán Antonio' --Ejecutamos el procedimiento Almacenado
exec Prueba 'Brayan Ernesto' --Ejecutamos el procedimiento Almacenado
exec Prueba 'Gloria Del socorro' --Ejecutamos el procedimiento Almacenado


--Crear un procedimiento almacenado donde pueda buscar un producto por su nombre,
--realizar una subconsulta 

if object_id('validacion') is not null
begin
	drop procedure validacion
end 
go
create procedure validacion
@producto varchar(50)
as
	select * from Productos where Id_Producto = (
										select Id_producto from Productos
										where Nombre_Producto = @producto
									 );
go
exec validacion @producto = 'Helado de vainilla' --Ejecutamos el procedimiento almacenado
exec validacion @producto = 'Coca Cola 2lt' --Ejecutamos el procedimiento almacenado
exec validacion @producto = 'Azucar lb' --Ejecutamos el procedimiento almacenado

-------------------------------------------------------------------------------------
--[BETWEEN]
--Hacer una consulta que me muestre todos los datos de los productos que se encuentre
--sus precios de productos entre 60 y 100 cordobas su valor, ademas ordene de forma desc 

select * from Productos
where Precio_Producto between 60 and 100
order by Precio_Producto desc
go

----------------------------------------------------------------------------------------