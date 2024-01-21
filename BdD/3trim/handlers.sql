create database prueba_handlers;
use prueba_handlers;
create table ProveedorProducto(
	proveedorId int unsigned,
    productoId int unsigned,
    primary key(proveedorId, productoId)
);

delimiter $$
CREATE PROCEDURE InsertProveedorProducto(
IN inproveedorId INT,
IN inProductoId INT
)
BEGIN
	-- sale si hay una clave duplicada.
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	SELECT 'SQLEXCEPTION' Mensaje;
	DECLARE EXIT HANDLER FOR 1062
	SELECT 'Código MySQL' Mensaje;
	DECLARE EXIT HANDLER FOR SQLSTATE '23000'
	SELECT 'SQLSTATE' Mensaje;

    
	INSERT INTO ProveedorProducto(proveedorId,productoId)
	VALUES(inproveedorId,inProductoId);
	SELECT 
		COUNT(*)
	FROM
		ProveedorProducto
	WHERE
		proveedorId = inproveedorId;
END$$
delimiter ;
-- se aplica el handler 1062 ya que es el codigo de clave duplicada

call InsertProveedorProducto(1, 1);
call InsertProveedorProducto(1, 1);

select * from ProveedorProducto;

/*2. Crea una base de datos llamada test que contenga una tabla llamada alumno.
La tabla debe tener cuatro columnas:
id: entero sin signo (clave primaria).
nombre: cadena de 50 caracteres.
apellido1: cadena de 50 caracteres.
apellido2: cadena de 50 caracteres.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado
insertar_alumno con las siguientes características:
Recibirá cuatro parámetros de entrada (id, nombre, apellido1, apellido2) y los
insertará en la tabla alumno.
Devolverá como salida un parámetro llamado error que tendrá un valor igual
a 0 si la operación se ha podido realizar con éxito y un valor igual a 1 en caso
contrario.
Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una
fila que contiene una clave primaria repetida.
*/

drop database test;
create database test;
use test;

create table alumno(
	id int unsigned primary key,
    nombre varchar(20),
    apellido1 varchar(50),
    apellido2 varchar(50)
);

delimiter $$


create procedure insertar_alumno(in id int unsigned, in nombre varchar(20), in apellido1 varchar(50), in apellido2 varchar(50),
out resultado boolean)
begin
    DECLARE resultado_temp BOOLEAN DEFAULT 1;
	DECLARE EXIT HANDLER FOR 1062
    begin
		set resultado_temp = 0;
		SELECT 'Código MySQL' Mensaje;
    end;
    
    insert into alumno values (id, nombre, apellido1, apellido2);
	set resultado = resultado_temp;
    
end$$
delimiter ;

SET @resultado = NULL; -- Declarar una variable para almacenar el resultado

CALL insertar_alumno(123, 'John', 'Doe', 'Smith', @resultado); -- Llamar al procedimiento
CALL insertar_alumno(123, 'John', 'Doe', 'Smith', @resultado); -- Llamar al procedimiento


SELECT @resultado; -- Mostrar el resultado almacenado en la variable

/*3. Escribe un procedimiento que inserte un nuevo departamento con los parámetros
que se reciban, incluido el id.
¿Qué errores pueden darse al realizar la operación?
Introduce gestión de errores para controlarlos, decidiéndo qué hacer en cada caso
*/

use EmpresaX;
describe departamento;

delimiter $$
drop procedure insertDepartamento;
create procedure insertDepartamento(in id int unsigned, in nombre_departamento varchar(30), in id_director int unsigned, in id_localizacion int unsigned)
begin

	declare exit handler for sqlexception
    SET MESSAGE_TEXT = 'El departamento con el ID especificado ya existe.';
	SELECT 'Código MySQL' Mensaje;

	insert into departamento values(id, nombre_departamento, id_director, id_localizacion);
end$$
delimiter ;

call insertDepartamento(3, 'Department x', 100, 4100);
select * from departamento;











