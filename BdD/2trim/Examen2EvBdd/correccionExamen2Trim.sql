use Conciertos;
/*
1. Modifica es script de creación de la tabla “Interpreta” para introducir las opciones ante
modificaciones y borrado que consideres. En un comentario debes explicar por qué eliges cada
una. (1 punto).*/

alter table Interpreta modify column id_Concierto on update cascade;


/*
2. Crea las instrucciones SQL para añadir una columna fecha de nacimiento a la tabla Compositor
y para eliminarla posteriormente. La columna no debe admitir nulos y debe tener un valor por
defecto que sea el 1 de enero del año 2000. Elige el tipo de dato que consideres más
adecuado. (1 punto).
*/

alter table Compositor add column fecha_de_nacimiento date;
alter table Compositor drop column fecha_de_nacimiento;

/*
3. Obtén el identificador del concierto y el número de músicos que tocaban el Violonchelo en cada
concierto, ordenados del número más alto al más bajo. (1 punto).
*/

SELECT 
    p.id_concierto, COUNT(p.id_musico) AS cantidad_musicos
FROM
    Participa p
        INNER JOIN
    Concierto c ON p.id_concierto = c.id_concierto
WHERE
    p.id_musico IN (SELECT 
            id_musico
        FROM
            Musico
        WHERE
            id_Instrumento = (SELECT 
                    id_Instrumento
                FROM
                    Instrumento
                WHERE
                    nombre = 'Violonchelo'))
GROUP BY p.id_concierto
ORDER BY cantidad_musicos DESC;

/*
4. Crea una consulta SQL en la que se muestren los músicos que tocan en conciertos en los que
se interpretan obras que han compuesto ellos mismos. Ten en cuenta que su identificador
como compositor y como músico no tienen por qué ser el mismo. (1 punto).
*/

SELECT 
    c.nombre
FROM
    Compositor c
WHERE
    c.nombre in (select nombre from Musico inner join Participa p on id_musico = p.id_musico and p.id_Concierto = (select );

-- 5. Obtén las obras que nunca han sido representadas. (1 punto).

select o.nombre from Obra o left join Interpreta i on o.id_obra = i.id_obra where i.id_concierto is null;

/*
6. Obtén el nombre y apellido de los compositores que no hayan creado obras que empiecen por
C, M o S. (1 punto).
*/

SELECT 
    distinct(c.nombre), c.apellido
FROM
    Compositor c
        INNER JOIN
    Obra o ON c.id_compositor = o.id_compositor
WHERE
    o.nombre NOT LIKE 'C%'
        AND o.nombre NOT LIKE 'M%'
        AND o.nombre NOT LIKE 'S%';
        

/*
7. Obtén el nombre y apellido del compositor de la obra más reciente. No puedes usar LIMIT. (2
puntos).*/
SELECT fecha from Concierto;
SELECT 
    c.nombre, c.apellido
FROM
    Compositor c
WHERE
    c.id_compositor in (SELECT 
            id_compositor
        FROM
            Obra o
                INNER JOIN
            Interpreta i ON o.id_Obra = i.id_Obra
        WHERE
            c.id_compositor = id_compositor
                AND i.id_concierto = (SELECT 
                    id_concierto
                FROM
                    Concierto
                WHERE
                    fecha = (SELECT 
                            max(fecha)
                        FROM
                            Concierto)));


/*
8. Obtén el nombre y apellido del compositor cuyas obras se hayan representado en más
conciertos. Se preferirá una solución que no utilice LIMIT. (2 puntos). */

SELECT 
    c.nombre, c.apellido
FROM
    Compositor c
        INNER JOIN
    Obra o ON c.id_compositor = o.id_compositor
WHERE
id_Obra in (select max(count(*)) from Interpreta group by id_Concierto);
