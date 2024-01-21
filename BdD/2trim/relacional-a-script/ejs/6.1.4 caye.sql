drop database if exists  equipos;
create database if not exists equipos; 
use equipos;

 create table equipo(
nombre_equipo varchar(20) primary key,
año_creación int unsigned not null
);

create table marca(
id_marca varchar(20) primary key,
nombre_marca varchar(20) not null,
calle varchar(20) not null,
numero int unsigned not null,
ciudad varchar(20) not null,
pais_sede varchar(20) not null
);

create table tipo(
id_tipo varchar(20) primary key,
nombre_tipo varchar(20) not null
);

 create table material(
id_material varchar(20) primary key,
nombre_material varchar(20) not null,
id_tipo varchar(20) not null,
foreign key (id_tipo) references tipo(id_tipo)
);
describe material;

create table proporciona(
id_marca varchar(20) not null,
id_material varchar(20) not null,
nombre_equipo varchar(20) not null,
cantidad_pedido int unsigned not null,
fecha_pedido date not null,
primary key (id_marca,id_material,nombre_equipo),
foreign key (id_marca) references marca(id_marca),
foreign key (id_material) references material(id_material),
foreign key (nombre_equipo) references equipo(nombre_equipo)
);

/*describe proporciona;*/
