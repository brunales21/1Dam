use jardineria;
select * from cliente;
-- Seleccione los nombres de todos los clientes que tengan un límite de crédito superior a 50000.
SELECT 
    *
FROM
    cliente
WHERE
    limite_credito > 50000;
-- Seleccione el nombre del empleado y la ciudad de la oficina para aquellos empleados que trabajan en la oficina de París.
SELECT 
    e.nombre, o.ciudad
FROM
    empleado e
        INNER JOIN
    oficina o ON e.codigo_oficina = o.codigo_oficina
HAVING o.ciudad = 'París';


SELECT 
    e.nombre, o.ciudad
FROM
    empleado e,
    oficina o
WHERE
    e.codigo_oficina = o.codigo_oficina
HAVING o.ciudad = 'París';

-- Seleccione el nombre del cliente y la fecha del pedido para aquellos pedidos realizados después del 1 de enero de 2008.

-- sin subconsulta
SELECT 
    c.nombre_cliente, p.fecha_pedido
FROM
    cliente c
        INNER JOIN
    pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.fecha_pedido > '2008-01-01';

-- con subconsulta //in
SELECT 
    c.nombre_cliente, p.fecha_pedido
FROM
    cliente c
        INNER JOIN
    pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.fecha_pedido IN (SELECT 
            fecha_pedido
        FROM
            pedido
        WHERE
            fecha_pedido > '2008-01-01');
-- con subconsulta //any
SELECT 
    c.nombre_cliente, p.fecha_pedido
FROM
    cliente c
        INNER JOIN
    pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.fecha_pedido = ANY (SELECT 
            fecha_pedido
        FROM
            pedido
        WHERE
            fecha_pedido > '2008-01-01');

-- Seleccione el nombre del producto, el precio de venta y la cantidad en stock para aquellos productos que tengan un precio de venta superior a 250 y una cantidad en stock inferior a 10.

-- sin subconsulta
SELECT 
    p.nombre, p.precio_venta, p.cantidad_en_stock
FROM
    producto p
WHERE
    p.precio_venta > 250
        AND p.cantidad_en_stock < 10;

-- con subconsulta//in
SELECT 
    p.nombre, p.precio_venta, p.cantidad_en_stock
FROM
    producto p
WHERE
    p.precio_venta IN (SELECT 
            precio_venta
        FROM
            producto
        WHERE
            precio_venta > 250)
        AND p.cantidad_en_stock IN (SELECT 
            cantidad_en_stock
        FROM
            producto
        WHERE
            cantidad_en_stock < 10);
            
-- con subconsulta//any
SELECT 
    p.nombre, p.precio_venta, p.cantidad_en_stock
FROM
    producto p
WHERE
    p.precio_venta = any (SELECT 
            precio_venta
        FROM
            producto
        WHERE
            precio_venta > 250)
        AND p.cantidad_en_stock = any (SELECT 
            cantidad_en_stock
        FROM
            producto
        WHERE
            cantidad_en_stock < 10);
        


-- Seleccione el nombre del cliente y la cantidad total pagada por ese cliente en todas las transacciones.

SELECT 
    c.nombre_cliente, SUM(p.total) AS total_pagos, count(p.total)
FROM
    cliente c
        INNER JOIN
    pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.codigo_cliente;


-- Seleccione el nombre del cliente y la cantidad total pagada por ese cliente en todas las transacciones realizadas después del 1 de enero de 2000.

SELECT 
    c.nombre_cliente, SUM(p.total), count(p.total)
FROM
    cliente c
        INNER JOIN
    pago p ON c.codigo_cliente = p.codigo_cliente
WHERE
    p.fecha_pago > '2000-01-01'
GROUP BY c.codigo_cliente;


-- Seleccione el nombre del cliente y el nombre del empleado de ventas que los representa.

SELECT 
    c.nombre_cliente, e.nombre
FROM
    cliente c
        INNER JOIN
    empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
    
-- nombre empleado y cantidad de clientes 
SELECT 
    e.nombre, COUNT(c.codigo_cliente)
FROM
    empleado e
        INNER JOIN
    cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.codigo_empleado;

-- Seleccione el nombre del cliente y la cantidad total pagada por ese cliente en todas las transacciones, ordenadas por la cantidad total pagada de mayor a menor.

SELECT 
    c.nombre_cliente, SUM(p.total) AS sumarorio_pagos
FROM
    cliente c
        INNER JOIN
    pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.codigo_cliente;

-- Seleccione el nombre del cliente y la cantidad total pagada por ese cliente en todas las transacciones, solo para aquellos clientes que hayan realizado pagos en más de una forma de pago.

SELECT 
    c.nombre_cliente, SUM(p.total)
FROM
    cliente c
        INNER JOIN
    pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.codigo_cliente
HAVING COUNT(distinct(p.forma_pago)) > 1;


SELECT 
    (SELECT 
            nombre_cliente
        FROM
            cliente c
        WHERE
            c.codigo_cliente = p.codigo_cliente) AS nombre,
    SUM(p.total)
FROM
    pago p
GROUP BY p.codigo_cliente
HAVING COUNT(DISTINCT (p.forma_pago)) > 1;


select c.nombre_cliente, sum(p.total) as total from cliente c, pago p where 
c.codigo_cliente = p.codigo_cliente 
GROUP BY p.codigo_cliente
HAVING COUNT(DISTINCT (p.forma_pago)) > 1;


SELECT 
    c.nombre_cliente,
    SUM(p1.total) AS total,
    GROUP_CONCAT(forma_pago
        SEPARATOR ', ') AS formas_de_pago,
    COUNT(*)
FROM
    pago p1
        INNER JOIN
    cliente c ON p1.codigo_cliente = c.codigo_cliente
WHERE
    EXISTS( SELECT 
            *
        FROM
            pago p2
        WHERE
            p2.codigo_cliente = p1.codigo_cliente
                AND p2.forma_pago != p1.forma_pago)
GROUP BY p1.codigo_cliente
;

select * from pago order by codigo_cliente, forma_pago;


-- Seleccione el nombre del producto y la cantidad total de pedidos realizados para ese producto.

SELECT 
    p.nombre, sum(dp.cantidad)
FROM
    producto p,
    detalle_pedido dp
WHERE
    p.codigo_producto = dp.codigo_producto
GROUP BY p.nombre;

-- Seleccione el nombre del producto y la cantidad total de pedidos realizados para ese producto, ordenados por la cantidad total de pedidos de mayor a menor.

select p.nombre, count(dp.cantidad) as cantidad from producto p, detalle_pedido dp where p.codigo_producto = dp.codigo_producto group by p.codigo_producto order by cantidad desc;
SELECT 
    p.nombre, COUNT(*) AS cantidad_pedidos
FROM 
    producto p
        INNER JOIN 
    detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
GROUP BY 
    p.codigo_producto
ORDER BY 
    cantidad_pedidos DESC;

-- Seleccione el nombre del cliente y el nombre del empleado de ventas que los representa, solo para aquellos clientes que no tienen un empleado de ventas asignado.


SELECT 
    c.nombre_cliente AS nombre_cliente,
    e.nombre AS nombre_empleado
FROM
    cliente c
        LEFT JOIN
    empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE
    c.codigo_empleado_rep_ventas IS NULL;
    
    select c.nombre_cliente from cliente c where c.codigo_empleado_rep_ventas is null;


-- Seleccione el nombre del producto y la cantidad total de pedidos realizados para ese producto, solo para aquellos productos que se han vendido en pedidos con un valor total superior a 10000.
SELECT 
    p.nombre, COUNT(dp.codigo_pedido) AS cantidad_pedidos
FROM
    producto p
        INNER JOIN
    detalle_pedido dp ON dp.codigo_producto = p.codigo_producto
        INNER JOIN
    pedido pe ON dp.codigo_pedido = pe.codigo_pedido
WHERE
    (dp.cantidad * dp.precio_unidad) > 10000
GROUP BY p.nombre
ORDER BY cantidad DESC;


SELECT 
    p.nombre, COUNT(dp.codigo_pedido) AS cantidad_pedidos
FROM
    producto p
        INNER JOIN
    detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE
    (dp.cantidad * dp.precio_unidad) > 10000
GROUP BY p.nombre
ORDER BY cantidad_pedidos DESC;



SELECT 
    p.nombre, COUNT(*) AS cantidad_pedidos
FROM
    producto p
        JOIN
    detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE
    (dp.cantidad * dp.precio_unidad) > 10000
GROUP BY p.nombre
ORDER BY cantidad_pedidos DESC;



-- Seleccione el nombre del cliente y la cantidad total pagada por ese cliente en todas las transacciones, solo para aquellos clientes que hayan realizado un pago en una forma de pago específica (por ejemplo, cheque).
SELECT 
    c.nombre_cliente, SUM(pa.total)
FROM
    cliente c
        INNER JOIN
    pago pa ON c.codigo_cliente = pa.codigo_cliente
WHERE
    pa.forma_pago IS NOT NULL
GROUP BY c.codigo_cliente;

-- Seleccione el nombre del cliente y el nombre del empleado de ventas que los representa, solo para aquellos clientes que tienen un límite de crédito superior a 50000 y que no han realizado ningún pedido en el último año.
SELECT 
    c.nombre_cliente, e.nombre
FROM
    cliente c
        INNER JOIN
    empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    
WHERE
    c.limite_credito > 50000
        AND c.codigo_cliente not in (select codigo_cliente from pedido where fecha_pedido between date_sub(now(), interval 1 year) and now());
        
        
	
