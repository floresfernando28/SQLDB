--Base de datos de un supermercado 
--Elaborada por Fernando José Flores Mendoza
--Ingeniería en sistemas de Información
--Diseño y programación de Bases de datos

use Supermercado;
go

--Todas las tablas que contiene la DB (DB Relacional)

select * from Empleado
select * from usuario
select * from cargo
select * from rol
select * from rolPermiso
select * from usuarioRol
select * from producto
select * from productoCategoria
select * from categoria
select * from DetallePedido
select * from pedido
select * from permiso
select * from proveedor
select * from ventas

--------------------------------------------------------------------------------
--La funcion (all) retorna todos los datos de las tablas de la DB
--Tambien lo podemos hacer sin el (all) y solamente con el (*)

select all * from cargo
select * from empleado

--------------------------------------------------------------------------------
--La clausula (as) determina pseudonombres a las columnas. Tambien si deseamos 
--seleccionar algunas columnas de una tabla lo hacemos sin (all *) y colocamos
--el nombre de la columna que deseamos ver

select nombreEmpleado as Nombres from empleado

--------------------------------------------------------------------------------
--Tambien dentro de la clausula select podemos contatenar columnas de una tabla
--Lo hacemos luego de escribir el (select TABLAS + ESPACIO('') + TABLA
--Dato muy importante es que debemos escribir entre corchetes el pseudonombre
--cuando dejamos espacios entre palabras, como es el ejemplo [Nombres Completos]

select nombreEmpleado +' '+ apellidoEmpleado as [Nombres Completos] from empleado

--------------------------------------------------------------------------------
--Podemos colocar pseudonombres alas tablas que queramos utilizar

select codigoProducto as ID, NombreProducto as Producto, PrecioProducto as valor
from producto

--------------------------------------------------------------------------------
--La clausula (order by) = asc Ordenamos valores de manera ascendente
--La palabra reservada (go) retorna los valores que solicitamos atraves de la consulta

select NombreProducto as Nombre, PrecioProducto as Valor from producto
order by PrecioProducto asc
go

-------------------------------------------------------------------------------
--La clausula (order by) = desc Ordenamos los valores de manera Descendente

select NombreProducto as Nombre, PrecioProducto as Valor from producto
order by PrecioProducto desc
go

---------------------------------------------------------------------------------
--La clausula (top) muestra el numero de datos que nosotros deseamos ver o se 
--piden en consultas

select top 2 Fechaventa as Datetimes from ventas
order by fechaventa desc
go

--------------------------------------------------------------------------------
--Tambien con la clausula (top) podemos hacerlo atraves de porcentajes, usando la
--palabra reservada por SQL (percent) que equivale al tanto por ciento

select top 30 percent  NombreProducto as Poductos from producto

---------------------------------------------------------------------------------
--INNER JOIN
--Nos permite unir datos de columnas de varias tablas, con ayuda de las 
--foreing key (llaves foraneas), de lo contrario no es posible

select em.Nombreempleado+ ' '+em.apellidoempleado as [Nombres y Apellidos], 
car.codigoCargo as [cargo] from Empleado em inner join Cargo car
on em.codigocargo=car.codigocargo
go

--TABLAS UTILIZADAS PARA LOS JOIN

select * from empleado
select * from cargo


select ID.Nombrecategoria as[Tipo Producto], produc.Nombreproducto as [Producto],
produc.precioproducto as [precio]
from categoria ID inner join producto produc
on Id.codigocategoria=produc.codigocategoria
order by precioproducto asc
go
--TABLAS UTILIZADAS PARA LOS JOIN

select * from categoria
select * from producto

select ped.numeropedido as [cantidad], ped.fechapedido as [fecha],
ped.montototalpedido as [Monto a pagar], pro.nombreproveedor as [nombre],
pro.numerotelefono as [Teléfono] from pedido ped inner join  proveedor pro
on ped.idproveedor=pro.idproveedor
go

--TABLAS UTILIZADAS 

select * from pedido
select * from proveedor

--------------------------------------------------------------------------------

--la clausula (where) es demasiado importante ya que nos permite hacer busquedas
--especificas dentro de tablas

select all * from producto
where Nombreproducto='frijol rojo'
go

select * from empleado
where Nombreempleado='fernando' and apellidoempleado='flores'
go

select * from categoria
where codigocategoria >= '4' and codigocategoria <='6'
order by codigocategoria desc
go

--pedido de fecha y hora

select * from pedido
where fechapedido = '2021-12-27 15:29:20.307'
go

--pedido por años

select all * from pedido
where year(fechapedido) = '2021'
go

--pedidos por dias

select * from pedido
where day(fechapedido) = '29'
go

--pedidos por meses

select * from pedido
where month(fechapedido) = '12'
go

select * from pedido

---------------------------------------------------------------------------------
--La funcion de agregado de SQL (SUM) que suma valores totales de una tabla

select sum(montototalpedido) as [Monto total] from pedido

--Utilizando la clausula where

select sum(montototalpedido) as [Monto total] from pedido
where numeropedido >= 1  and numeropedido <=4

--------------------------------------------------------------------------------
--La propiedad (count) sirve de acumulador y cuenta la cantidad de datos de 
--las tablas

select count(*) as [Total de productos] from producto

--Tambien se puede hacer espedificando la tabla

select count(codigocargo) as [Total de cargos] from cargo

--------------------------------------------------------------------------------