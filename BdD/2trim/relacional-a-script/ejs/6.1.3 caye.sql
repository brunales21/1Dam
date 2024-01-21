drop database if exists cuenta_banco;
create database if not exists cuenta_banco;

use cuenta_banco;

create table entidad(
numero_entidad int primary key
);
/*describe entidad_bancaria;*/


create table oficina(
numero_oficina int primary key,
numero_entidad int unsigned not null,
foreign key (numero_entidad) references entidad(numero_entidad)
);

create table cuenta(
numero_cuenta int unsigned not null,
numero_oficina int unsigned not null,
numero_entidad int unsigned not null,
primary key(numero_cuenta, numero_oficina, numero_entidad),
foreign key (numero_oficina) references oficina(numero_oficina),
foreign key (numero_entidad) references entidad(numero_entidad)
);