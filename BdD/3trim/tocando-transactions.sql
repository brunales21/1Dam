use EmpresaX;
-- notas:
-- si retiro dinero a un empleado que no existe, no da ningun fallo.
-- si retiro a empleado x€ y tiene x-5€, da fallo.
select * from empleado;
update empleado e set e.salario = e.salario-100 where e.id_empleado = 1056750;

start transaction;
update empleado e set e.salario = e.salario-1000 where e.id_empleado = 100;
update empleado a set a.salario = a.salario+1000 where a.id_empleado = 101;
select id_empleado, salario from empleado where id_empleado in ('100', '101');
commit;

select id_empleado, salario from empleado where id_empleado in ('100', '101');

update empleado e set e.salario = 11000 where e.id_empleado = 100;
update empleado a set a.salario = 21000 where a.id_empleado = 101;

set autocommit = 0;
update empleado set salario = 5 where id_empleado = 100;

select * from empleado where id_empleado = 100;
rollback;

select * from empleado where id_empleado = 100;


update empleado set salario = -500000 where id_empleado = 100;

