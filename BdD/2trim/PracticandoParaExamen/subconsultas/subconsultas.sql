use EmpresaX;

-- selecciono el maximo salario de cada departamento
-- con group by
SELECT 
    d.nombre_departamento, e.nombre, MAX(e.salario)
FROM
    empleado e
        INNER JOIN
    departamento d ON e.id_departamento = d.id_departamento
GROUP BY d.nombre_departamento;

-- sin group by

SELECT 
    d.nombre_departamento, e.salario
FROM
    empleado e
        INNER JOIN
    departamento d ON e.id_departamento = d.id_departamento
WHERE
    e.salario = (SELECT 
            MAX(e2.salario)
        FROM
            empleado e2
        WHERE
            e2.id_departamento = d.id_departamento);

-- nombre del departamento del empleado que mas cobra
SELECT 
    d.nombre_departamento,
    d.id_departamento,
    e.nombre,
    e.salario
FROM
    departamento d
        INNER JOIN
    empleado e ON d.id_departamento = e.id_departamento
WHERE
    e.salario = (SELECT 
            MAX(e2.salario)
        FROM
            empleado e2);
-- Saca solo el id del departamento
SELECT 
    e.id_departamento
FROM
    empleado e
WHERE
    e.salario = (SELECT 
            MAX(e2.salario)
        FROM
            empleado e2);

-- Nombre del departamento con id más alto entre los que tienen empleados.
SELECT 
    d.nombre_departamento, d.id_departamento
FROM
    departamento d
WHERE
    d.id_departamento = (SELECT 
            MAX(d2.id_departamento)
        FROM
            departamento d2);


-- Nombre del departamento del empleado que menos cobra
SELECT 
    d.nombre_departamento, e.nombre, e.salario
FROM
    departamento d
        INNER JOIN
    empleado e ON d.id_departamento = e.id_departamento
WHERE
    e.salario = (SELECT 
            MIN(e2.salario)
        FROM
            empleado e2);



-- Subconsultas de fila.
SELECT 
    nombre, apellido, id_departamento, salario
FROM
    empleado
WHERE
    (id_departamento , salario) = (SELECT 
            MIN(id_departamento), MAX(salario)
        FROM
            empleado);

-- el que mas cobra de cada departamento
SELECT 
    e2.id_departamento, e2.nombre
FROM
    empleado e2
WHERE
    e2.salario = (SELECT 
            MAX(e.salario)
        FROM
            empleado e
        WHERE
            e.id_departamento = e2.id_departamento);
-- con group by (muestra todos)
SELECT 
    e.id_departamento, e.nombre, max(e.salario)
FROM
    empleado e
GROUP BY e.id_departamento, e.nombre;
--
SELECT 
    e.id_departamento, AVG(e.salario)
FROM
    empleado e
GROUP BY e.id_departamento;

/* Empleados que cobran más que el que más cobra de Marketing y
menos que el que menos cobra de Ejecutivo */
SELECT 
    e.nombre
FROM
    empleado e
WHERE
    e.salario BETWEEN (SELECT 
            MAX(e1.salario)
        FROM
            empleado e1
                INNER JOIN
            departamento d ON e1.id_departamento = d.id_departamento
        WHERE
            d.nombre_departamento = 'Marketing') AND (SELECT 
            MIN(salario)
        FROM
            empleado e2
                INNER JOIN
            departamento d2 ON e2.id_departamento = d2.id_departamento
        WHERE
            d2.nombre_departamento = 'Ejecutivo');



-- 1. Selecciona todos los empleados que tenga el departamento de marketing.
-- sin subsconsulta
SELECT 
    *
FROM
    empleado e
        INNER JOIN
    departamento d ON e.id_departamento = d.id_departamento
WHERE
    d.nombre_departamento = 'Marketing';
-- con subconsulta
SELECT 
    *
FROM
    empleado e
WHERE
    e.id_departamento = (SELECT 
            d.id_departamento
        FROM
            departamento d
        WHERE
            d.nombre_departamento = 'Marketing');
-- 2. Selecciona la dirección de la localización con el código postal más alto.
SELECT 
    l.direccion
FROM
    localizacion l
WHERE
    l.codigo_postal = (SELECT 
            MAX(l2.codigo_postal)
        FROM
            localizacion l2);
select * from localizacion order by codigo_postal;
-- 3. Selecciona el nombre del trabajo con mayor diferencia entre el salario más alto y
-- el más bajo.
select t.nombre_trabajo from trabajo t where t.max_salario - t.min_salario = (select max(max_salario - min_salario) from trabajo);
-- 4. Selecciona todos los empleados que tengan como director aquel con id más bajo.
SELECT 
    e.nombre,
    e.id_empleado,
    e.id_director,
    e2.nombre,
    e2.id_empleado
FROM
    empleado e
        INNER JOIN
    empleado e2 ON e.id_director = e2.id_empleado
WHERE
    e.id_director = (SELECT 
            MIN(e3.id_director)
        FROM
            empleado e3);
-- 5. Selecciona todos los empleados que pertenezcan a un departamento con un id
-- mayor que la media.
SELECT 
    e.nombre, e.id_departamento AS media
FROM
    empleado e
WHERE
    e.id_departamento > (SELECT 
            AVG(id_departamento)
        FROM
            departamento);
-- 6. Selecciona el nombre del empleado que más cobra del departamento de ventas.
-- con una subconsulta en la subconsulta
SELECT 
    e.nombre, e.apellido, e.salario
FROM
    empleado e
WHERE
    e.salario = (SELECT 
            MAX(salario)
        FROM
            empleado
        WHERE
            id_departamento = (SELECT 
                    id_departamento
                FROM
                    departamento
                WHERE
                    nombre_departamento = 'Ventas'));
-- 7. Selecciona el nombre del departamento al que pertenezca el empleado con id
-- más alto.
SELECT 
    d.nombre_departamento, e.nombre, e.id_empleado
FROM
    departamento d
        INNER JOIN
    empleado e ON d.id_departamento = e.id_departamento
WHERE
    e.id_empleado = (SELECT 
            MAX(id_empleado)
        FROM
            empleado);
-- 8. Devuelve el nombre del departamento al que pertenece el empleado que más cobra

-- con una subconsulta en la subconsulta
SELECT 
    d.nombre_departamento
FROM
    departamento d
WHERE
    d.id_departamento = (SELECT 
            id_departamento
        FROM
            empleado
        WHERE
            salario = (SELECT 
                    MAX(salario)
                FROM
                    empleado));
-- con inner join
SELECT 
    d.nombre_departamento, e.nombre
FROM
    departamento d
        INNER JOIN
    empleado e ON d.id_departamento = e.id_departamento
WHERE
    e.salario = (SELECT 
            MAX(salario)
        FROM
            empleado);
-- 9. Devuelve la dirección y la ciudad de las localizaciones en las que haya al menos
-- dos departamentos.
SELECT 
    l.id_localizacion, d.id_departamento
FROM
    localizacion l
        INNER JOIN
    departamento d ON l.id_localizacion = d.id_localizacion
GROUP BY id_localizacion
HAVING COUNT(d.id_departamento) > 2;

-- una pruebita

SELECT 
    id_localizacion, COUNT(id_departamento)
FROM
    localizacion
        INNER JOIN
    departamento USING (id_localizacion)
GROUP BY id_localizacion;

-- 10. Devuelve la dirección, la ciudad y el nombre del país de las localizaciones en las
-- que haya al menos dos departamentos.

SELECT 
    l.direccion, l.ciudad, p.nombre_pais
FROM
    localizacion l
        INNER JOIN
    departamento d ON l.id_localizacion = d.id_localizacion
        INNER JOIN
    pais p ON l.id_pais = p.id_pais
GROUP BY l.id_localizacion
HAVING COUNT(d.id_departamento) > 2;



-- 11. Devuelve el identificador de los departamentos cuya media de salarios sea mayor
-- que la media de salarios de la empresa.
SELECT 
    d.id_departamento
FROM
    departamento d
        INNER JOIN
    empleado e ON d.id_departamento = e.id_departamento
GROUP BY d.id_departamento
HAVING AVG(e.salario) > (SELECT 
        AVG(salario)
    FROM
        empleado);
-- 12. Devuelve el nombre de los departamentos cuya media de salarios sea mayor que
-- la media de salarios de la empresa.
SELECT 
    d.nombre_departamento
FROM
    departamento d
        INNER JOIN
    empleado e ON d.id_departamento = e.id_departamento
GROUP BY d.id_departamento
HAVING AVG(e.salario) > (SELECT 
        AVG(salario)
    FROM
        empleado);
-- 13. Obtén todos los empleados con salarios entre el máximo y el mínimo para el
-- trabajo IT_PROG.
SELECT 
    *
FROM
    empleado e
WHERE
    e.salario BETWEEN (SELECT 
            min_salario
        FROM
            trabajo
        WHERE
            id_trabajo = 'IT_PROG') AND (SELECT 
            max_salario
        FROM
            trabajo
        WHERE
            id_trabajo = 'IT_PROG');

