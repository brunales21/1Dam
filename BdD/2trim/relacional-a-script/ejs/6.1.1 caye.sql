/* Eliminación y creación de base de datos*/
drop database if exists  competicion_caye;
create database if not exists competicion_caye;

use competicion_caye;

/*Creación de la tabla piloto*/

create table pilotos(
licencia int unsigned not null primary key,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
fecha_de_nacimiento date not null
);
/*describe pilotos;*/

create table coche(
numero_coche int unsigned auto_increment primary key /* las claves primarias son valores not null y unique implicitamente*/
);
create table escudería(
nombre_escuderia varchar(20) primary key,
nombre_director varchar(20) not null,
año_creación date not null,
fecha_nacimiento_escuderia date not null,
numero_coche int unsigned auto_increment not null,
foreign key (numero_coche) references coche(numero_coche)
); 
/*describe escudería;*/
create table conduce(
licencia int unsigned not null,
numero_coche int unsigned auto_increment,
primary key (licencia, numero_coche),
foreign key(licencia) references piloto(licencia),
foreign key(numero_coche) references coche(numero_coche)
);


