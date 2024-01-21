use EmpresaX;

CREATE VIEW salarios (salario , nEmpleados) AS
    SELECT 
        e.salario, COUNT(e.id_empleado)
    FROM
        empleado e
    GROUP BY e.salario;
    
select nEmpleados from salarios;

drop view salarios;


-- no se puede realizar operaciones dml sobre vistas
update salarios set nEmpleados = 5 where nEmpleados = 12;