/*
Ejercicios 9.1
1 Devuelve el nombre, apellido y nombre de departamento de todos los empleados con todas las sintaxis
vistas para el INNER JOIN incluyendo el NATURAL JOIN.
2 Devuelve el nombre de todos los departamentos que se encuentren en EstadosUnidos.
3 Selecciona todos los empleados que pertenezcan al departamento ejecutivo o al
de administración.
4 Selecciona los empleados con un salario que no esté entre los límites establecidos
para su trabajo.
*/
-- 1
select e.nombre, e.apellido, d.nombre_departamento from empleado e, departamento d where e.id_departamento = d.id_departamento;
select e.nombre, e.apellido, d.nombre_departamento from empleado e inner join departamento d on e.id_departamento = d.id_departamento;
select e.nombre, e.apellido, d.nombre_departamento from empleado e inner join departamento d using(id_departamento);
-- 2
select d.nombre_departamento, l.ciudad
from departamento d inner join localizacion l on d.id_localizacion = l.id_localizacion where l.id_pais = "US";
-- 3
select e.nombre, d.nombre_departamento
from empleado e inner join departamento d on e.id_departamento = d.id_departamento
where d.nombre_departamento = "Ejecutivo" or d.nombre_departamento = "Administración";

select e.nombre, d.nombre_departamento
from empleado e, departamento d where e.id_departamento = d.id_departamento;

-- 4
select e.nombre, e.salario, t.min_salario, t.max_salario
from empleado e inner join trabajo t on e.id_trabajo = t.id_trabajo 
where e.salario < t.min_salario or e.salario > t.max_salario;