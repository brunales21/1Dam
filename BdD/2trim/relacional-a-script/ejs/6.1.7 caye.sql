drop database if exists academia;
create database if not exists academia;

use academia;

create table persona(
dni varchar(10) primary key,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
fecha_de_nacimiento date not null,
nacionalidad varchar(25) not null,
sexo varchar(10) not null,
telefono varchar(20) not null,
calle varchar(20) not null,
numero varchar(10) not null
);

create table empleado(
codigo_empleado varchar(20) primary key,
dni varchar(10) not null,
salario int unsigned not null check(salario>1000),
foreign key (dni) references persona(dni)
);

create table profe_ext(
dni varchar(10) primary key,
foreign key (dni) references persona(dni)
);
create table cursos(
codigo_curso varchar(10) primary key,
nombre varchar(20) not null,
coste int unsigned not null,
numero_horas int unsigned not null,
curso_prerequisito varchar (10) not null,
foreign key (curso_prerequisito) references cursos(codigo_curso)
);
create table imparte(
dni varchar(10) not null,
codigo_curso varchar(10) not null,
primary key (dni,codigo_curso),
foreign key (dni) references persona(dni),
foreign key (codigo_curso) references cursos(codigo_curso)
);

create table cursa(
dni varchar(10) not null,
codigo_curso varchar(10) not null,
primary key (dni,codigo_curso),
foreign key (dni) references persona(dni),
foreign key (codigo_curso) references cursos(codigo_curso)
);

create table materias(
num_mat int unsigned primary key,
codigo_curso varchar(10) not null,
nombre varchar(10) not null,
descripcion varchar(50) not null,

foreign key (codigo_curso) references cursos(codigo_curso)
);

create table edicion(
nombre_edicion varchar(50) primary key,
codigo_curso varchar(10) not null,
fecha date not null,
foreign key (codigo_curso) references cursos(codigo_curso)
);
create table localizacion(
calle varchar(10) not null,
num int unsigned not null,
aula varchar(10) not null,
piso int unsigned not null,
nombre_edicion varchar(50) not null,
telefono varchar(15) not null,
pais varchar(50) not null,
pertenencia varchar(50) not null,
foreign key (nombre_edicion) references edicion(nombre_edicion)
);




describe localizacion;









