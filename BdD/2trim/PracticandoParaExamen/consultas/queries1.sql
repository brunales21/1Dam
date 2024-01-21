/*Ejercicios 8.3
1. Selecciona todos los empleados del departamento 40 ordenador por orden de
lista de apellido.
2. Selecciona todos los empleados del departamento 40 ordenados por salario decreciente y comisión creciente.
3. Repite la consulta anterior evitando los empleados sin comisión.
4. Selecciona los departamentos con identificador del director mayor que 300 y
menor que 600 ordenados de mayor a menor identificador del director.
5. Selecciona el nombre, apellido y salario de los 6 empleados que más cobran.
6. Selecciona el nombre y apellidos de los empleados 3 empleados con sueldos más
bajos de entre los que cobran comisión.
7. Selecciona los 10 empleados más antiguos.
8. Selecciona los 10 empleados más antiguos entre los contratados después del 1
de enero del 2000*/

use EmpresaX;
select e.nombre, e.apellido from empleado e where e.id_departamento = 40 order by e.apellido;
select e.nombre, e.salario from empleado e where e.id_departamento = 40 order by e.salario desc, e.comision asc;
select e.nombre, e.salario from empleado e where e.id_departamento = 40 and e.comision is not null order by e.salario desc, e.comision asc;
select d.nombre_departamento from departamento d where d.id_director between 300 and 600 order by d.id_director desc;
select e.nombre, e.apellido, e.salario from empleado e order by e.salario desc limit 6;
select e.nombre, e.apellido from empleado e order by e.salario and e.comision is not null limit 6;
select e.nombre, e.fecha_contratacion from empleado e where year(e.fecha_contratacion)>2000 order by fecha_contratacion limit 10;

