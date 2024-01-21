DROP database IF EXISTS pokedex;
CREATE database IF NOT EXISTS pokedex CHARACTER SET utf8mb4;
USE pokedex;

CREATE TABLE pokemon (
    id_pokemon INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    descripcion VARCHAR(200),
    peso DECIMAL(4, 1),
    altura DECIMAL(3, 1),
    metodo_evolucion ENUM('Nivel', 'Felicidad', 'Intercambio', 'Piedra fuego', 'Piedra lunar', 'Piedra trueno', 'Piedra solar', 'Piedra agua', 'Piedra hoja'),
    id_pre_evolucion INTEGER,
    CONSTRAINT pokemon_pk PRIMARY KEY (id_pokemon),
    CONSTRAINT pokemon_fk1 FOREIGN KEY (id_pre_evolucion)
        REFERENCES pokemon (id_pokemon)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE entrenadores (
    id_entrenador INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20),
    medallas INT UNSIGNED,
    rango VARCHAR(20),
    especialidad VARCHAR(40),
    CONSTRAINT entrenadores_pk PRIMARY KEY (id_entrenador)
);

CREATE TABLE captura (
    id_pokemon INT,
    id_entrenador INT,
    tipo_pokeball ENUM ('Poke Ball', 'Super Ball', 'Ultra Ball', 'Great Ball', 'Master Ball'),
    fecha_captura DATE,
    CONSTRAINT captura_pk PRIMARY KEY (id_pokemon , id_entrenador),
    CONSTRAINT captura_fk1 FOREIGN KEY (id_pokemon)
        REFERENCES pokemon (id_pokemon)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT captura_fk2 FOREIGN KEY (id_entrenador)
        REFERENCES entrenadores (id_entrenador)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tipos (
    id_tipo VARCHAR(2) NOT NULL,
    nombre VARCHAR(9) NOT NULL,
    CONSTRAINT tipos_pk PRIMARY KEY (id_tipo)
);

CREATE TABLE tiene_tipo (
    id_pokemon INT,
    id_tipo VARCHAR(2),
    CONSTRAINT tiene_tipo_pk PRIMARY KEY (id_pokemon , id_tipo),
    CONSTRAINT tiene_tipo_fk1 FOREIGN KEY (id_pokemon)
        REFERENCES pokemon (id_pokemon)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT tiene_tipo_fk2 FOREIGN KEY (id_tipo)
        REFERENCES tipos (id_tipo)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ventaja (
    id_atacante VARCHAR(2),
    id_defensor VARCHAR(2),
    /* tres posibles valores:
		1 : el atacante tiene ventaja.
		0 : no hay ningún efecto.
		-1 : el atacante está en desventaja.
    */
    efecto SMALLINT,
    CONSTRAINT ventaja_pk PRIMARY KEY (id_atacante , id_defensor),
    CONSTRAINT efecto_limites CHECK (efecto <= 1), CHECK (efecto >= -1),
    CONSTRAINT ventaja_fk1 FOREIGN KEY (id_atacante)
        REFERENCES tipos (id_tipo)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ventaja_fk2 FOREIGN KEY (id_defensor)
        REFERENCES tipos (id_tipo)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE regiones (
    id_region VARCHAR(2) NOT NULL,
    nombre VARCHAR(7) NOT NULL,
    CONSTRAINT regiones_pk PRIMARY KEY (id_region)
);

CREATE TABLE localizaciones (
    id_localizacion INT AUTO_INCREMENT NOT NULL,
    id_region VARCHAR(2),
    nombre VARCHAR(20) NOT NULL,
    CONSTRAINT localizaciones_pk PRIMARY KEY (id_localizacion),
    CONSTRAINT localizaciones_fk FOREIGN KEY (id_region)
        REFERENCES regiones (id_region)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE vive (
    id_pokemon INT,
    id_localizacion INT,
    CONSTRAINT vive_pk PRIMARY KEY (id_pokemon , id_localizacion),
    CONSTRAINT vive_fk1 FOREIGN KEY (id_pokemon)
        REFERENCES pokemon (id_pokemon)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT vive_fk2 FOREIGN KEY (id_localizacion)
        REFERENCES localizaciones (id_localizacion)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE habilidades (
    id_habilidad INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    descripcion VARCHAR(130),
    CONSTRAINT habilidades_pk PRIMARY KEY (id_habilidad)
);

CREATE TABLE tiene_habilidad (
    id_pokemon INT,
    id_habilidad INT,
    CONSTRAINT tiene_habilidad_pk PRIMARY KEY (id_pokemon , id_habilidad),
    CONSTRAINT tiene_habilidad_fk1 FOREIGN KEY (id_pokemon)
        REFERENCES pokemon (id_pokemon)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT tiene_habilidad_fk2 FOREIGN KEY (id_habilidad)
        REFERENCES habilidades (id_habilidad)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE movimientos (
    id_movimiento INT NOT NULL,
    nombre VARCHAR(15) NOT NULL,
    poder INT,
    prec INT,
    pp INT,
    efecto VARCHAR(120),
    id_tipo VARCHAR(2),
    CONSTRAINT movimientos_pk PRIMARY KEY (id_movimiento),
    CONSTRAINT movimientos_pk1 FOREIGN KEY (id_tipo)
        REFERENCES tipos (id_tipo)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE aprende (
    id_pokemon INT,
    id_movimiento INT,
    CONSTRAINT aprende_pk PRIMARY KEY (id_pokemon , id_movimiento),
    CONSTRAINT aprende_fk1 FOREIGN KEY (id_pokemon)
        REFERENCES pokemon (id_pokemon)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT aprende_fk2 FOREIGN KEY (id_movimiento)
        REFERENCES movimientos (id_movimiento)
        ON DELETE CASCADE ON UPDATE CASCADE
);