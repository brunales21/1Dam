/* Para poder borrar las tablas hay que desactivar el safe mode en 
   Edit -> Preferences -> SQL queries -> Safe Updates 
   y reconectar */
USE EmpresaX;


SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM historial_trab;
DELETE FROM categoria_prof;
/*alter table departamento disable foreign key departamento_fk2;*/
DELETE FROM empleado;
DELETE FROM departamento;
DELETE FROM trabajo;
DELETE FROM localizacion;
DELETE FROM pais;
DELETE FROM region;
/*alter table departamento enable foreign key departamento_fk2;*/

SET FOREIGN_KEY_CHECKS = 1;

/*Europa*/
INSERT INTO region (id_region, nombre_region) VALUES (1, 'Europa');
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('DE', 'Alemania', 1);
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('UK', 'Reino Unido', 1);
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('ES', 'España', 1);

/*América*/
INSERT INTO region (id_region, nombre_region) VALUES (2, 'América');
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('CA', 'Canadá', 2);
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('US', 'Estados Unidos', 2);

/*Asia*/
INSERT INTO region (id_region, nombre_region) VALUES (3, 'Asia');
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('JP', 'Japón', 3);
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('CH', 'China', 3);

/*resto*/
INSERT INTO region (id_region, nombre_region) VALUES (4, 'Oriente Medio y África');
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('IR', 'Israel', 4);
INSERT INTO pais (id_pais, nombre_pais, id_region) VALUES ('SA', 'Sudáfrica', 4);

/*localizacion*/
INSERT INTO localizacion (id_localizacion, direccion, codigo_postal, ciudad, provincia, id_pais) 
  VALUES (1000, '3400, 5th Avenue', '33534', 'Nueva York', 'New York State', 'US');
INSERT INTO localizacion (id_localizacion, direccion, codigo_postal, ciudad, provincia, id_pais) 
  VALUES (1100, '120, Venice Beach', '12444', 'Los Ángeles', 'California', 'US');  
INSERT INTO localizacion (id_localizacion, direccion, codigo_postal, ciudad, provincia, id_pais) 
  VALUES (1200, '34, Abby Road', '89776', 'Seattle', 'Washington', 'US');  
INSERT INTO localizacion (id_localizacion, direccion, codigo_postal, ciudad, provincia, id_pais) 
  VALUES (2000, '456, Raptors St.', 'TOR M3 23', 'Toronto', 'Ontario', 'CA');
INSERT INTO localizacion (id_localizacion, direccion, codigo_postal, ciudad, provincia, id_pais) 
  VALUES (3000, '23, Köller Strasse', '5645434', 'Berlín', 'Berlín', 'DE');
INSERT INTO localizacion (id_localizacion, direccion, codigo_postal, ciudad, provincia, id_pais) 
  VALUES (3100, '544, Nibelungen', '342323', 'Colonia', 'Westfalen', 'DE');
INSERT INTO localizacion (id_localizacion, direccion, codigo_postal, ciudad, provincia, id_pais) 
  VALUES (4000, 'Plaza de la Independencia S/N', '28033', 'Madrid', 'Madrid', 'ES');
INSERT INTO localizacion (id_localizacion, direccion, codigo_postal, ciudad, provincia, id_pais) 
  VALUES (4100, 'Avenida Diagonal, 34 3ºB', '33255', 'Barcelona', 'Barcelona', 'ES');

/*trabajo*/
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('AD_PRES', 'Presidente', 20000, 40000);
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('AD_VP', 'Vicepresidente', 20000, 40000);
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('AD_ASST', 'Asistente de administración', 3000, 6000);
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('AC_MGR', 'Director de contabilidad', 8200, 16000);
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('AC_ACCOUNT', 'Contable', 4200, 9000);
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('SA_MAN', 'Director de ventas', 10000, 20000);
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('SA_REP', 'Representante de ventas', 6000, 12000);  
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('ST_MAN', 'Director de almacén', 5500, 8500);  
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('ST_CLERK', 'Empleado de almacén', 2000, 5000);  
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('IT_PROG', 'Programador', 4000, 10000); 
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('MK_MAN', 'Director de marketing', 9000, 15000); 
INSERT INTO trabajo (id_trabajo, nombre_trabajo, min_salario, max_salario) 
  VALUES ('MK_REP', 'Representante de marketing', 4000, 9000);    
  
/*departamento*/

/*Ejecutivo*/
INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion)
  VALUES (10, 'Ejecutivo', NULL, 1000);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (100, 'Manuel', 'López', 'ml@scott.com', '934343456', '1987-06-17', 'AD_PRES', 24000, NULL, NULL, 10); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (101, 'Sara', 'James', 'sj@scott.com', '934376456', '1987-06-23', 'AD_VP', 17000, NULL, 100, 10); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (102, 'Gabrielle', 'Revillere', 'gr@scott.com', '935555456', '1990-12-26', 'AD_PRES', 17000, NULL, 100, 10);
  INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (103, 'Gabriel', 'Revre', 'gr4456@scott.com', '935525456', '1993-12-26', 'AD_PRES', 21000, NULL, 100, 10);
  INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (104, 'Pepe', 'Papo', 'pp@scott.com', '925555456', '1990-11-26', 'AD_PRES', 45000, NULL, 100, 10);

UPDATE departamento SET id_director=100 WHERE nombre_departamento='Ejecutivo';
 
/*administración*/
INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion)
  VALUES (20, 'Administración', NULL, 1000);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (202, 'Harald', 'Ernst', 'he@scott.com', '936578231', '2004-01-22', 'AD_ASST', 4400, NULL, 100, 20); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (203, 'María', 'González', 'mg@scott.com', '936577788', '2002-09-13', 'AD_ASST', 4500, NULL, 101, 20); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (204, 'María', 'Gómez', 'mgz@scott.com', '936544788', '2012-01-03', 'AD_ASST', 2500, NULL, 101, 20); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (205, 'Pedro', 'Jiménez', 'pj@scott.com', '935557788', '2006-09-22', 'AD_ASST', 2300, NULL, 101, 20); 

UPDATE departamento SET id_director=202 WHERE nombre_departamento='Administración';
  
/*Marketing*/
INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion)
  VALUES (30, 'Marketing', NULL, 4100);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (301, 'Mark', 'Gonzales', 'mkg@scott.com', '936574533', '1995-02-12', 'MK_MAN', 13000, NULL, 100, 30); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (302, 'Julie', 'Styles', 'js@scott.com', '954338231', '1999-04-15', 'MK_REP', 6000, NULL, 301, 30); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (303, 'Juan', 'Hierro', 'jr@scott.com', '952525231', '1996-05-08', 'MK_REP', 6000, NULL, 301, 30);

UPDATE departamento SET id_director=301 WHERE nombre_departamento='Marketing'; 

INSERT INTO historial_trab (id_empleado, fecha_inicio, fecha_fin, id_trabajo, id_departamento)
  VALUES (301, '1996-02-17', '1999-12-19', 'MK_REP',  30);  

/*Envíos*/
INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion)
  VALUES (40, 'Envíos', NULL, 4000);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (405, 'Maya', 'Van Pobel', 'mp@scott.com', '954646331', '1992-08-15', 'ST_MAN', 5800, NULL, 100, 40); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (407, 'Marcos', 'Pérez', 'map@scott.com', '954646332', '2002-06-16', 'ST_CLERK', 3500, NULL, 405, 40); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (408, 'Mikel', 'Zubizarreta', 'mz@scott.com', '954646772', '2002-06-16', 'ST_CLERK', 3100, NULL, 405, 40); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (409, 'Vanessa', 'Smith', 'ms@scott.com', '954646337', '2004-05-26', 'ST_CLERK', 2600, NULL, 405, 40); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (410, 'Earl', 'Watson', 'ew@scott.com', '954646654', '2005-06-21', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (411, 'Earl', 'Harrison', 'eh@scott.com', '954633654', '2005-08-21', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (412, 'George', 'Harris', 'gh@scott.com', '954645654', '2003-01-02', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (413, 'Giovanni', 'Porto', 'gp@scott.com', '956676654', '1999-06-21', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (414, 'Montserrat', 'Lleida', 'ml@scott.com', '954623454', '2001-12-21', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (415, 'César', 'Augusto', 'ca@scott.com', '957746654', '2005-06-21', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (416, 'Macarena', 'Bocanegra', 'mb@scott.com', '954633894', '2013-02-09', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (417, 'Julián', 'Carnicero', 'jc@scott.com', '932645654', '2011-10-02', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (418, 'Lewis', 'Johnson', 'lj@scott.com', '956333654', '1997-03-12', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (419, 'Esther', 'Gómez', 'eg@scott.com', '954723454', '2001-03-03', 'ST_CLERK', 2500, NULL, 405, 40);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (420, 'Juan Manuel', 'Del Arco', 'jm@scott.com', '957746654', '2005-06-21', 'ST_CLERK', 2500, NULL, 405, 40);

UPDATE departamento SET id_director=405 WHERE nombre_departamento='Envíos';   
  
/*Investigación y Desarrollo*/
INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion)
  VALUES (50, 'Investigación y Desarrollo', NULL, 2000);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (501, 'Sergio', 'García', 'sg@scott.com', '912646332', '2000-04-30', 'IT_PROG', 9000, NULL, 101, 50);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (502, 'María', 'Pérez', 'mape@scott.com', '954646777', '2003-06-16', 'IT_PROG', 6000, NULL, 102, 50); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (503, 'Indira', 'Virma', 'iv@scott.com', '912646365', '2005-10-23', 'IT_PROG', 4200, NULL, 102, 50);

UPDATE departamento SET id_director=501 WHERE nombre_departamento='Investigación y Desarrollo';   

INSERT INTO historial_trab (id_empleado, fecha_inicio, fecha_fin, id_trabajo, id_departamento)
  VALUES (102, '1993-09-13', '1998-07-24', 'IT_PROG',  50);  
  
  
/*ventas*/
INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion)
  VALUES (60, 'Ventas', NULL, 3000);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (601, 'Mayra', 'Chopenhauer', 'mc@scott.com', '912646765', '1998-10-17', 'SA_MAN', 10500, 0.2, 100, 60);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (602, 'John', 'Smith', 'js@scott.com', '912645565', '1999-11-09', 'SA_REP', 11000, 0.3, 601, 60); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (603, 'Said', 'Atitar', 'sa@scott.com', '912643365', '1999-11-10', 'SA_REP', 8600, 0.2, 601, 60);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (604, 'Juan Miguel', 'Ramírez', 'jmr@scott.com', '912643775', '1999-11-15', 'SA_REP', 8600, 0.2, 601, 60);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (605, 'Juan Manuel', 'Gonzaga', 'sa@scott.com', '912883365', '1999-04-10', 'SA_REP', 8600, 0.2, 601, 60);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (606, 'Karen', 'Schroeder', 'ks@scott.com', '912235565', '2003-05-09', 'SA_REP', 7000, 0.15, 601, NULL); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (607, 'Mayra', 'Kemp', 'mk@scott.com', '912655765', '1998-12-27', 'SA_REP', 10500, 0.2, 100, 60);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (608, 'John', 'Johnson', 'jj@scott.com', '912225565', '1998-12-12', 'SA_REP', 11000, 0.3, 601, 60); 
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (609, 'Herman', 'Hess', 'hh@scott.com', '912453365', '2002-02-20', 'SA_REP', 8600, 0.2, 601, 60);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (610, 'María Jesús', 'Martín', 'mjm@scott.com', '912574775', '1998-03-15', 'SA_REP', 8600, 0.2, 601, 60);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (611, 'Juan Manuel', 'Gonzalez', 'jmg@scott.com', '912885465', '2001-06-18', 'SA_REP', 8600, 0.2, 601, 60);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (612, 'Roberto', 'Ferreras', 'rf@scott.com', '912278565', '2003-06-19', 'SA_REP', 7000, 0.15, 601, NULL); 

UPDATE departamento SET id_director=601 WHERE nombre_departamento='Ventas';               
    
/*Contabilidad*/
INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion)
  VALUES (70, 'Contabilidad', NULL, 4000);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (702, 'Samuel', 'Fenix', 'sf@scott.com', '912643444', '1993-02-24', 'AC_MGR', 12000, NULL, 100, 70);
INSERT INTO empleado (id_empleado, nombre, apellido, email, telefono, fecha_contratacion, id_trabajo, salario, comision, id_director, id_departamento)
  VALUES (703, 'Sandra', 'Bautista', 'sB@scott.com', '912643311', '1994-11-11', 'AC_ACCOUNT', 8300, NULL, 702, 70);

UPDATE departamento SET id_director=702 WHERE nombre_departamento='Contabilidad';   

INSERT INTO historial_trab (id_empleado, fecha_inicio, fecha_fin, id_trabajo, id_departamento)
  VALUES (101, '1989-09-21', '1993-10-27', 'AC_ACCOUNT',  70);  
INSERT INTO historial_trab (id_empleado, fecha_inicio, fecha_fin, id_trabajo, id_departamento)
  VALUES (101, '1993-10-28', '1997-03-15', 'AC_MGR',  70);  
 
/*RRHH      */
INSERT INTO departamento (id_departamento, nombre_departamento, id_director, id_localizacion)
  VALUES (80, 'Recursos Humanos', NULL, 1000);
  
/*categorías profesionales*/
INSERT INTO categoria_prof (id_cat_prof, min_salario, max_salario)
  VALUES ('A', 1000, 2999);
INSERT INTO categoria_prof (id_cat_prof, min_salario, max_salario)
  VALUES ('B', 3000, 5999);
INSERT INTO categoria_prof (id_cat_prof, min_salario, max_salario)
  VALUES ('C', 6000, 9999);
INSERT INTO categoria_prof (id_cat_prof, min_salario, max_salario)
  VALUES ('D', 10000, 14999);
INSERT INTO categoria_prof (id_cat_prof, min_salario, max_salario)
  VALUES ('E', 15000, 24999);
INSERT INTO categoria_prof (id_cat_prof, min_salario, max_salario)
  VALUES ('F', 25000, 40000);


  
  
  
  


  
  
  
  
  
  
  

  
         