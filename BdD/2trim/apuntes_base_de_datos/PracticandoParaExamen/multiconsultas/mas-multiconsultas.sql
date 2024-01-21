/*
Ejercicios 9.3
1. Obtén la ciudad y el código postal donde trabaja María González.
2. Obtén la ciudad y el código postal donde trabajan los empleados cuyo nombre
empiece por M.
3. Selecciona el nombre del trabajo, nombre del departamento en el que lo ejerció,
la fecha en la que empezó y la fecha en la que terminó para todos los trabajos
anteriores que haya tenido Sara James en la empresa.
4. Selecciona los datos de todos los empleados cuya directora sea Maya Van Pobel.
5. Obtén el nombre y el apellido del director de departamento en el que trabaja
Indira Virma.
*/

-- 1
select e.nombre, e.apellido, l.ciudad, l.codigo_postal
from  departamento d inner join localizacion l
on d.id_localizacion = l.id_localizacion
inner join empleado e
on d.id_departamento = e.id_departamento
where e.nombre = "María" and e.apellido = "González";
-- 2
select e.nombre, e.apellido, l.ciudad, l.codigo_postal
from  departamento d inner join localizacion l
on d.id_localizacion = l.id_localizacion
inner join empleado e
on d.id_departamento = e.id_departamento
where e.nombre like "M%";
-- 3
select t.nombre_trabajo, d.nombre_departamento, h.fecha_inicio, h.fecha_fin
from empleado e inner join trabajo t on e.id_trabajo = t.id_trabajo
inner join departamento d on e.id_departamento = d.id_departamento inner join historial_trab h on e.id_empleado = h.id_empleado;

-- 4
select e.nombre, e.id_empleado, e.id_director, e2.nombre, e2.id_empleado, e2.id_director
from empleado e inner join empleado e2 on e.id_director = e2.id_empleado;

select e.nombre, e.id_empleado, e.id_director, e2.nombre, e2.id_empleado, e2.id_director
from empleado e inner join empleado e2 on e.id_director = e2.id_empleado where e2.nombre = "Maya";

select * from empleado e inner join empleado e2 on e.id_director = e2.id_empleado;

-- 5
select dir.nombre, dir.apellido, em.nombre, em.apellido
from empleado dir inner join empleado em
on dir.id_empleado = em.id_director where em.nombre = "Indira" and em.apellido = "Virma";