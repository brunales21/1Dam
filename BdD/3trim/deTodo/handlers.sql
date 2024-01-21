-- ej inventado
-- Procedimiento llamado listar_productos que recibe como entrada el nombre de una
-- gama y muestre un listado de todos los productos que existen dentro de esa gama.
use jardineria;

delimiter $$
drop procedure if exists listar_productos$$
create procedure listar_productos(in gama varchar (30))
begin
	
    if not exists (select * from producto p where p.gama = gama) then
		signal sqlstate '45000'
            set message_text = 'Esta gama no existe.';
	end if;
	select * from producto p where p.gama = gama;
end $$
delimiter ;

select * from producto;
call listar_productos('erramientas');

SHOW PROCEDURE STATUS;

delimiter $$
drop procedure if exists contarProductos$$
create procedure contarProductos(in gama varchar(30))
begin
	select count(*) from producto p where p.gama = gama;
end $$
delimiter ;


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
drop procedure insertDepartamento;

delimiter $$
create procedure insertDepartamento(in inid int unsigned, in innombre_departamento varchar(30), in inid_director int unsigned, in inid_localizacion int unsigned)
begin

	declare exit handler for 1062
    begin
		resignal
			SET MESSAGE_TEXT = 'El departamento con el ID especificado ya existe.';
    end;
    declare exit handler for 1452
    begin
		resignal
			set message_text = 'El ID de la localización no existe';
    end;
    
    if exists (select * from departamento where innombre_departamento = nombre_departamento) then
		signal sqlstate '45000'
			set message_text = 'Ya existe un departamento con este nombre.';
	end if;
    if exists (select * from departamento where inid_director = id_director) then
		signal sqlstate '45000'
			set message_text = 'Ya existe un departamento con este director.';
	end if;
    
	INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion) VALUES (inid, innombre_departamento, inid_director, inid_localizacion);
    
    IF ROW_COUNT() = 0 THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'No se ha podido insertar con éxito.';
		END IF;
end$$
delimiter ;

call insertDepartamento(100, 'Ejecutivo4', 102, 3000);
select * from departamento;



/*4. Realiza un procedimiento para modificar el salario de un empleado. Se recibirá
el identificador del empleado y el nuevo salario.
¿Qué sucede si nos pasan un tipo de dato incorrecto en el salario? ¿es necesario
controlarlo dentro del procedimiento?
¿Puedes establecer un control de errores si el identificador de empleado no existe? La función ROW_COUNT() te permite saber el número de filas afectadas por
la última operación (distinta de SELECT).*/
delimiter $$
drop procedure if exists setSalario;
create procedure setSalario(in id int unsigned, in nuevoSalario decimal(10,2))
begin

	if nuevoSalario < 0 then 
		signal sqlstate '45000'
			set message_text = 'Este parametro no puede ser negativo';
            
	end if;
	if not exists (select * from empleado where id_empleado = id) then 
		signal sqlstate '45000'
			set message_text = 'Este identificador de empleado no existe';
	end if;
	update empleado set salario = nuevoSalario where id_empleado = id;
    if row_count() = 0 then
		signal sqlstate '45000'
			set message_text = 'No se ha podido actualizar con éxito.';
	end if;
end$$
delimiter ;

call setSalario(100, -5000);
select * from empleado;
/*5. Establece control de errores en el ejercicio 14.2.2. Controla que los parámetros
que nos pasan tengan valores válidos y lanza un mensaje en caso contrario.*/
/*
2. Realiza un procedimiento que reciba dos parámetros, uno con un número del
uno al siete (día de la semana) y otro con un número del uno al doce (mes del
año). Luego con estos dos datos debe componer un cadena que tenga la forma
como ”Un miércoles de marzo” si los valores de los parámetros fueran tres y tres
respectivamente.*/

delimiter $$
drop procedure if exists getDia$$
create procedure getDia(in n1 int, in n2 int)
begin
declare dia, mes varchar(15);

if (n1 < 1 or n1 > 7) or (n2 < 1 or n1 > 12) then
	signal sqlstate '45000'
		set message_text = 'Los valores deben de estar entre 1-7 en caso del primero y 1-12 en caso del segundo.';
end if;
	CASE n1
        WHEN 1 THEN SET dia = 'Lunes';
        WHEN 2 THEN SET dia = 'Martes';
        WHEN 3 THEN SET dia = 'Miércoles';
        WHEN 4 THEN SET dia = 'Jueves';
        WHEN 5 THEN SET dia = 'Viernes';
        WHEN 6 THEN SET dia = 'Sábado';
        WHEN 7 THEN SET dia = 'Domingo';
        ELSE SET dia = 'Error: Día no válido';
    END CASE;
    
    CASE n2
        WHEN 1 THEN SET mes = 'Enero';
        WHEN 2 THEN SET mes = 'Febrero';
        WHEN 3 THEN SET mes = 'Marzo';
        WHEN 4 THEN SET mes = 'Abril';
        WHEN 5 THEN SET mes = 'Mayo';
        WHEN 6 THEN SET mes = 'Junio';
        WHEN 7 THEN SET mes = 'Julio';
        WHEN 8 THEN SET mes = 'Agosto';
        WHEN 9 THEN SET mes = 'Septiembre';
        WHEN 10 THEN SET mes = 'Octubre';
        WHEN 11 THEN SET mes = 'Noviembre';
        WHEN 12 THEN SET mes = 'Diciembre';
        ELSE SET mes = 'Error: Mes no válido';
    END CASE;
    
    SELECT CONCAT('Un ', dia, ' de ', mes) AS resultado;
end$$
delimiter ;

call getDia(4, 0);
	
select * from departamento;

/*6. Crea un procedimiento para introducir un nuevo departamento en la tabla departamento
de la BdD empleados. Ten en cuenta los posibles errores que puedan producirse
en la inserción y utiliza RESIGNAL para enviar un mensaje adecuado en español
en cada caso*/
delimiter $$
drop procedure if exists insertDepartamento$$
create procedure insertDepartamento(in in_id_departamento int unsigned, in nombre_departamento_in varchar(30), in in_id_director int unsigned, in in_id_localizacion int unsigned)
begin
	declare exit handler for 1062
    begin
		resignal
		set message_text = 'Esta clave de departamento ya existe.';
	end;
    
	declare exit handler for 1452
    begin
		resignal
		set message_text = 'Este id no existe';
	end;
    
        
	if exists (select * from departamento where id_director = in_id_director) then
		signal sqlstate '45000'
			set message_text = 'ya existe un departamento con este director';
    end if;
    
    if exists (select * from departamento where nombre_departamento = nombre_departamento_in) then
		signal sqlstate '45000'
			set message_text = 'Este nombre de departamento ya existe.';
    end if;
    
    INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion) values (in_id_departamento, nombre_departamento_in, in_id_director, in_id_localizacion);
    
    if row_count() = 0 then
		signal sqlstate '45000'
		set message_text = 'No se pudo realizar la insercción.';
	end if;

end$$
delimiter ;

call insertDepartamento(11, 'departamento1', 104, 3000);
delete from departamento where nombre_departamento = 'Ventas4';
select * from departamento;
select * from localizacion;
select * from empleado;


DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarDepartamento2;
CREATE PROCEDURE InsertarDepartamento2(IN id_departamento INT, IN nombre_departamento VARCHAR(30), IN id_director INT, IN id_localizacion INT)

	BEGIN

		DECLARE EXIT HANDLER FOR 1062
		  BEGIN
			RESIGNAL
			  SET MESSAGE_TEXT = 'El departamento con el ID especificado ya existe.';
		  END;
		  
		DECLARE EXIT HANDLER FOR 1452
		  BEGIN
			RESIGNAL
			  SET MESSAGE_TEXT = 'La ID de la localización no existe.';
		  END;

		IF EXISTS (SELECT * FROM departamento P WHERE P.nombre_departamento = nombre_departamento) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Ya existe un departamento con este nombre.';
		END IF;
        
        IF EXISTS (SELECT * FROM departamento P WHERE P.id_director = id_director) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Ya existe un departamento con este director.';
		END IF;
        
		INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion) VALUES (id_departamento, nombre_departamento, id_director, id_localizacion);
        
        IF ROW_COUNT() = 0 THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'No se ha podido insertar con éxito.';
		END IF;

	END$$
DELIMITER ;

SELECT * FROM departamento;
select * from localizacion;
CALL InsertarDepartamento2(130, "NuevasVentas4", 204, 1000);

-- otro ejercicio inventaddo

delimiter $$
drop procedure if exists dividirProcedure$$
create procedure dividirProcedure(in a int, in b int, out c int)

begin
	if b = 0 then
		signal sqlstate '45000'
			set message_text = 'No se puede dividir entre cero, subnormal.';
	end if;
	set c = a/b;
end $$
delimiter ;

call dividirProcedure(8, 2, @resultado);
select @resultado;

delimiter $$
drop function if exists dividirFunction$$
create function dividirFunction(a int, b int)

returns int
contains sql
deterministic

begin
	declare c int default 0;
	if b = 0 then
		begin
			signal sqlstate '45000'
				set message_text = 'No se puede dividirProcedure entre cero, subnormal.';
		end;
	end if;
	set c = a/b;
    return c;

end $$
delimiter ;

set @result = dividirFunction(6,0);
select @result;

-- 14.5
-- 2
drop database if exists test;
create database test;
use test;
create table alumno(
	id int unsigned primary key,
    nombre varchar(20),
    apellido1 varchar(20),
    apellido2 varchar(20)
);

delimiter $$
drop procedure if exists insertarAlumno$$
create procedure insertarAlumno(in id int unsigned, in nombre varchar(20) , in apellido1 varchar(20), in apellido2 varchar(20), out funciona int)
begin

    declare exit handler for 1062
    BEGIN
		set funciona = 1;
		RESIGNAL
		  SET MESSAGE_TEXT = 'Id duplicado.';
	END;
    
	insert into alumno values (id, nombre, apellido1, apellido2);
    
	if row_count() = 1 then
		set funciona = 0;
	end if;
end $$
delimiter ;

call insertarAlumno(70, 'pepe', 'papa', 'pipi', @salida);
select @salida;
select * from alumno;


