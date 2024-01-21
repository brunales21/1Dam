/*
1. Crea una vista que se llame listado_pagos_clientes todos los clientes y los pagos
que ha realizado cada uno de ellos. La vista deberá tener las siguientes columnas:
nombre y apellidos del cliente concatenados, teléfono, ciudad, pais, fecha_pago,
total del pago, id de la transacción.*/
use jardineria;
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
        CONCAT(c.nombre_contacto, c.apellido_contacto),
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

select count(*) from listado_pedidos_clientes group by telefono;

/*6. Usa las vistas que has creado en los pasos anteriores para calcular el valor del
pedido máximo y mínimo que ha realizado cada cliente.*/

SELECT 
    contacto, telefono, MIN(total), MAX(total)
FROM
    listado_pedidos_clientes
GROUP BY contacto , telefono;

/*7. Elimina las vistas que has creado en los pasos anteriores.*/

drop view listado_pedidos_clientes, listado_pagos_clientes;

-- ayudas ajenas para sacar el ej7
-- sacar gamas que no esten en productos
select gama, count(*) from producto group by gama;
select g.gama from gama_producto g where not exists (select * from producto p where p.gama = g.gama);
select g.gama from gama_producto g where g.gama not in (select p.gama from producto p);



use EmpresaX;
-- LOS SIGUIENTES EJERCICIOS SON SOBRE LA BDD EMPLEADOS.

/*8. Repite las operaciones que hiciste con subconsultas en los ejercicios 10.2.3, 10.3.3
y 10.3.6 usando WITH en lugar de una subconsulta.*/

-- 10.2.3
/*Obtén los empleados que tengan como jefe a un director cuyo apellido empiece
por ”C”. Usa IN.*/

with empleados_con_jefe as (
    select e.*, d.nombre as nombre_director 
    from empleado e 
    inner join empleado d on e.id_director = d.id_empleado
)
select * 
from empleados_con_jefe 
where nombre_director like 's%';

select * from empleado e where exists(select * from empleado d where e.id_director = d.id_empleado and d.nombre like 'C%');

-- 10.3.3
-- Obtén el identificador del concierto y el número de músicos que tocaban el Violonchelo en cada concierto, ordenados del número más alto al más bajo.*/
use conciertos;
with lista_cellos as (
	select id_Instrumento from instrumento where nombre = 'Violonchelo'
), 
musicos_cello as (
	select id_Musico from musico where id_Instrumento in (select * from lista_cellos)
)
SELECT 
    p.id_concierto, COUNT(p.id_musico) AS total_cellos
FROM
    participa p
        INNER JOIN
    concierto c ON p.id_concierto = c.id_concierto
        AND p.id_musico IN (SELECT 
            *
        FROM
            musicos_cello)
GROUP BY p.id_concierto
ORDER BY total_cellos DESC;

-- 10.3.6
-- Obtén el nombre y apellido de los compositores que no hayan creado obras que
-- empiecen por C, M o S.'*/
with listado_compositores_obras as (
	select c.nombre as nombre_compositor, c.apellido as apellido_compositor, o.nombre as nombre_obra from compositor c inner join obra o on c.id_compositor = o.id_compositor
)
SELECT 
    nombre_compositor, apellido_compositor
FROM
    listado_compositores_obras
WHERE
    nombre_obra NOT LIKE 'C%'
        AND nombre_obra NOT LIKE 'M%'
        AND nombre_obra NOT LIKE 'S%'
GROUP BY nombre_compositor;

/*9. Repite las operaciones que hiciste con subconsultas en los ejercicios 10.2.6, 10.2.7
y 10.2.8 usando WITH en lugar de una subconsulta.*/
-- 10.2.6
-- Crea una tabla con dirección, código postal, ciudad, provincia, nombre del país y nombre de la región y llénala
-- con los datos de las localizaciones de las regiones Europa y Asia usando una subconsulta.
use EmpresaX;
with europasia as (
	SELECT 
    l.direccion,
    l.codigo_postal,
    l.ciudad,
    l.provincia,
    p.nombre_pais,
    r.nombre_region
FROM
    pais p
        INNER JOIN
    localizacion l ON l.id_pais = p.id_pais
        INNER JOIN
    region r ON p.id_region = r.id_region
WHERE
    r.nombre_region IN ('Europa' , 'Asia')
)
select * from europasia;

-- 10.2.7
-- Actualiza el salario y la comisión de aquellos empleados que tengan comisión. El salario disminuirá en un 10 % y la comisión subirá un 20 %.
-- Ten en cuenta que la comisión ya es un porcentaje por lo que se pide que si un empleado tiene una comisión de 40 % se el incremente hasta el 60 %. Hazlo usando una subconsulta y sin usarla.
-- sin subconsulta
with empleado_con_comision as (
	select * from empleado where comision is not null
)

UPDATE empleado e
SET 
    e.salario = salario * 0.9, e.comision = comision + 0.2
    where exists (select * from empleado_con_comision where id_empleado = e.id_empleado);


-- 10.2.8
-- Elimina los empleados que trabajen en el departamento de Ventas y tengan el puesto de Representante de ventas.
-- Hazlo usando una subconsulta y sin usarla.
with empleado_dep_trabajo as (
	SELECT 
    e.id_empleado,
    d.nombre_departamento AS nombre_departamento,
    t.nombre_trabajo AS nombre_trabajo
FROM
    empleado e
        INNER JOIN
    departamento d ON e.id_departamento = d.id_departamento
        INNER JOIN
    trabajo t ON e.id_trabajo = t.id_trabajo
WHERE
    nombre_departamento = 'Ventas'
        AND nombre_trabajo = 'Representante de ventas'
	
)
delete from empleado e where exists (SELECT 
    *
FROM
    empleado_dep_trabajo


/*10. ¿Puedes realizar los ejercicios 10.2.4 y 10.2.5 usando WITH en lugar de subconsultas? ¿por qué?*/

-- Obtén los empleados cuyo jefe (id_director), no trabaja en el mismo departamento que ellos. Usa EXISTS*/

with empleados_con_jefes as (
	SELECT 
    e.nombre AS nombre_empleado,
    d.nombre AS nombre_director,
    e.id_departamento AS departamento_empleado,
    d.id_departamento AS departamento_director
FROM
    empleado e
        INNER JOIN
    empleado d ON e.id_director = d.id_empleado
)
select nombre_empleado from empleados_con_jefes where departamento_empleado != departamento_director;

-- Selecciona aquellos departamentos en los que su director no trabaja en él. Usa NOT EXISTS.

with listado_directores_departamentos as (
	SELECT 
    d.id_departamento AS id_departamento_que_dirige,
    d.id_director,
    e.id_departamento AS id_departamento_donde_trabaja
FROM
    departamento d
        LEFT JOIN
    empleado e ON d.id_director = e.id_empleado
)
select * from listado_directores_departamentos where id_departamento_que_dirige != id_departamento_donde_trabaja;



-- practicas que ayudaron en la realizacion de este ultimo ejercicio
select * from departamento d where id_director not in (select id_director from empleado);
select * from empleado where id_director not in (select id_director from departamento);

select * from departamento d where exists (select * from empleado e where e.id_departamento = d.id_departamento and e.id_director <> d.id_director);

select e.id_empleado, e.id_director as director_del_empleado, d1.id_departamento, d1.id_director as director_del_departamento 
from empleado e inner join departamento d1 on e.id_departamento = d1.id_departamento 
where exists (select * from departamento d where e.id_departamento = d.id_departamento and e.id_director <> d.id_director)
order by 1;


