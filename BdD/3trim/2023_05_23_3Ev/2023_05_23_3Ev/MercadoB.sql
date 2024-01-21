/*
1. Crea una vista que se llame  sobre la tabla pokemon que coja todos los
datos de aquellos pokemon cuyo método de evolución sea 'Piedra fuego'. (0,75 punto).*/

create or replace view info_basica_pokemon as
	select * from pokemon where metodo_evolucion = 'Piedra fuego';
    
select * from info_basica_pokemon;

/*
2. Sobre la vista info_basica_pokemon, inserta un nuevo pokemon que te inventes.
Selecciona todo lo que hay en la vista. ¿Aparece el pokemon que has insertado? ¿por qué?
(0,75 punto).*/

insert into info_basica_pokemon values (1000, 'Pepe', 'le llaman pepele', 10.1, 1.50, 'Piedra Fuego', 1);
select * from info_basica_pokemon;

-- En mi caso, si se muestra en la vista, ya que lo he creado con metodo de evolucion 'Piedra Fuego'.

/*3. Crea una vista para contar cuántos pokemons viven en cada localización.
Debe contener el nombre de la localización y cuántos pokemons hay en ella incluyendo solo
las localizaciones en las que haya más de 18 pokemons. (1,5 puntos).
Sobre la vista, selecciona las localizaciones cuyo nombre empiece por C.*/

create or replace view pokemons_por_localizacion as
	SELECT 
    l.nombre as nombre_localizacion, COUNT(p.id_pokemon) as cantidad_pokemons
FROM
    pokemon p
        INNER JOIN
    vive v USING (id_pokemon)
        INNER JOIN
    localizaciones l on l.id_localizacion = v.id_localizacion 
GROUP BY l.id_localizacion having cantidad_pokemons > 18;

select * from pokemons_por_localizacion where nombre_localizacion like 'C%';

/*4. Crea un índice sobre la tabla pokemon para las columnas nombre y descripción. (1 punto).
Si haces una consulta de todos los pokemon cuya descripción empiece por E, ¿se utiliza el
índice?
Incluye la sentencia con la que se pueda comprobar tu respuesta. Ten en cuenta que a veces,
MySQL no aplica los índices tal y como debería por lo que el resultado de la comprobación
puede no ajustarse a lo que esperas.*/

create index idx_nom_desc on pokemon(nombre, descripcion);
drop index idx_nom_desc on pokemon;
explain select * from pokemon where descripcion like 'E%';

-- sin indice
-- 1	SIMPLE	pokemon		ALL					252	11.11	Using where

-- con indice
-- 1	SIMPLE	pokemon		ALL					252	11.11	Using where

-- He llegado a la conclusion de que para esta sentencia el indice no se usa, ya que he comparado 
-- el resultado de ambos y son exactamente iguales.


/*5. Ejecuta los scripts usuario1.sql y usuario2.sql en dos sesiones diferentes. Primero debes
ejecutar el paso 1, luego el paso 2 y por último el paso 3. (2 puntos).
¿Qué problema de concurrencia de transacciones se produce? ¿cuál es el nivel de aislamiento
mínimo que debes aplicar para que no se produzca? ¿Es necesario aplicarlo al script del
usuario 1, al del usuario 2 o a ambos?*/

-- primero, desde usuario 1 leemos el pokemon y mide 1.6
-- luego, desde el usuario2 actualizamos su altura a 1.7
-- finalmente, desde usuario 1 terminamos la transaccion leyendo el pokemon

-- se produce la lectura sucia

/*6. Crea un usuario que se llame como tú y pueda conectarse desde cualquier equipo a nuestro
SGBD. Debe tener permisos para seleccionar datos sobre todas las tablas de la BdD pokedex y
actualizar sobre la tabla pokemon. (1 punto).*/

CREATE USER 'bruno'@'localhost';

grant select on pokedex.* to 'bruno'@'localhost';
grant update on pokedex.pokemon to 'bruno'@'localhost';

/*Crea instrucciones para probar que puede:
◦ Realizar una consulta con un INNER JOIN.
◦ Actualizar algo en la tabla pokemon.*/
select p.nombre, c.fecha_captura from pokemon p inner join captura c using(id_pokemon);
update pokemon set peso = 2 where id_pokemon = 5;
/*Y no puede:
◦ Actualizar algo en otra tabla.
◦ Borrar una fila de la tabla pokemon.*/
update captura set fecha_captura = 1999-11-11 where id_pokemon = 5;
delete from pokemon where id_pokemon = 5;

-- todo correcto para cada acción

/*
7. Crea un procedimiento para insertar un pokemon que reciba los datos para id_pokemon,
nombre y descripcion. (3 puntos).
Si el identificador ya existe (PK duplicada) debe realizar la inserción pero cambiando el
identificador por el siguiente al más alto que exista en la tabla. Después, propagará el error
sustituyendo el mensaje por 'PK Duplicada: se ha sustituido por otra'.
Crea instrucciones para:
◦ Insertar un pokemon cuya clave NO esté en la tabla.
◦ Comprobar la inserción anterior.
◦ Insertar un pokemon cuya clave SÍ esté en la tabla.
◦ Comprobar la inserción anterior.
*/


delimiter $$
drop procedure if exists insertar_pokemon2$$
create procedure insertar_pokemon2(in id_pokemon int unsigned, in nombre varchar(30), in descripcion varchar(200))
begin
    
    -- entra si la clave existe
	declare exit handler for 1062
    begin
		set id_pokemon = (select max(p.id_pokemon)+1 from pokemon p);
       	insert into pokemon values (id_pokemon, nombre, descripcion, 0, 0, null, null);
		resignal
			set message_text = 'PK Duplicada: se ha sustituido por otra';
		-- aqui se cortaria el hilo de ejecucion
	end;
	
    -- si no ha entrado en el handler, es porque la clave introducida no estaba repetida
	insert into pokemon values (id_pokemon, nombre, descripcion, 0, 0, null, null);
    


end $$
delimiter ;

call insertar_pokemon2(1016, 'pokemonc', 'es pokemonc');

select * from pokemon where nombre = 'pokemonc';








