drop database if exists  biblioteca_nacional;
create database if not exists  biblioteca_nacional;

use  biblioteca_nacional;

create table autor(
dni varchar(20) primary key,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
fecha_de_nacimiento date not null
);
create table libro(
isbn varchar(20) primary key,
titulo_libro varchar(30) not null,
idioma varchar(15) not null,
año_publicacion date not null
);
create table editorial(
nombre_editorial varchar(20),
codigo_editorial int unsigned,
primary key (nombre_editorial, codigo_editorial),
telefono int unsigned not null,
nombre_editorial_pequeña varchar(20) not null,
foreign key(nombre_editorial_pequeña) references editorial(nombre_editorial)
);
create table publica(
dni varchar(20) not null,
isbn varchar(20) not null,
nombre_editorial varchar(20),
codigo_editorial int unsigned,
primary key(isbn,nombre_editorial,codigo_editorial),
foreign key(isbn) references libro(isbn),
foreign key(nombre_editorial,codigo_editorial) references editorial(nombre_editorial,codigo_editorial),
foreign key(dni) references autor(dni)
);

