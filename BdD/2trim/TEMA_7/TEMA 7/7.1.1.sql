use competicion;
/*truncate table pilotos;
truncate table escuderia;
truncate table coche;*/
delete from conduce;
delete from coche;
delete from pilotos;
delete from escuderia;


insert into pilotos(licencia, nombre, apellido1, apellido2, fecha_de_nacimiento)
	values (10, "Pedro", "Martin", "Garcia", '1992-04-22');
insert into pilotos(licencia, nombre, apellido1, apellido2, fecha_de_nacimiento)
	values (11, "David", "Pérez", "Prades", '2000-04-04');
insert into pilotos(licencia, nombre, apellido1, apellido2, fecha_de_nacimiento)
	values (12, "José", "Aliende", "Galguera", '1999-07-26');
insert into pilotos(licencia, nombre, apellido1, apellido2, fecha_de_nacimiento)
	values (13, "Pedro", "García", "Sanchez", '1991-03-07');
    

insert into escuderia (nombre_escuderia, nombre_director, año_creación)
	values ("Ferrari", "Juan Pablo", 1960);
insert into escuderia (nombre_escuderia, nombre_director, año_creación)
	values ("Mercedes", "Sergio", 1955);

    
insert into coche (numero_coche,  nombre_escuderia)
	values(1, "Ferrari");
insert into coche (numero_coche,  nombre_escuderia)
	values(2, "Mercedes");
insert into coche (numero_coche,  nombre_escuderia)
	values(3, "Mercedes");
    

insert into conduce (licencia,  numero_coche)
	values(10, 1);
insert into conduce (licencia,  numero_coche)
	values(11, 3);
insert into conduce (licencia,  numero_coche)
	values(12, 2);




