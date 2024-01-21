create database prueba;
use prueba;
create table mascota(
	id_mascota int unsigned primary key,
    nombre varchar(30), 
    edad smallint
);

INSERT INTO mascota (id_mascota, nombre, edad) VALUES (1, 'Luna', 2);
INSERT INTO mascota (id_mascota, nombre, edad) VALUES (2, 'Max', 5);
INSERT INTO mascota (id_mascota, nombre, edad) VALUES (3, 'Bella', 3);
rollback;
select * from mascota;
/*
Realiza los ejercicios sobre una base de datos prueba, que luego elimines.
1. Crea una tabla mascotas que lleve id_mascota (INT), nombre (VARCHAR(30)),
edad (SMALLINT).
Añade tres mascotas (ids 1, 2 y 3) a la tabla y comprueba que se han insertado.
Deshaz las inserciones con ROLLBACK. ¿Están las mascotas todavía en la tabla?
¿por qué?
Repite las operaciones de este ejercicio de tal forma que al realizar el ROLLBACK
las mascotas no aparezcan en nuestra tabla.
2. Justo a continuación de las operaciones del ejercicio anterior, ejecuta las siguientes operaciones:

¿se realiza el ROLLBACK? ¿por qué? ¿qué dos opciones hay para solucionarlo?
no se realiza el rollback porque estas sentencias no estan englobadas en una transaccion y ademas el autocommit está activado*/

INSERT INTO mascota (id_mascota, nombre, edad)
VALUES (5, 'Micifú', 8);
ROLLBACK;
SELECT * FROM mascota;


set autocommit = 1;

SET AUTOCOMMIT=0;
INSERT INTO mascota (id_mascota, nombre, edad)
VALUES (8, 'Calcetines', 6);
CREATE TABLE lista (id INT);
INSERT INTO lista (id) VALUES (1);
SELECT * FROM lista;
ROLLBACK;

delete from mascota where id_mascota = 8;
commit;
drop table lista;


SET AUTOCOMMIT=0;
INSERT INTO mascota (id_mascota, nombre, edad)
VALUES (10, 'Un nombre demasiado largo para mascotas', 2);
-- Actalizamos una tupla inexistente
UPDATE mascota SET nombre = 'Fantasma'
WHERE id_mascota = 333;
-- Borramos una tupla inexistente
DELETE FROM mascota WHERE id_mascota = 444;
-- Insertamos con el id que usamos antes.
INSERT INTO mascota (id_mascota, nombre, edad)
VALUES (10, 'Yummy', 3);
-- Desbordamos el vampo edad
INSERT INTO mascota (id_mascota, nombre, edad)
VALUES (11, 'Tom', 32769);
-- ¿Sigue activa la transacción
INSERT INTO mascota (id_mascota, nombre, edad)
VALUES (12, 'Peti', 8);
SELECT * FROM mascota;
COMMIT;

DELETE FROM mascota WHERE id_mascota = 10;
DELETE FROM mascota WHERE id_mascota = 11;
DELETE FROM mascota WHERE id_mascota = 12;

