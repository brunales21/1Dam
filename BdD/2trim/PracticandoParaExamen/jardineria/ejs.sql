use jardineria;
-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select codigo_oficina, ciudad from oficina;
-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select ciudad, telefono from oficina where pais in ('España');
-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe
-- tiene un código de jefe igual a 7.
select nombre, apellido1, email from empleado where codigo_jefe = 7;
-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select puesto, nombre, apellido1, email from empleado where codigo_jefe is null;
-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados
-- que no sean representantes de ventas.
select nombre, apellido1, puesto from empleado where puesto not in ('Representante Ventas');
-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
select nombre_cliente from cliente where pais in ('Spain');
-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select distinct(estado) from pedido;
-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron
-- algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de
-- cliente que aparezcan repetidos. Resuelva la consulta:
-- Utilizando la función YEAR de MySQL.
select codigo_cliente from pago where year(fecha_pago) in ('2008');
-- Utilizando la función DATE_FORMAT de MySQL.
select codigo_cliente from pago where date_format(fecha_pago, '%Y') in ('2008');
-- Sin utilizar ninguna de las funciones anteriores.
select codigo_cliente from pago where fecha_pago between '2008-01-01' and '2008-12-31';
-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada
-- y fecha de entrega de los pedidos que no han sido entregados a tiempo.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where fecha_entrega>fecha_esperada;
-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada
-- y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos
-- días antes de la fecha esperada.
-- Utilizando la función ADDDATE de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where adddate(fecha_entrega, interval 2 day) = fecha_esperada;
-- Utilizando la función DATEDIFF de MySQL.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where datediff(fecha_esperada, fecha_entrega) = 2;
-- ¿Sería posible resolver esta consulta utilizando el operador de suma (+) o resta (-)? Sí. Se puede.
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where fecha_esperada-fecha_entrega=2;
-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select * from pedido where year(fecha_pedido) in ('2009') and estado in ('Rechazado');
-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de
-- enero de cualquier año.
select * from pedido where month(fecha_entrega) in ('01');
-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select * from pago where year(fecha_pago) = 2008 and forma_pago in ('Paypal') order by fecha_pago desc;
-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago.
-- Tenga en cuenta que no deben aparecer formas de pago repetidas.
select forma_pago from pago group by forma_pago;
-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar
-- ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
select * from producto where gama in ('Ornamentales') and cantidad_en_stock > 100 order by precio_venta desc;
-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
-- cuyo representante de ventas tenga el código de empleado 11 o 30.
select * from cliente where ciudad in ('Madrid') and codigo_empleado_rep_ventas in (30, 11);
-- 17. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
-- representante de ventas.
select nombre_cliente, nombre, apellido1 from cliente inner join empleado on codigo_empleado_rep_ventas = codigo_empleado;
-- 18. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre
-- de sus representantes de ventas.
select c.nombre_cliente, e.nombre from cliente c, empleado e where c.codigo_empleado_rep_ventas = codigo_empleado and exists (select * from pago where codigo_cliente = c.codigo_cliente);
-- 19. Muestra el nombre de los clientes que no hayan realizado pagos junto con el
-- nombre de sus representantes de ventas.
select c.nombre_cliente, e.nombre from cliente c, empleado e where c.codigo_empleado_rep_ventas = e.codigo_empleado and not exists (select * from pago where codigo_cliente = c.codigo_cliente);
-- 20. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el representante.
select c.nombre_cliente, e.nombre, o.ciudad from empleado e inner join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas inner join oficina o on e.codigo_oficina = o.codigo_oficina where exists (select * from pago where c.codigo_cliente = codigo_cliente);
-- 21. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de
-- sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select c.nombre_cliente, e.nombre, o.ciudad from cliente c, empleado e, oficina o where c.codigo_empleado_rep_ventas = e.codigo_empleado and e.codigo_oficina = o.codigo_oficina;
-- 22. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select o.linea_direccion1 from oficina o where exists (select * from empleado e inner join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas where e.codigo_oficina = o.codigo_oficina and c.ciudad = 'Fuenlabrada');
-- 23. Devuelve el nombre de los clientes y el nombre de sus representantes junto con
-- la ciudad de la oficina a la que pertenece el representante.
select c.nombre_cliente, e.nombre, o.ciudad from empleado e inner join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas inner join oficina o on e.codigo_oficina = o.codigo_oficina; 
-- 24. Devuelve un listado con el nombre de los empleados junto con el nombre de sus
-- jefes.
select e.nombre, j.nombre from empleado e, empleado j where e.codigo_jefe = j.codigo_empleado;
-- 25. Devuelve un listado que muestre el nombre de cada empleados, el nombre de
-- su jefe y el nombre del jefe de sus jefe.
select e.nombre, j.nombre, jj.nombre from empleado j inner join empleado e on e.codigo_jefe = j.codigo_empleado inner join empleado jj on j.codigo_jefe = jj.codigo_empleado;
-- 26. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un
-- pedido.
select c.nombre_cliente from cliente c where exists (select * from pedido p where p.codigo_cliente = c.codigo_cliente and p.fecha_entrega > fecha_esperada);
-- 27. Devuelve un listado de las diferentes gamas de producto que ha comprado cada
-- cliente.

-- 28. Devuelve un listado que muestre solamente los clientes que no han realizado
-- ningún pago.
SELECT c.codigo_cliente, c.nombre_cliente 
FROM cliente c 
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;

select * from cliente c where not exists (select * from pago p where p.codigo_cliente = c.codigo_cliente);
select * from cliente c where c.codigo_cliente not in (select codigo_cliente from pago);
-- 29. Devuelve un listado que muestre solamente los clientes que no han realizado
-- ningún pedido.
select * from cliente c where not exists (select * from pedido p where p.codigo_cliente = c.codigo_cliente);
-- 30. Devuelve un listado que muestre los clientes que no han realizado ningún pago
-- y los que no han realizado ningún pedido.
select * from cliente c where not exists (select * from pedido pe where pe.codigo_cliente = c.codigo_cliente) and not exists (select * from pedido p where p.codigo_cliente = c.codigo_cliente);
-- 31. Devuelve un listado que muestre solamente los empleados que no tienen una
-- oficina asociada.
select * from empleado e where not exists (select * from oficina o where o.codigo_oficina = e.codigo_oficina);
select * from empleado e where e.codigo_oficina not in (select o.codigo_oficina from oficina o);
select * from empleado e where e.codigo_oficina is null;
-- 32. Devuelve un listado que muestre solamente los empleados que no tienen un
-- cliente asociado.
select * from empleado e where e.codigo_empleado not in (select c.codigo_empleado_rep_ventas from cliente c where c.codigo_empleado_rep_ventas is not null);
select * from empleado e where not exists (select * from cliente c where c.codigo_empleado_rep_ventas = e.codigo_empleado);
-- 33. Devuelve un listado que muestre solamente los empleados que no tienen un
-- cliente asociado junto con los datos de la oficina donde trabajan.
select * from empleado e inner join oficina o on e.codigo_oficina = o.codigo_oficina where not exists (select * from cliente where codigo_empleado_rep_ventas = e.codigo_empleado);
-- 34. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
select * from empleado e where not exists (select * from oficina o where o.codigo_oficina = e.codigo_oficina) and not exists (select * from cliente c where c.codigo_empleado_rep_ventas = e.codigo_empleado);
-- 35. Devuelve un listado de los productos que nunca han aparecido en un pedido.
-- 36. Devuelve un listado de los productos que nunca han aparecido en un pedido. El
-- resultado debe mostrar el nombre, la descripción y la imagen del producto.
-- 37. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan
-- sido los representantes de ventas de algún cliente que haya realizado la compra
-- de algún producto de la gama Frutales.
-- 38. Devuelve un listado con los clientes que han realizado algún pedido pero no han
-- realizado ningún pago.
select * from cliente c where exists (select * from pedido pe where pe.codigo_cliente = c.codigo_cliente) and not exists (select * from pago pa where pa.codigo_cliente = c.codigo_cliente);
-- 39. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
-- 40. ¿Cuántos empleados hay en la compañía?
select count(*) from empleado;
-- 41. ¿Cuántos clientes tiene cada país?
select pais, count(*) from cliente group by pais;
-- 42. ¿Cuál fue el pago medio en 2009?
select avg(total) from pago where year(fecha_pago) in (2009);
-- 43. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
-- 44. Calcula el precio de venta del producto más caro y más barato en una misma
-- consulta.
-- 45. Calcula el número de clientes que tiene la empresa.
-- 46. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
-- 47. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
-- 48. Devuelve el nombre de los representantes de ventas y el número de clientes al
-- que atiende cada uno.
-- 49. Calcula el número de clientes que no tiene asignado representante de ventas.
-- 50. Calcula la fecha del primer y último pago realizado por cada uno de los clientes.
-- El listado deberá mostrar el nombre y los apellidos de cada cliente.
-- 51. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
-- 52. Calcula la suma de la cantidad total de todos los productos que aparecen en cada
-- uno de los pedidos.
-- 53. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el
-- número total de unidades vendidas.
-- 54. La facturación que ha tenido la empresa en toda la historia, indicando la base
-- imponible, el IVA y el total facturado. La base imponible se calcula sumando el
-- coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos
-- anteriores.
-- 55. La misma información que en la pregunta anterior, pero agrupada por código de
-- producto.
-- 56. La misma información que en la pregunta anterior, pero agrupada por código de
-- producto filtrada por los códigos que empiecen por OR.
-- 57. Lista las ventas totales de los productos que hayan facturado más de 3000 euros.
-- Se mostrará el nombre, unidades vendidas, total facturado y total facturado con
-- impuestos (21 % IVA).
-- 58. Muestre la suma total de todos los pagos que se realizaron para cada uno de los
-- Página 190 Creative Commons c b n a
-- Bases de Datos Sergio Cuesta Vicente
-- años que aparecen en la tabla pagos.
-- 59. Devuelve el nombre del cliente con mayor límite de crédito.
-- 60. Devuelve el nombre del producto que tenga el precio de venta más caro.
-- 61. Devuelve el nombre del produ