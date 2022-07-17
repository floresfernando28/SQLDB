use Mercado 

--Hacer una consulta en la tabla empleado donde muestre los primeros 10 empleados 
--select top 3 * from empleados consulta 
--order by nombre de la tabla desc ordenarlos de forma decendentes
select top 3 * from empleados
order by Id_empleados desc

select top 2 * from categoria
order by Id_categoria desc

select top 3 * from producto 
order by precio asc

--ordenar de manera ascendente (asc)

select * from usuario where Id_usuario = 10

---La clausula count(*)

select COUNT(*)  as [Número Total de empleados] from empleados


---La clausula sum

select SUM(precio)as [Suma Total de los Precios] from producto


--La clausula avg

select AVG(precio) as [La media] from producto

--La clausula min

select MIN(precio) as [Precio Menor] from producto


---La clausula max


select MAX(precio) as [Precio Mayor] from producto





