use equipos;

insert into equipo(nombre_equipo, año_creación) values("Real Madrid",  1902);
insert into equipo(nombre_equipo, año_creación) values("Barcelona",  1899);
insert into equipo(nombre_equipo, año_creación) values("Atlético Madrid",  1903);
insert into equipo(nombre_equipo, año_creación) values("Valencia",  1919);


insert into marca (id_marca, nombre_marca, calle, numero, ciudad, pais_sede) values (30,  "Puma",  "Serrano",  23,  "Madrid", "Spain");
insert into marca (id_marca, nombre_marca, calle, numero, ciudad, pais_sede) values (31,  "New Balance",  "Calle Mayor",  5,  "Barcelona", "Spain");
insert into marca (id_marca, nombre_marca, calle, numero, ciudad, pais_sede) values (32,  "Under Armour",  "Calle Mayor",  5,  "Barcelona", "Spain");
insert into marca (id_marca, nombre_marca, calle, numero, ciudad, pais_sede) values (33,  "Reebok",  "Gran Via",  3,  "Madrid", "Spain");


insert into tipo (id_tipo, nombre_tipo) values (26, "Equipamiento");
insert into tipo (id_tipo, nombre_tipo) values (27, "Accesorios");
insert into tipo (id_tipo, nombre_tipo) values (28, "Indumentaria técnica");
insert into tipo (id_tipo, nombre_tipo) values (29, "Entrenamiento");


insert into tipo (id_tipo, nombre_tipo) values (26, "Equipamiento");
insert into tipo (id_tipo, nombre_tipo) values (27, "Accesorios");
insert into tipo (id_tipo, nombre_tipo) values (28, "Indumentaria técnica");
insert into tipo (id_tipo, nombre_tipo) values (29, "Entrenamiento");


insert into material (id_material, nombre_material, id_tipo) values (208, "Guantes", 26);
insert into material (id_material, nombre_material, id_tipo) values (209, "Maya", 27);
insert into material (id_material, nombre_material, id_tipo) values (210, "Chaleco", 28);
insert into material (id_material, nombre_material, id_tipo) values (211, "Pesas", 29);


insert into proporciona(id_marca, id_material, nombre_equipo, cantidad_pedido, fecha_pedido) values (33, 208, "Real Madrid", 20,  2022-08-03);
insert into proporciona(id_marca, id_material, nombre_equipo, cantidad_pedido, fecha_pedido) values (32, 209, "Barcelona", 10,  2022-08-03);
insert into proporciona(id_marca, id_material, nombre_equipo, cantidad_pedido, fecha_pedido) values (31, 210, "Atlético Madrid", 15,  2022-08-03);
insert into proporciona(id_marca, id_material, nombre_equipo, cantidad_pedido, fecha_pedido) values (30, 211, "Valencia", 25,  2022-08-03);

    
    
/*7.1.4
Un elemento se introdujo por error con un nombre no adecuado. Modifica el
nombre de un elemento.
*/

update material set nombre_material="Malla" where nombre_material="Maya";
    
/*7.1.5
Un elemento se introdujo en una marca incorrecta. Escribe la sentencia para cambiar el elemento de marca.
*/
update proporciona set id_marca=29 where id_marca=33 and id_material=208 and nombre_equipo="Real Madrid";

/*7.1.6
Escribe una modificación que cambie la clave primaria de una marca. ¿Qué sucede con los elementos asociados a ella?
*/
update marca set id_marca=7 where id_marca=28;
select * from marca;
select * from proporciona;


