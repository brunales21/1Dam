INSERT INTO `Conciertos`.`Instrumento` (`id_Instrumento`, `nombre`) VALUES 
	(1, 'Piano'),
	(2, 'Violín'),
	(3, 'Viola'),
	(4, 'Violonchelo'),
	(5, 'Contrabajo'),
	(6, 'Flauta'),
	(7, 'Oboe'),
	(8, 'Clarinet'),
	(9, 'Fagot'),
	(10, 'Trompeta'),
	(11, 'Trombón'),
	(12, 'Tuba'),
	(13, 'Corno francés'),
	(14, 'Guitarra'),
	(15, 'Arpa'),
	(16, 'Timbales'),
	(17, 'Batería'),
	(18, 'Órgano'),
	(19, 'Clavecín'),
	(20, 'Xilófono');
    
    
INSERT INTO `Conciertos`.`Musico` (`id_Musico`, `nombre`, `apellido`, `id_Instrumento`) VALUES 
(1, 'Ludwig', 'van Beethoven', 1),
(2, 'Johann Sebastian', 'Bach', 19),
(3, 'Wolfgang Amadeus', 'Mozart', 1),
(4, 'Antonio', 'Vivaldi', 2),
(5, 'Franz', 'Schubert', 1),
(6, 'Johannes', 'Brahms', 3),
(7, 'Felix', 'Mendelssohn', 2),
(8, 'George', 'Gershwin', 1),
(9, 'Richard', 'Wagner', 4),
(10, 'Gustav', 'Mahler', 5),
(11, 'Claude', 'Debussy', 6),
(12, 'Igor', 'Stravinsky', 7),
(13, 'Maurice', 'Ravel', 6),
(14, 'Pyotr Ilyich', 'Tchaikovsky', 2),
(15, 'Niccolò', 'Paganini', 2),
(16, 'Sergei', 'Rachmaninoff', 1),
(17, 'Frédéric', 'Chopin', 1),
(18, 'Giovanni', 'Pierluigi da Palestrina', 19),
(19, 'Georg Friedrich', 'Händel', 18),
(20, 'Johann', 'Strauss II', 4),
(21, 'Aaron', 'Copland', 8),
(22, 'Béla', 'Bartók', 10),
(23, 'Arnold', 'Schoenberg', 11),
(24, 'Antonín', 'Dvořák', 3),
(25, 'Modest', 'Mussorgsky', 2),
(26, 'Gioachino', 'Rossini', 13),
(27, 'Giuseppe', 'Verdi', 13),
(28, 'Jules', 'Massenet', 15),
(29, 'Camille', 'Saint-Saëns', 4),
(30, 'Léo', 'Delibes', 15),
(31, 'Giacomo', 'Puccini', 13),
(32, 'Luciano', 'Pavarotti', 13),
(33, 'Enrico', 'Caruso', 13),
(34, 'Maria', 'Callas', 6),
(35, 'Yo-Yo', 'Ma', 4),
(36, 'Itzhak', 'Perlman', 2),
(37, 'Anne-Sophie', 'Mutter', 3),
(38, 'Daniel', 'Barenboim', 1),
(39, 'Martha', 'Argerich', 1),
(40, 'Lang', 'Lang', 1),
(41, 'Nigel', 'Kennedy', 2),
(42, 'Joshua', 'Bell', 2),
(43, 'Hilary', 'Hahn', 2),
(44, 'James', 'Galway', 6),
(45, 'Jean-Pierre', 'Rampal', 6);


INSERT INTO `Conciertos`.`Concierto` (`id_Concierto`, `fecha`, `sala`) VALUES 
(1, '2023-03-10 20:00:00', 'Sinfónica 1'),
(2, '2023-04-15 19:30:00', 'Cámara'),
(3, '2023-05-01 18:00:00', 'Audición'),
(4, '2023-06-05 20:00:00', 'Sinfónica 2'),
(5, '2023-07-08 19:30:00', 'Cámara'),
(6, '2023-08-12 18:00:00', 'Audición'),
(7, '2023-09-17 20:00:00', 'Sinfónica 1'),
(8, '2023-10-20 19:30:00', 'Cámara'),
(9, '2023-11-23 18:00:00', 'Audición'),
(10, '2024-01-15 20:00:00', 'Sinfónica 2'),
(11, '2024-02-18 19:30:00', 'Cámara'),
(12, '2024-03-22 18:00:00', 'Audición'),
(13, '2024-04-25 20:00:00', 'Sinfónica 1'),
(14, '2024-05-28 19:30:00', 'Cámara'),
(15, '2024-06-30 18:00:00', 'Audición');

INSERT INTO `Conciertos`.`Participa` (`id_Musico`, `id_Concierto`) VALUES 
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(31, 3),
(32, 3),
(33, 3),
(34, 3),
(35, 3),
(36, 3),
(37, 3),
(38, 3),
(39, 3),
(40, 3),
(41, 3),
(42, 3),
(43, 3),
(44, 3),
(45, 3),
(16, 4),
(27, 4),
(38, 4),
(9, 4),
(10, 4),
(11, 4),
(22, 4),
(33, 4),
(14, 4),
(15, 4),
(26, 4),
(37, 4),
(8, 4),
(29, 4),
(20, 4),
(21, 5),
(22, 5),
(23, 5),
(24, 5),
(25, 5),
(36, 5),
(7, 5),
(18, 5),
(9, 5),
(30, 5),
(31, 5),
(42, 5),
(43, 5),
(44, 5),
(45, 5),
(16, 6),
(37, 6),
(28, 6),
(19, 6),
(40, 6);


INSERT INTO `Conciertos`.`Participa` (`id_Musico`, `id_Concierto`) VALUES 
(13, 7),
(23, 7),
(33, 7),
(43, 7),
(35, 7),
(36, 7),
(37, 7),
(38, 7),
(39, 7),
(10, 7),
(11, 7),
(12, 7),
(26, 7),
(14, 7),
(15, 7),
(36, 8),
(17, 8),
(28, 8),
(39, 8),
(24, 8),
(26, 8),
(27, 8),
(13, 8),
(14, 8),
(15, 8),
(16, 8),
(37, 8),
(38, 8),
(19, 8),
(34, 8),
(31, 9),
(32, 9),
(33, 9),
(34, 9),
(35, 9),
(27, 9),
(37, 9),
(38, 9),
(19, 9),
(40, 9),
(11, 9),
(12, 9),
(13, 9),
(14, 9),
(15, 9),
(36, 10),
(17, 10),
(28, 10),
(29, 10),
(1, 10),
(21, 10),
(32, 10),
(43, 10),
(14, 10),
(15, 10),
(26, 10),
(37, 10),
(18, 10),
(19, 10),
(10, 10),
(11, 11),
(32, 11),
(33, 11),
(34, 11),
(35, 11),
(26, 11),
(17, 11),
(8, 11),
(9, 11),
(36, 11),
(1, 11),
(2, 11),
(3, 11),
(4, 11),
(45, 11),
(16, 12),
(37, 12),
(28, 12),
(19, 12),
(40, 12);


INSERT INTO `Conciertos`.`Compositor` (`id_Compositor`, `nombre`, `apellido`, `nacionalidad`) VALUES 
(1, 'Johann Sebastian', 'Bach', 'Alemania'),
(2, 'Wolfgang Amadeus', 'Mozart', 'Austria'),
(3, 'Ludwig van', 'Beethoven', 'Alemania'),
(4, 'Franz', 'Schubert', 'Austria'),
(5, 'Frédéric', 'Chopin', 'Polonia'),
(6, 'Johannes', 'Brahms', 'Alemania'),
(7, 'Giuseppe', 'Verdi', 'Italia'),
(8, 'Richard', 'Wagner', 'Alemania'),
(9, 'Antonín', 'Dvořák', 'República Checa'),
(10, 'Giacomo', 'Puccini', 'Italia'),
(11, 'Gustav', 'Mahler', 'Austria'),
(12, 'Claude', 'Debussy', 'Francia'),
(13, 'Maurice', 'Ravel', 'Francia'),
(14, 'Igor', 'Stravinsky', 'Rusia'),
(15, 'Sergei', 'Rachmaninoff', 'Rusia'),
(16, 'Arnold', 'Schoenberg', 'Austria'),
(17, 'Alban', 'Berg', 'Austria'),
(18, 'Anton', 'Webern', 'Austria'),
(19, 'Béla', 'Bartók', 'Hungría'),
(20, 'Sergei', 'Prokofiev', 'Rusia');

-- INSERCIONES BACH
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(10, 'Tocata y Fuga en Re Menor, BWV 565', '1707', 1),
(11, 'Concierto de Brandenburgo n.º 3, BWV 1048', '1718', 1),
(12, 'El clave bien temperado, Libro 1, BWV 846-869', '1722', 1),
(13, 'Misa en si menor, BWV 232', '1749', 1),
(14, 'Pasión según San Mateo, BWV 244', '1727', 1),
(15, 'Suites para violonchelo solo, BWV 1007-1012', '1723', 1);

-- INSERCIONES MOZART
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(20, 'Sinfonía n.º 41, K. 551', '1788', 2),
(21, 'Concierto para clarinete, K. 622', '1791', 2),
(22, 'Requiem en re menor, K. 626', '1791', 2),
(23, 'Concierto para piano n.º 21, K. 467', '1785', 2),
(24, 'Don Giovanni, K. 527', '1787', 2);

-- INSERCIONES BETHOVEEN
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(30, 'Sinfonía n.º 5 en do menor, Op. 67', '1808', 3),
(31, 'Sonata para piano n.º 14(Claro de luna)', '1801', 3),
(32, 'Concierto para piano n.º 5, (Emperador)', '1811', 3),
(33, 'Sinfonía n.º 9 en re menor, Op. 125 (Coral)', '1824', 3),
(34, 'Sonata para piano n.º 8, Op. 13 (Patética)', '1798', 3),
(35, 'Cuartetos de cuerdas, Op. 59 (Razumovsky)', '1806', 3);


-- INSERCIONES SCHUBERT
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(40, 'Sinfonía n.º 8 en si menor(Incompleta)', '1822', 4),
(41, 'Cuarteto de cuerda 14 en re menor, D. 810', '1824', 4);

-- INSERCIONES CHOPIN
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(50, 'Sinfonía n.º 8 en si menor(Incompleta)', '1822', 5),
(51, 'Cuarteto de cuerda 14 en re menor, D. 810', '1824', 5);

-- INSERCIONES BRAHMS
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(60, 'Sinfonía n.º 1 en do menor, Op. 68', '1876', 6),
(61, 'Concierto para piano n.º 2, Op. 83', '1881', 6);

-- INSERCIONES VERDI
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(70, 'La traviata', '1853', 7),
(71, 'Aida', '1871', 7);

-- INSERCIONES WAGNER
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(80, 'El anillo del Nibelungo', '1876', 8),
(81, 'Tristán e Isolda', '1859', 8);

-- INSERCIONES DVORAK
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(90, 'Sinfonía del Nuevo Mundo', '1893', 9),
(91, 'Concierto para violín en La menor', '1879', 9);

-- INSERCIONES PUCCINI
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(100, 'La Bohème', '1896', 10),
(101, 'Madama Butterfly', '1904', 10);

-- INSERCIONES MAHLER
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(110, 'Sinfonía No. 5', '1902', 11),
(111, 'Sinfonía No. 9', '1910', 11);

-- INSERCIONES STRAVINSKI
INSERT INTO `Conciertos`.`Obra` (`id_Obra`, `nombre`, `anio`, `id_Compositor`) VALUES 
(140, 'La consagración de la primavera', '1913', 14),
(141, 'El pájaro de fuego', '1910', 14);

INSERT INTO `Conciertos`.`Interpreta` (`id_Concierto`, `id_Obra`) VALUES 
(1, 14),
(1, 11),
(1, 12),
(2, 50),
(2, 60),
(3, 70),
(3, 71),
(3, 140),
(4, 33),
(5, 12),
(5, 23),
(5, 30),
(6, 51),
(7, 34),
(7, 31),
(8, 34),
(8, 20),
(9, 21),
(10, 71),
(10, 70),
(11, 100),
(12, 101),
(13, 31),
(13, 32),
(13, 33),
(13, 34),
(13, 35),
(14, 141),
(15, 35),
(15, 15);
