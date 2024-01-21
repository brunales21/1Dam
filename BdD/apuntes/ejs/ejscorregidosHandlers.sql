/*1. Llama al procedimiento insertando una clave duplicada.
¿cuál de los manejadores se aplica? ¿por qué?*/

CREATE TABLE ProveedorProducto (
proveedorId INT,
productoId INT,
PRIMARY KEY (proveedorId , productoId)
);

DELIMITER $$
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

DELIMITER ;

CALL InsertProveedorProducto(1,1);

/*Se aplica el manejador de MYSQL por una cuestión de precedencia*/

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
fila que contiene una clave primaria repetida.*/

DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS test;
USE test;

CREATE TABLE alumno (
	id INT UNSIGNED PRIMARY KEY,
	nombre VARCHAR(50),
	apellido1 VARCHAR(50),
	apellido2 VARCHAR(50)
);

DELIMITER $$
DROP PROCEDURE IF EXISTS insertar_alumno $$
CREATE PROCEDURE insertar_alumno (IN id INT UNSIGNED, IN nombre VARCHAR(50), IN apellido1 VARCHAR(50), IN apellido2 VARCHAR(50), OUT fallo BOOLEAN)
	BEGIN
		DECLARE CONTINUE HANDLER FOR 1062
			SET fallo = TRUE;
            
		SET fallo = FALSE;
		INSERT INTO alumno (id, nombre, apellido1, apellido2) VALUES (id, nombre, apellido1, apellido2);
        
    END $$
    
DELIMITER ;

CALL insertar_alumno (5, "David", "Ayllón", "Martín", @fallo);
SELECT @fallo;

/*3. Escribe un procedimiento que inserte un nuevo departamento con los parámetros
que se reciban, incluido el id.
¿Qué errores pueden darse al realizar la operación?
Introduce gestión de errores para controlarlos, decidiéndo qué hacer en cada caso.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS InsertarDepartamento;
CREATE PROCEDURE InsertarDepartamento(IN id_departamento INT, IN nombre_departamento VARCHAR(30), IN id_director INT, IN id_localizacion INT)

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

		IF EXISTS (SELECT * FROM departamentos P WHERE P.nombre_departamento = nombre_departamento) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Ya existe un departamento con este nombre.';
		END IF;
        
        IF EXISTS (SELECT * FROM departamentos P WHERE P.id_director = id_director) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Ya existe un departamento con este director.';
		END IF;
        
		INSERT INTO departamentos (id_departamento, nombre_departamento, id_director, id_localizacion) VALUES (id_departamento, nombre_departamento, id_director, id_localizacion);
        
        IF ROW_COUNT() = 0 THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'No se ha podido insertar con éxito.';
		END IF;

	END$$
DELIMITER ;

SELECT * FROM departamentos;

CALL InsertarDepartamento(90, "Ventas2", 101, 999);


/*4. Realiza un procedimiento para modificar el salario de un empleado. Se recibirá
el identificador del empleado y el nuevo salario.
¿Qué sucede si nos pasan un tipo de dato incorrecto en el salario? ¿es necesario
controlarlo dentro del procedimiento?
¿Puedes establecer un control de errores si el identificador de empleado no existe? La función ROW_COUNT() te permite saber el número de filas afectadas por
la última operación (distinta de SELECT).*/

DELIMITER $$
DROP PROCEDURE IF EXISTS modificarSalario $$
CREATE PROCEDURE modificarSalario(IN id INT, IN nuevo_salario DECIMAL(8,2))
BEGIN

  START TRANSACTION;

  IF NOT EXISTS (SELECT * FROM empleados WHERE id_empleado = id) THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Error: No se encontró ningún empleado con el identificador especificado.';
  ELSE
  
	IF nuevo_salario < 0 THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Error: El salario no puede ser negativo.';
	END IF;
    
	UPDATE empleados SET salario = nuevo_salario WHERE id_empleado = id;
    
	IF ROW_COUNT() = 0 THEN
		ROLLBACK;
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Error: No se pudo actualizar.';
	ELSE 
		COMMIT;
	END IF;
    
  END IF;
  
END $$

DELIMITER ;
SELECT * FROM empleados WHERE id_empleado = 100;
CALL modificarSalario(100, 20);


/*5. Establece control de errores en el ejercicio 14.2.2. Controla que los parámetros
que nos pasan tengan valores válidos y lanza un mensaje en caso contrario.*/

DROP PROCEDURE IF EXISTS dias_semana;
DELIMITER $$
CREATE PROCEDURE dias_semana(IN dia INT, IN mes INT, OUT str VARCHAR(100))

 BEGIN
  DECLARE diaStr VARCHAR(15);
  DECLARE mesStr VARCHAR(15);
  
		IF dia < 1 OR dia > 7 THEN
			SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT = 'El día es inválido';
		END IF;

		IF mes < 1 OR mes > 12 THEN
			SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT = 'El mes es inválido';
		END IF;
  
		CASE 
			WHEN dia = 1 THEN SET diaStr = "lunes";
            WHEN dia = 2 THEN SET diaStr = "martes";
            WHEN dia = 3 THEN SET diaStr = "miércoles";
            WHEN dia = 4 THEN SET diaStr = "jueves";
            WHEN dia = 5 THEN SET diaStr = "viernes";
            WHEN dia = 6 THEN SET diaStr = "sábado";
            WHEN dia = 7 THEN SET diaStr = "domingo";
		END CASE;
        
        CASE 
			WHEN mes = 1 THEN SET mesStr = "enero";
            WHEN mes = 2 THEN SET mesStr = "febrero";
            WHEN mes = 3 THEN SET mesStr = "marzo";
            WHEN mes = 4 THEN SET mesStr = "abril";
            WHEN mes = 5 THEN SET mesStr = "mayo";
            WHEN mes = 6 THEN SET mesStr = "junio";
            WHEN mes = 7 THEN SET mesStr = "julio";
            WHEN mes = 8 THEN SET mesStr = "agosto";
            WHEN mes = 9 THEN SET mesStr = "septiembre";
            WHEN mes = 10 THEN SET mesStr = "octubre";
            WHEN mes = 11 THEN SET mesStr = "noviembre";
            WHEN mes = 12 THEN SET mesStr = "diciembre";
		END CASE;
        
        SET str = CONCAT('Un ',diaStr,' de ',mesStr);

 END$$
 DELIMITER ;
 CALL dias_semana(4, 13, @resultado);
 SELECT @resultado;

/*6. Crea un procedimiento para introducir un nuevo departamento en la tabla departamentos
de la BdD empleados. Ten en cuenta los posibles errores que puedan producirse
en la inserción y utiliza RESIGNAL para enviar un mensaje adecuado en español
en cada caso.*/

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

		IF EXISTS (SELECT * FROM departamentos P WHERE P.nombre_departamento = nombre_departamento) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Ya existe un departamento con este nombre.';
		END IF;
        
        IF EXISTS (SELECT * FROM departamentos P WHERE P.id_director = id_director) THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Ya existe un departamento con este director.';
		END IF;
        
		INSERT INTO departamentos (id_departamento, nombre_departamento, id_director, id_localizacion) VALUES (id_departamento, nombre_departamento, id_director, id_localizacion);
        
        IF ROW_COUNT() = 0 THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'No se ha podido insertar con éxito.';
		END IF;

	END$$
DELIMITER ;

SELECT * FROM departamentos;

CALL InsertarDepartamento2(90, "Ventas2", 100, 1000);