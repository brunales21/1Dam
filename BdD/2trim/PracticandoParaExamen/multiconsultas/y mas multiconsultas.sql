-- 2. Selecciona todos los países de la región 1 y los de la región 4.
-- 3. Selecciona todos los países de América y los de Oriente Medio y África.
-- 4. Selecciona el nombre de los departamentos que tengan más de tres empleados.
-- 5. Selecciona el nombre de los departamentos que tengan más de tres empleados
-- quitando el de aquellos que tengan más de 7;
-- 6. Si has hecho la consulta anterior simulando un MIN hazlo ahora sin usarlo, filtrando solo los grupos.
-- En caso contrario, hazlo simulando un MIN.
use EmpresaX;
-- 2
select p.nombre_pais, r.id_region from pais p, region r where r.id_region = 1 or r.id_region = 4;
select p.nombre_pais, r.id_region from pais p inner join region r on r.id_region = 1 or r.id_region = 4;
-- 3
select p.nombre_pais from pais p where p.id_region = 3 or p.id_region = 2 or p.id_region = 1;
-- 4
select d.nombre_departamento, count(e.id_empleado) as recuento
from departamento d inner join empleado e
on d.id_departamento = e.id_departamento group by d.nombre_departamento
having recuento > 3;
-- 5
select d.nombre_departamento, count(e.id_empleado) as recuento
from departamento d inner join empleado e
on d.id_departamento = e.id_departamento group by d.nombre_departamento having recuento between 3 and 7;
-- 6

