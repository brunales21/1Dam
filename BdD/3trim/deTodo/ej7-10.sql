use EmpresaX;
-- LOS SIGUIENTES EJERCICIOS SON SOBRE LA BDD EMPLEADOS.

/*8. Repite las operaciones que hiciste con subconsultas en los ejercicios 10.2.3, 10.3.3
y 10.3.6 usando WITH en lugar de una subconsulta.*/

-- 10.2.3
/*Obtén los empleados que tengan como jefe a un director cuyo apellido empiece
por ”C”. Usa IN.
*/
with empleados_con_jefe as (
    select e.nombre as nombre_empleado, d.nombre as nombre_director 
    from empleado e 
    inner join empleado d on e.id_director = d.id_empleado
)
select nombre_empleado 
from empleados_con_jefe 
where nombre_director like 'C%';

-- 10.3.3
/*3. Obtén el identificador del concierto y el número de músicos que tocaban el Violonchelo en cada concierto, ordenados del número más alto al más bajo.*/
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
/*6. Obtén el nombre y apellido de los compositores que no hayan creado obras que
empiecen por C, M o S.'*/
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

-- 4. Obtén los empleados cuyo jefe (id_director), no trabaja en el mismo departamento que ellos. Usa EXISTS*/

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

-- 5. Selecciona aquellos departamentos en los que su director no trabaja en él. Usa NOT EXISTS.

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


