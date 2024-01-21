drop database if exists  hospital;
create database if not exists hospital; 
use hospital;

create table especialidad(
codigo_esp varchar(20) not null,
primary key (codigo_esp)
);

create table doctor(
codigo_doctor varchar(20) primary key,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
codigo_esp varchar(20) not null,
foreign key (codigo_esp) references especialidad (codigo_esp)
);

create table aseguradora(
nombre_aseg varchar(20) primary key,
calle varchar(10) not null,
numero int unsigned not null,
telefono varchar(15) not null
);

create table paciente(
codigo_paciente varchar(20) primary key,
nombre varchar(20) not null,
apellido1 varchar(20) not null,
apellido2 varchar(20),
calle varchar(30) not null,
numero int unsigned not null,
telefono varchar(10) not null,
nombre_aseg varchar(20) not null,
foreign key (nombre_aseg) references aseguradora(nombre_aseg)
);

create table factura(
id_factura varchar(30) primary key,
fecha_factura date not null,
precio int unsigned not null,
estado_pago varchar(15) not null,
codigo_paciente varchar(20) not null,
foreign key (codigo_paciente) references paciente (codigo_paciente)
);

create table cita(
codigo_cita varchar(15) not null,
codigo_paciente varchar(20) not null,
codigo_doctor varchar(20) not null,
primary key (codigo_cita,codigo_paciente, codigo_doctor),
fecha date not null,
hora int unsigned not null,
motivo varchar(30) not null,
id_factura varchar(30) not null,
foreign key (id_factura)references factura(id_factura)
);

create table tiene(
codigo_cita varchar(15) not null,
codigo_paciente varchar(20) not null,
codigo_doctor varchar(20) not null,
primary key (codigo_cita, codigo_doctor),
foreign key (codigo_paciente)references paciente (codigo_paciente),
foreign key (codigo_doctor)references doctor (codigo_doctor),
foreign key (codigo_cita)references cita (codigo_cita)
);

create table paga(
id_factura varchar(30) not null,
nombre_aseg varchar(20) not null,
primary key(id_factura, nombre_aseg),
fecha_pago_aseg date not null,
cuantia int unsigned not null,
foreign key (id_factura) references factura (id_factura),
foreign key (nombre_aseg) references aseguradora (nombre_aseg)
);
/*describe paga;*/

