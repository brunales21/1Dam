use EmpresaX;
select * from categoria_prof;
-- 1. Encuentra los empleados que ganan más que el salario máximo de su categoría profesional.
SELECT 
    e.nombre, e.apellido
FROM
    empleado e
WHERE
    e.salario > ALL (SELECT 
            t.max_salario
        FROM
            trabajo t
        WHERE
            t.id_trabajo = e.id_trabajo);

-- 1. Selecciona la localización con el código postal más alto. Haz la consulta de, al menos, dos formas diferentes. (ALL y MAX).
-- MAX
SELECT 
    l.direccion, l.codigo_postal
FROM
    localizacion l
WHERE
    l.codigo_postal = (SELECT 
            MAX(codigo_postal)
        FROM
            localizacion);
            
-- ALL
SELECT 
    l.direccion, l.codigo_postal
FROM
    localizacion l
WHERE
    l.codigo_postal >= ALL (SELECT 
            codigo_postal
        FROM
            localizacion);

-- 2. Selecciona las localizaciones en las que haya algún departamento usando ANY. ¿Puedes hacerlo sin subconsultas?.
SELECT 
    l.id_localizacion
FROM
    localizacion l
WHERE
    l.id_localizacion = ANY (SELECT 
            id_localizacion
        FROM
            departamento
        WHERE
            id_localizacion = l.id_localizacion);
-- 3. Obtén los empleados que tengan como jefe a un director cuyo apellido empiece por ”C”. Usa IN.
SELECT 
    e.nombre
FROM
    empleado e
WHERE
    e.id_director IN (SELECT 
            d.id_empleado
        FROM
            empleado d
        WHERE
            d.apellido LIKE 'C%');

-- 4. Obtén los empleados cuyo jefe, no trabaja en el mismo departamento que ellos. Usa EXISTS.
SELECT 
    e.nombre
FROM
    empleado e
WHERE
    EXISTS( SELECT 
            d.id_empleado
        FROM
            empleado d
        WHERE
            d.id_empleado = e.id_director
                AND e.id_departamento != d.id_departamento);
-- 5. Selecciona aquellos departamentos en los que su director no trabaja en él. Usa NOT EXISTS.
SELECT 
    d.id_departamento
FROM
    departamento d
WHERE
    NOT EXISTS( SELECT 
            dir.id_empleado
        FROM
            empleado dir
                INNER JOIN
            empleado e ON dir.id_empleado = e.id_director
        WHERE
            dir.id_departamento = d.id_departamento);
-- 6. Crea una tabla con dirección, código postal, ciudad, provincia, nombre del país y nombre de la región y llénala con los datos de las localizaciones de las regiones Europa y Asia usando una subconsulta.
create table eurasia (
	direccion varchar(40),
    codigo_postal varchar(15),
    ciudad varchar(25), 
    provincia varchar(25),
    nombre_pais varchar(25), 
    nombre_region varchar(20)
);

insert into eurasia(direccion, codigo_postal, ciudad, provincia, nombre_pais, nombre_region)

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
    localizacion l ON p.id_pais = l.id_pais
        INNER JOIN
    region r ON p.id_region = r.id_region
WHERE
    r.nombre_region IN ('Europa' , 'Asia');
-- subconsulta forzadisima

select * from eurasia;
-- 7. Actualiza el salario y la comisión de aquellos empleados que tengan comisión. El salario disminuirá en un 10 % y la comisión subirá un 20 %.
-- Ten en cuenta que la comisión ya es un porcentaje por lo que se pide que si un empleado tiene una comisión de 40 % se el incremente hasta el 60 %. Hazlo usando una subconsulta y sin usarla.
-- sin subconsulta
UPDATE empleado e 
SET 
    salario = salario * 0.9
        AND comision = comision + 0.2
WHERE e.comision IS NOT NULL;

-- con subconsulta
UPDATE empleado e 
SET 
    salario = salario * 0.9
        AND comision = comision + 0.2
WHERE exists (select comision from empleado where id_empleado = e.id_empleado);


-- 8. Elimina los empleados que trabajen en el departamento de Ventas y tengan el puesto de Representante de ventas. Hazlo usando una subconsulta y sin usarla.
DELETE FROM empleado
WHERE
    id_departamento = (SELECT 
        id_departamento
    FROM
        departamento
    WHERE
        nombre_departamento = 'Ventas')
        AND id_trabajo = (SELECT 
            id_trabajo
        FROM
            trabajo
        WHERE
            nombre_trabajo = ('Representante de ventas'));

-- empleados que trabajan de Representante de ventas (para ver el antes y despues del delete)
SELECT 
    e.nombre, e.apellido, t.nombre_trabajo
FROM
    empleado e
    inner join trabajo t on e.id_trabajo = t.id_trabajo
WHERE
    e.id_departamento = (SELECT 
            id_departamento
        FROM
            departamento
        WHERE
            nombre_departamento = 'Ventas')
        AND e.id_trabajo = (SELECT 
            id_trabajo
        FROM
            trabajo
        WHERE
            nombre_trabajo = 'Representante de ventas');
