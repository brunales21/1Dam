DROP database IF EXISTS empleados;
CREATE database IF NOT EXISTS empleados;
USE empleados;

/*
En el script de creación de la BdD Empleados del apéndice B, ¿qué restricciones
de modificación y borrado pondrías a cada clave ajena? ¿Por qué?. Modifica el
script para incluir estos cambios y prueba a ejecutarlo. Ejecuta después el de
inserción, prestando atención a que no se produzcan errores al hacerlo.

*/

CREATE TABLE regiones(
  id_region INT NOT NULL,
  nombre_region VARCHAR(25),
  CONSTRAINT regiones_pk PRIMARY KEY (id_region)
);

CREATE TABLE paises (
  id_pais char(2) NOT NULL,
  nombre_pais VARCHAR(40),
  id_region INT,
  CONSTRAINT paises_pk PRIMARY KEY (id_pais),
  CONSTRAINT paises_fk1 FOREIGN KEY (id_region) REFERENCES regiones(id_region)
	ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE localizaciones (
  id_localizacion INT NOT NULL,
  direccion VARCHAR(40),
  codigo_postal VARCHAR(12),
  ciudad VARCHAR(30) NOT NULL,
  provincia VARCHAR(25),
  id_pais char(2),
  CONSTRAINT localizaciones_pk PRIMARY KEY (id_localizacion),
  CONSTRAINT localizaciones_fk1 FOREIGN KEY (id_pais) REFERENCES paises(id_pais)
	ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE categorias_prof (
  id_cat_prof VARCHAR(3),
  min_salario INT,
  max_salario INT,
  CONSTRAINT categorias_prof_pk PRIMARY KEY (id_cat_prof)
);

CREATE TABLE trabajos (
  id_trabajo VARCHAR(10) NOT NULL,
  nombre_trabajo VARCHAR(35) NOT NULL,
  min_salario INT,
  max_salario INT,
  CONSTRAINT trabajos_pk PRIMARY KEY (id_trabajo)
);

CREATE TABLE departamentos (
  id_departamento INT NOT NULL,
  nombre_departamento VARCHAR(30) NOT NULL,
  id_director INT,
  id_localizacion INT,
  CONSTRAINT departamentos_pk PRIMARY KEY (id_departamento),
  CONSTRAINT departamentos_fk1 FOREIGN KEY (id_localizacion) REFERENCES localizaciones(id_localizacion)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
);

CREATE TABLE empleados (
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
  CONSTRAINT empleados_pk PRIMARY KEY (id_empleado),
  CONSTRAINT empleados_fk1 FOREIGN KEY (id_director) REFERENCES empleados(id_empleado)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  CONSTRAINT empleados_fk2 FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  CONSTRAINT empleados_fk3 FOREIGN KEY (id_trabajo) REFERENCES trabajos(id_trabajo)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
);

ALTER TABLE departamentos ADD CONSTRAINT departamentos_fk2 FOREIGN KEY (id_director) REFERENCES empleados(id_empleado);

CREATE TABLE historial_trab (
  id_empleado INT NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_fin date NOT NULL,
  id_trabajo VARCHAR(10) NOT NULL,
  id_departamento INT,
  CONSTRAINT historial_trab_pk PRIMARY KEY (id_empleado, fecha_inicio),
  CONSTRAINT historial_trab_fk1 FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
  CONSTRAINT historial_trab_fk2 FOREIGN KEY (id_trabajo) REFERENCES trabajos(id_trabajo)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
  CONSTRAINT historial_trab_fk3 FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
);

