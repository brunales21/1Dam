use  biblioteca_nacional;


insert into autor(dni, nombre, apellido1, apellido2, fecha_de_nacimiento) values("12345678A", "Juan", "Garcia", "Lopez", "2000-05-12");
insert into autor(dni, nombre, apellido1, apellido2, fecha_de_nacimiento) values("87654321B", "Maria", "Rodriguez", "Perez", "1995-02-01");
insert into autor(dni, nombre, apellido1, apellido2, fecha_de_nacimiento) values("98765432C", "Pedro", "Martinez", "Sanchez", "1990-09-15");


insert into libro(isbn, titulo_libro, idioma, año_publicacion) values("978-11-11111-11-1", "Don Quijote de la Mancha", "Español", "1605-01-01");
insert into libro(isbn, titulo_libro, idioma, año_publicacion) values("978-22-22222-22-2", "El Principito", "Español", "1943-04-06");
insert into libro(isbn, titulo_libro, idioma, año_publicacion) values("978-33-33333-33-3", "Cien años de soledad", "Español", "1967-05-01");


insert into editorial (nombre_editorial, codigo_editorial, telefono) values("Anaya", "102", "914578236");
insert into editorial (nombre_editorial, codigo_editorial, telefono) values("Santillana", "103", "918573924");
insert into editorial (nombre_editorial, codigo_editorial, telefono) values("Oxford", "104", "914563258");


insert into publica (dni, isbn, nombre_editorial, codigo_editorial) values("12345678A", "978-11-11111-11-1", "Anaya", "102");
insert into publica (dni, isbn, nombre_editorial, codigo_editorial) values("87654321B", "978-22-22222-22-2", "Santillana", "103");
insert into publica (dni, isbn, nombre_editorial, codigo_editorial) values("98765432C", "978-33-33333-33-3", "Oxford", "104");
