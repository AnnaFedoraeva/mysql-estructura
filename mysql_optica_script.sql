-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mysql_optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mysql_optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mysql_optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mysql_optica` ;

-- -----------------------------------------------------
-- Table `mysql_optica`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_optica`.`proveedores` (
  `id_proveedor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `dirección` VARCHAR(60) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `fax` VARCHAR(20) NULL DEFAULT NULL,
  `NIF` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE INDEX `nombre` (`nombre` ASC),
  UNIQUE INDEX `NIF` (`NIF` ASC))
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mysql_optica`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_optica`.`empleados` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `nombre` (`nombre` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mysql_optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_optica`.`ventas` (
  `id_venta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cliente` INT UNSIGNED NULL DEFAULT NULL,
  `id_empleado` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `id_cliente` (`id_cliente` ASC),
  INDEX `id_empleado` (`id_empleado` ASC),
  CONSTRAINT `ventas_ibfk_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mysql_optica`.`clientes` (`id_cliente`),
  CONSTRAINT `ventas_ibfk_3`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `mysql_optica`.`empleados` (`id_empleado`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mysql_optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_optica`.`gafas` (
  `id_gafas` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_proveedor` INT UNSIGNED NULL DEFAULT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `graduacion_izq` FLOAT NOT NULL,
  `graduacion_der` FLOAT NOT NULL,
  `tipo_montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `color_montura` VARCHAR(10) NOT NULL,
  `color_cristal` VARCHAR(20) NOT NULL,
  `precio` FLOAT NOT NULL,
  `ventas_id_venta` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_gafas`),
  INDEX `id_proveedor` (`id_proveedor` ASC),
  INDEX `fk_gafas_ventas1_idx` (`ventas_id_venta` ASC),
  CONSTRAINT `gafas_ibfk_1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `mysql_optica`.`proveedores` (`id_proveedor`),
  CONSTRAINT `fk_gafas_ventas1`
    FOREIGN KEY (`ventas_id_venta`)
    REFERENCES `mysql_optica`.`ventas` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mysql_optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_optica`.`clientes` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NULL DEFAULT NULL,
  `direccion_postal` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(9) NULL DEFAULT NULL,
  `correo_electronico` VARCHAR(20) NULL DEFAULT NULL,
  `fecha_de_registro` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `recomendado_por_id_cliente` INT UNSIGNED NULL DEFAULT NULL,
  `id_empleado` INT UNSIGNED NULL DEFAULT NULL,
  `id_gafas` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `nombre` (`nombre` ASC),
  INDEX `id_gafas` (`id_gafas` ASC),
  INDEX `recomendado_por_id_cliente` (`id_cliente` ASC),
  INDEX `id_empleado` (`id_empleado` ASC),
  CONSTRAINT `clientes_ibfk_1`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `mysql_optica`.`gafas` (`id_gafas`),
  CONSTRAINT `clientes_ibfk_2`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `mysql_optica`.`empleados` (`id_empleado`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
