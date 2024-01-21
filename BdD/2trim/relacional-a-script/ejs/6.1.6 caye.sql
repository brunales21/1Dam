drop database if exists tienda_computadora;
create database if not exists tienda_computadora; 

use tienda_computadora;

create table poblaciones(
nombre_poblacion varchar(20) primary key,
provincia varchar(20) not null
);

create table persona(
dni varchar(20) primary key,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20) not null,
telefono varchar (10) not null,
calle varchar(15) not null,
numero int unsigned not null,
piso int unsigned not null,
puerta varchar(10) not null,
cliente_premium varchar(20) not null,
nombre_poblacion varchar(20) not null,
foreign key (nombre_poblacion) references poblaciones(nombre_poblacion) 
);

create table cliente(
dni varchar(20) primary key,
foreign key (dni) references persona(dni)
);

create table version(
num_version int unsigned primary key
);

create table compra(
dni varchar(20) not null,
num_version int unsigned not null,
primary key(dni,num_version),
foreign key (num_version) references version (num_version),
foreign key (dni) references cliente (dni)
);

create table vendedor(
num_vendedor int unsigned primary key,
dni varchar(20) not null,
foreign key (dni) references persona (dni)
);
create table vende(
num_vendedor int unsigned not null,
num_version int unsigned not null,
primary key (num_vendedor,num_version),
foreign key (num_vendedor) references vendedor (num_vendedor),
foreign key (num_version) references version (num_version)
);

create table extras(
id_extra varchar(20) primary key,
nombre_extra varchar(15) not null
);

create table extras_version(
id_extra varchar(20) not null,
num_version int unsigned not null,
primary key(id_extra,num_version),
foreign key (id_extra) references extras (id_extra),
foreign key (num_version) references version (num_version)
);

create table marca(
nombre_marca varchar(25) primary key
);

create table procesador(
modelo_procesador varchar(30) primary key,
nombre_marca varchar(20) not null,
foreign key (nombre_marca) references marca(nombre_marca)
);

create table modelos(
nombre varchar(20) primary key,
nombre_marca varchar(25) not null,
modelo_procesador varchar(30) not null,
foreign key (nombre_marca) references marca(nombre_marca),
foreign key (modelo_procesador) references procesador(modelo_procesador)
);

create table modelo_version(
id_extra varchar(20) not null,
num_version int unsigned not null,
primary key(id_extra,num_version),
foreign key (id_extra) references extras (id_extra),
foreign key (num_version) references version (num_version)
);
