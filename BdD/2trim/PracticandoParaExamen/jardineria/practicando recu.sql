use conciertos;

-- 1. Modifica es script de creación de la tabla “Interpreta” para introducir las opciones ante
-- modificaciones y borrado que consideres. En un comentario debes explicar por qué eliges cada
-- una. (1 punto).
create table Interpreta (
	id_Concierto int not null,
    id_Obra int not null,
    
);
-- 2. Crea las instrucciones SQL para añadir una columna fecha de nacimiento a la tabla Compositor
-- y para eliminarla posteriormente. La columna no debe admitir nulos y debe tener un valor por
-- defecto que sea el 1 de enero del año 2000. Elige el tipo de dato que consideres más
-- adecuado. (1 punto).
alter table Compositor add fecha_de_nacimiento date default '2000-01-01' not null;
alter table Compositor drop fecha_de_nacimiento;
-- 3. Obtén el identificador del concierto y el número de músicos que tocaban el Violonchelo en cada
-- concierto, ordenados del número más alto al más bajo. (1 punto).
select p.id_Concierto, count(p.id_Musico) as cantidad from Participa p where id_Musico in (select id_Musico from Musico where id_Instrumento in (select id_Instrumento from Instrumento where nombre = 'Violonchelo')) group by id_Concierto order by cantidad desc;
-- 4. Crea una consulta SQL en la que se muestren los músicos que tocan en conciertos en los que
-- se interpretan obras que han compuesto ellos mismos. Ten en cuenta que su identificador
-- como compositor y como músico no tienen por qué ser el mismo. (1 punto).

-- forma 1
select * from Musico m where concat(m.nombre, ' ', m.apellido) = any (select concat(c.nombre, ' ', c.apellido) from Compositor c where c.id_Compositor in (select o.id_Compositor from Obra o where o.id_Obra in (select i.id_Obra from Interpreta i where i.id_Concierto in (select co.id_Concierto from Concierto co where co.id_Concierto in (select pa.id_Concierto from participa pa where pa.id_Musico = m.id_Musico)))));
select * from Musico m where concat(m.nombre, ' ', m.apellido) in (select concat(c.nombre, ' ', c.apellido) from Compositor c where c.id_Compositor in (select o.id_Compositor from Obra o where o.id_Obra in (select i.id_Obra from Interpreta i where i.id_Concierto in (select co.id_Concierto from Concierto co where co.id_Concierto in (select pa.id_Concierto from participa pa where pa.id_Musico = m.id_Musico)))));
-- forma 2
select m.* from Musico m inner join Participa p on m.id_Musico = p.id_Musico inner join Concierto co on p.id_Concierto = co.id_concierto inner join Interpreta i on co.id_Concierto = i.id_Concierto inner join Obra ob on i.id_Obra = ob.id_Obra inner join Compositor com on ob.id_Compositor = com.id_Compositor where com.nombre = m.nombre and com.apellido = m.apellido;
-- 5. Obtén las obras que nunca han sido representadas. (1 punto).
select * from Obra o where not exists (select * from Interpreta i where i.id_Obra = o.id_Obra);
select * from Obra o where o.id_Obra not in (select i.id_Obra from Interpreta i);
-- 6. Obtén el nombre y apellido de los compositores que no hayan creado obras que empiecen por
-- C, M o S. (1 punto)
select c.nombre, c.apellido from Compositor c where c.id_Compositor not in (select o.id_Compositor from Obra o where o.nombre like '%C' or o.nombre like '%M' or o.nombre like '%S');

-- 7. Obtén el nombre y apellido del compositor de la obra más reciente. No puedes usar LIMIT. (2
-- puntos).
select c.nombre, c.apellido from Compositor c inner join Obra o on c.id_Compositor = o.id_Compositor where o.anio >= all (select anio from Obra);
select c.nombre, c.apellido from Compositor c inner join Obra o on c.id_Compositor = o.id_Compositor where not exists (select * from Obra where anio > o.anio);
select c.nombre, c.apellido from Compositor c inner join Obra o on c.id_Compositor = o.id_Compositor where o.anio = (select max(anio) from Obra);

-- 8. Obtén el nombre y apellido del compositor cuyas obras se hayan representado en más
-- conciertos. Se preferirá una solución que no utilice LIMIT. (2 puntos).
select c.nombre, c.apellido from Compositor c inner join Obra o on c.id_Compositor = o.id_Compositor where not exists (select * from)
select id_Obra as obra, count(id_Concierto) as veces from Interpreta group by id_Obra
















select * from Compositor c where c.id_Compositor in (select o.id_Compositor from Obra o where (select count(*) from Interpreta i where i.id_Obra = o.id_Obra) >= all (select count(*) from Interpreta group by id_obra));

select id_Obra, count(*), min(id_concierto), max(id_concierto), group_concat(id_Concierto) from Interpreta group by id_Obra order by 2 desc;

select * from Obra o where (select count(*) from Interpreta i where i.id_Obra = o.id_Obra) >= all (select count(*) from Interpreta group by id_obra);

select * from Interpreta group by id_obra having (count(*) = ( select max(cant) from (select count(*) as cant from Interpreta group by id_Obra) tabla))
