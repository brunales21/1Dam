use jardineria;
/*1. Crea una vista que se llame listado_pagos_clientes todos los clientes y los pagos
que ha realizado cada uno de ellos. La vista deberá tener las siguientes columnas:
nombre y apellidos del cliente concatenados, teléfono, ciudad, pais, fecha_pago,
total del pago, id de la transacción.*/

CREATE OR REPLACE VIEW listado_pagos_clientes as
    SELECT 
        CONCAT(c.nombre_contacto, c.apellido_contacto),
        c.telefono,
        c.ciudad,
        c.pais,
        p.fecha_pago,
        p.total,
        p.id_transaccion
    FROM
        cliente c
            INNER JOIN
        pago p USING (codigo_cliente);
-- comprobacion
select * from listado_pagos_clientes;

/*2. Crea una vista que se llame listado_pedidos_clientes que muestre un listado donde aparezcan todos los clientes y los pedidos que ha realizado cada uno de ellos.
La vista deberá tener las siguientes columnas: nombre y apellidos del cliente concatendados, teléfono, ciudad, pais, código del pedido, fecha del pedido, fecha
esperada, fecha de entrega y la cantidad total del pedido, que será la suma del
producto de todas las cantidades por el precio de cada unidad, que aparecen en
cada línea de pedido..*/

CREATE OR REPLACE VIEW listado_pedidos_clientes AS
    SELECT 
        CONCAT(c.nombre_contacto, c.apellido_contacto) as contacto,
        c.telefono,
        c.ciudad,
        c.pais,
        p.codigo_pedido,
        p.fecha_pedido,
        p.fecha_esperada,
        p.fecha_entrega,
        (dp.cantidad * dp.precio_unidad) as total
    FROM
        pedido p
            INNER JOIN
        cliente c USING (codigo_cliente)
            INNER JOIN
        detalle_pedido dp USING (codigo_pedido);
        
/*3. Usa las vistas que has creado en los pasos anteriores para devolver un listado de
los clientes de la ciudad de Madrid que han realizado pagos.*/
-- mal
CREATE OR REPLACE VIEW clientes_madrid_con_pagos AS
    SELECT 
        *
    FROM
        cliente c
    WHERE
        EXISTS( SELECT 
                *
            FROM
                pago p
            WHERE
                p.codigo_cliente = c.codigo_cliente
                    AND c.ciudad = 'Madrid');
-- bien
SELECT 
	*
FROM
	listado_pagos_clientes lpc
WHERE
	lpc.ciudad = "Madrid";
                    
                    
/*4. Utiliza las vistas que has creado en los pasos anteriores para devolver un listado
de los clientes que todavía no han recibido su pedido.*/

SELECT 
    *
FROM
    listado_pedidos_clientes
WHERE
    fecha_entrega IS NULL;

/*5. Utiliza las vistas que has creado en los pasos anteriores para calcular el número
de pedidos que se ha realizado cada uno de los clientes.*/

-- lo agrupo por telefono aunque no sea identificador de cliente (me faltaria codigo cliente en la vista listado_pedidos_clientes)
-- caso: un telefono puede ser el mismo por dos clientes diferentes, pasa lo mismo con nombre cliente
-- lo he arreglado agrupando por contacto y telefono para mayor identificacion

SELECT 
    COUNT(*)
FROM
    listado_pedidos_clientes
GROUP BY contacto , telefono;

/*6. Usa las vistas que has creado en los pasos anteriores para calcular el valor del
pedido máximo y mínimo que ha realizado cada cliente.*/

SELECT 
    contacto, telefono, MIN(total), MAX(total)
FROM
    listado_pedidos_clientes
GROUP BY contacto , telefono;

/*7. Elimina las vistas que has creado en los pasos anteriores.*/

drop view listado_pedidos_clientes, listado_pagos_clientes;


-- sacar gamas que no esten en productos
select gama, count(*) from producto group by gama;
select g.gama from gama_producto g where not exists (select * from producto p where p.gama = g.gama);
select g.gama from gama_producto g where g.gama not in (select p.gama from producto p);
