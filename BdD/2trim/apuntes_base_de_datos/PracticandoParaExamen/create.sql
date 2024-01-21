
USE EmpresaX;


CREATE TABLE region (
  id_region INT NOT NULL,
  nombre_region VARCHAR(25),
  CONSTRAINT region_pk PRIMARY KEY (id_region)
);

CREATE TABLE pais (
  id_pais  char(2) NOT NULL,
  nombre_pais  VARCHAR(40),
  id_region INT,
  CONSTRAINT pais_pk PRIMARY KEY (id_pais),
  CONSTRAINT pais_fk1 FOREIGN KEY (id_region) REFERENCES region (id_region) 
);

CREATE TABLE localizacion  (
  id_localizacion INT NOT NULL,
  direccion VARCHAR(40),
  codigo_postal VARCHAR(12),
  ciudad VARCHAR(30) NOT NULL,
  provincia VARCHAR(25),
  id_pais char(2),
  CONSTRAINT localizacion_pk PRIMARY KEY (id_localizacion),
  CONSTRAINT localizacion_fk1 FOREIGN KEY (id_pais) REFERENCES pais (id_pais)
);

CREATE TABLE categoria_prof (
  id_cat_prof VARCHAR(3),
  min_salario INT,
  max_salario INT,
  CONSTRAINT categoria_prof_pk PRIMARY KEY (id_cat_prof)
);

CREATE TABLE trabajo  (
  id_trabajo VARCHAR(10) NOT NULL,
  nombre_trabajo VARCHAR(35) NOT NULL,
  min_salario INT,
  max_salario INT,
  CONSTRAINT trabajo_pk PRIMARY KEY (id_trabajo)
);

CREATE TABLE departamento  (
  id_departamento INT NOT NULL,
  nombre_departamento VARCHAR(30) NOT NULL,
  id_director INT,
  id_localizacion INT,
  CONSTRAINT departamento_pk PRIMARY KEY (id_departamento),
  CONSTRAINT departamento_fk1 FOREIGN KEY (id_localizacion) REFERENCES localizacion (id_localizacion)
);

CREATE TABLE empleado (
  id_empleado INT NOT NULL,
  nombre VARCHAR(20),
  apellido VARCHAR(20) NOT NULL,
  email VARCHAR(25) NOT NULL,
  telefono VARCHAR(20),
  fecha_contratacion date NOT NULL,
  id_trabajo VARCHAR(10) NOT NULL,
  salario DECIMAL(8,2),
  comision DECIMAL(2,2),
  id_director INT,
  id_departamento INT,
  CONSTRAINT empleado_pk PRIMARY KEY (id_empleado),
  CONSTRAINT empleado_fk1 FOREIGN KEY (id_director) REFERENCES empleado(id_empleado),
  CONSTRAINT empleado_fk2 FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento),
  CONSTRAINT empleado_fk3 FOREIGN KEY (id_trabajo) REFERENCES trabajo(id_trabajo)
);

ALTER TABLE departamento  ADD CONSTRAINT departamento_fk2 FOREIGN KEY (id_director) REFERENCES empleado(id_empleado);

CREATE TABLE historial_trab (
  id_empleado INT NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_fin date NOT NULL,
  id_trabajo VARCHAR(10) NOT NULL,
  id_departamento INT,
  CONSTRAINT historial_trab_pk PRIMARY KEY (id_empleado, fecha_inicio),
  CONSTRAINT historial_trab_fk1 FOREIGN KEY (id_empleado) REFERENCES  empleado(id_empleado),
  CONSTRAINT historial_trab_fk2 FOREIGN KEY (id_trabajo) REFERENCES  trabajo(id_trabajo),
  CONSTRAINT historial_trab_fk3 FOREIGN KEY (id_departamento) REFERENCES  departamento(id_departamento)
);
