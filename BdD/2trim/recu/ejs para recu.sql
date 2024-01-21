use pokedex;
-- ¿Cuáles son los nombres de todos los Pokémon en la base de datos?
select nombre from pokemon;
-- ¿Cuáles son los nombres de los entrenadores que tienen más de 5 medallas?
select nombre from entrenadores where medallas>4;
-- ¿Cuáles son los Pokémon que pesan más de 50 kilogramos y miden más de 1 metro?
select * from pokemon where peso>50 and altura>1;
-- ¿Cuáles son los movimientos que pueden aprender los Pokémon de tipo fuego?
select * from movimientos where id_tipo = (select id_tipo from tipos where nombre = 'fuego');
-- que id_tipo exista en la tabla movimientos y que tenga de nombre fuego
select * from movimientos m where exists (select * from tipos t where t.id_tipo = m.id_tipo and t.nombre = 'fuego');
-- ¿Cuáles son los Pokémon que pueden aprender el movimiento "Terremoto"?
select * from pokemon p where exists (select * from aprende a inner join movimientos m using(id_movimiento) where p.id_pokemon = a.id_pokemon and m.nombre = 'Terremoto');
-- ¿Cuál es la especialidad del entrenador con el ID 3?
select especialidad from entrenadores where id_entrenador = 3;
-- ¿Cuáles son los Pokémon que pueden evolucionar mediante "Intercambio"?
select * from pokemon where metodo_evolucion in ('Intercambio');
-- ¿Qué Pokémon vive en la localización con el ID 10?
select * from pokemon p where exists (select * from vive v where v.id_pokemon = p.id_pokemon and v.id_localizacion = 10);
-- ¿Cuál es el efecto del tipo de atacante "Agua" contra el tipo de defensor "Fuego"?
select v.efecto from ventaja v where v.id_atacante = (select t.id_tipo from tipos t where t.nombre = 'Agua') and v.id_defensor = (select t.id_tipo from tipos t where t.nombre = 'Fuego') ;
-- ¿Cuáles son los movimientos que tienen un poder mayor o igual a 100 y una precisión mayor o igual al 90%?
select * from movimientos where poder>=100 and prec>=90;


-- Seleccionar los entrenadores que tienen al menos un pokemon de tipo fuego.
select * from entrenadores e where exists (select * from captura c where c.id_entrenador = e.id_entrenador and c.id_pokemon in (select tt.id_pokemon from tiene_tipo tt where tt.id_tipo = (select t.id_tipo from tipos t where nombre = 'Fuego')));
select * from entrenadores e where exists (select * from captura c where c.id_entrenador = e.id_entrenador and c.id_pokemon in (select tt.id_pokemon from tiene_tipo tt where exists (select * from tipos t where t.id_tipo = tt.id_tipo and nombre = 'Fuego')));
-- Seleccionar los tipos de pokemon que tienen al menos un movimiento con poder mayor a 90.
select * from tipos t where exists (select * from movimientos m where m.id_tipo = t.id_tipo and m.poder>90);
select * from tipos t where t.id_tipo = any (select m.id_tipo from movimientos m where m.id_tipo = t.id_tipo and m.poder>90);
select * from tipos t where t.id_tipo in (select m.id_tipo from movimientos m where m.id_tipo = t.id_tipo and m.poder>90);

-- Seleccionar los pokemon que pueden evolucionar mediante "Piedra Fuego" o "Piedra Agua".
select * from pokemon where metodo_evolucion in ('Piedra Fuego', 'Piedra Agua');
-- Seleccionar los entrenadores que tienen al menos un pokemon con nivel mayor a 70.
select * from entrenadores e where exists (select * from captura c where c.id_entrenador = e.id_entrenador);
select * from entrenadores e where not exists (select * from captura c where c.id_entrenador = e.id_entrenador);
select * from entrenadores e where e.id_entrenador = any (select c.id_entrenador from captura c);
-- Seleccionar los movimientos que todos los pokemon de tipo agua pueden aprender.
select m.* from movimientos m inner join tipos t on m.id_tipo = t.id_tipo where t.nombre = 'Agua';
-- Seleccionar los pokemon que pueden vivir en la localización "Montaña".
select * from pokemon p inner join vive v on p.id_pokemon = v.id_pokemon where v.id_localizacion = any (select id_localizacion from localizaciones where nombre = 'Guarida Rocket');
-- Seleccionar los movimientos que ningún pokemon de tipo fantasma puede aprender.
select * from movimientos m where not exists (select * from tipos t where t.id_tipo = m.id_tipo and t.nombre != 'fantasma');
select m.* from movimientos m inner join tipos t on m.id_tipo = t.id_tipo where t.nombre != 'fantasma';
-- Actualizar el nivel de todos los pokemon de tipo eléctrico a 50.
-- tengo que crear la columna nivel ya que no existia en la bdd original (los inicializo a 30 por no poner 0)
alter table pokemon add nivel int default 30 after altura;
-- update
update pokemon p set p.nivel = 50 where exists (select * from pokemon p inner join tiene_tipo tt on p.id_pokemon = tt.id_pokemon inner join tipos t on tt.id_tipo = t.id_tipo where t.nombre = 'Electrico');
-- otra forma
update pokemon p set p.nivel = 55 where p.id_pokemon in (select p.id_pokemon from pokemon p inner join tiene_tipo tt on p.id_pokemon = tt.id_pokemon inner join tipos t on tt.id_tipo = t.id_tipo where t.nombre = 'Electrico');
-- comprobacion 
select p.* from pokemon p inner join tiene_tipo tt on p.id_pokemon = tt.id_pokemon inner join tipos t on tt.id_tipo = t.id_tipo where t.nombre = 'Electrico';

-- Escribe una consulta para obtener el nombre y la descripción de los pokemon que tienen una ventaja contra los pokemon de tipo "Agua"
select p.nombre, p.descripcion from pokemon p where exists (select * from tiene_tipo tt where tt.id_pokemon = p.id_pokemon and tt.id_tipo in (select v.id_atacante from ventaja v where v.id_defensor = (select id_tipo from tipos where nombre = 'Agua')));

SELECT P.nombre, P.descripcion FROM pokemon P, tiene_tipo TT WHERE P.id_pokemon = TT.id_pokemon AND TT.id_tipo IN (SELECT V.id_atacante FROM tipos T, ventaja V WHERE T.id_tipo = V.id_defensor AND T.nombre = 'Agua');