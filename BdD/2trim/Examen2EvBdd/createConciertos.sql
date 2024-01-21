-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Conciertos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Conciertos` ;

-- -----------------------------------------------------
-- Schema Conciertos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Conciertos` DEFAULT CHARACTER SET utf8 ;
USE `Conciertos` ;

-- -----------------------------------------------------
-- Table `Conciertos`.`Instrumento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Conciertos`.`Instrumento` ;

CREATE TABLE IF NOT EXISTS `Conciertos`.`Instrumento` (
  `id_Instrumento` INT NOT NULL,
  `nombre` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id_Instrumento`),
  UNIQUE INDEX `id_UNIQUE` (`id_Instrumento` ASC) ,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) );


-- -----------------------------------------------------
-- Table `Conciertos`.`Musico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Conciertos`.`Musico` ;

CREATE TABLE IF NOT EXISTS `Conciertos`.`Musico` (
  `id_Musico` INT NOT NULL,
  `nombre` VARCHAR(32) NOT NULL,
  `apellido` VARCHAR(32) NOT NULL,
  `id_Instrumento` INT NOT NULL,
  PRIMARY KEY (`id_Musico`),
  UNIQUE INDEX `id_UNIQUE` (`id_Musico` ASC) ,
  INDEX `fk_Musico_Instrumento_idx` (`id_Instrumento` ASC) ,
  CONSTRAINT `fk_Musico_Instrumento`
    FOREIGN KEY (`id_Instrumento`)
    REFERENCES `Conciertos`.`Instrumento` (`id_Instrumento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Conciertos`.`Concierto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Conciertos`.`Concierto` ;

CREATE TABLE IF NOT EXISTS `Conciertos`.`Concierto` (
  `id_Concierto` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `sala` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id_Concierto`),
  UNIQUE INDEX `id_UNIQUE` (`id_Concierto` ASC) );


-- -----------------------------------------------------
-- Table `Conciertos`.`Participa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Conciertos`.`Participa` ;

CREATE TABLE IF NOT EXISTS `Conciertos`.`Participa` (
  `id_Musico` INT NOT NULL,
  `id_Concierto` INT NOT NULL,
  PRIMARY KEY (`id_Musico`, `id_Concierto`),
  INDEX `fk_Participa_Concierto1_idx` (`id_Concierto` ASC) ,
  CONSTRAINT `fk_Participa_Musico1`
    FOREIGN KEY (`id_Musico`)
    REFERENCES `Conciertos`.`Musico` (`id_Musico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participa_Concierto1`
    FOREIGN KEY (`id_Concierto`)
    REFERENCES `Conciertos`.`Concierto` (`id_Concierto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Conciertos`.`Compositor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Conciertos`.`Compositor` ;

CREATE TABLE IF NOT EXISTS `Conciertos`.`Compositor` (
  `id_Compositor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `nacionalidad` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Compositor`),
  UNIQUE INDEX `id_Compositor_UNIQUE` (`id_Compositor` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Conciertos`.`Obra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Conciertos`.`Obra` ;

CREATE TABLE IF NOT EXISTS `Conciertos`.`Obra` (
  `id_Obra` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `anio` SMALLINT(4) NULL,
  `id_Compositor` INT NOT NULL,
  PRIMARY KEY (`id_Obra`),
  UNIQUE INDEX `id_UNIQUE` (`id_Obra` ASC) ,
  INDEX `fk_Obra_Compositor1_idx` (`id_Compositor` ASC) ,
  CONSTRAINT `fk_Obra_Compositor1`
    FOREIGN KEY (`id_Compositor`)
    REFERENCES `Conciertos`.`Compositor` (`id_Compositor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Conciertos`.`Interpreta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Conciertos`.`Interpreta` ;

CREATE TABLE IF NOT EXISTS `Conciertos`.`Interpreta` (
  `id_Concierto` INT NOT NULL,
  `id_Obra` INT NOT NULL,
  PRIMARY KEY (`id_Concierto`, `id_Obra`),
  INDEX `fk_Interpreta_Obra1_idx` (`id_Obra` ASC) ,
  CONSTRAINT `fk_Interpreta_Concierto1`
    FOREIGN KEY (`id_Concierto`)
    REFERENCES `Conciertos`.`Concierto` (`id_Concierto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Interpreta_Obra1`
    FOREIGN KEY (`id_Obra`)
    REFERENCES `Conciertos`.`Obra` (`id_Obra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;