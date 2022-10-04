-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema optica_mysql
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica_mysql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica_mysql` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_mysql`.`clientes` (
  `id_cliente` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `fecha_de_registro` DATE NULL,
  `recomendado_por_id_cliente` INT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;

USE `optica_mysql` ;

-- -----------------------------------------------------
-- Table `optica_mysql`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_mysql`.`empleados` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `nombre` (`nombre` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica_mysql`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_mysql`.`proveedores` (
  `id_proveedor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `dirección` VARCHAR(60) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `fax` VARCHAR(20) NULL DEFAULT NULL,
  `NIF` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE INDEX `nombre` (`nombre` ASC),
  UNIQUE INDEX `NIF` (`NIF` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica_mysql`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_mysql`.`ventas` (
  `id_venta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cliente` INT UNSIGNED NULL DEFAULT NULL,
  `id_empleado` INT UNSIGNED NULL DEFAULT NULL,
  `clientes_id_cliente` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `id_cliente` (`id_cliente` ASC) ,
  INDEX `id_empleado` (`id_empleado` ASC) ,
  INDEX `fk_ventas_clientes1_idx` (`clientes_id_cliente` ASC),
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mysql_optica`.`clientes` (`id_cliente`),
  CONSTRAINT `ventas_ibfk_3`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `optica_mysql`.`empleados` (`id_empleado`),
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_id_cliente`)
    REFERENCES `mydb`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `optica_mysql`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica_mysql`.`gafas` (
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
  INDEX `id_proveedor` (`id_proveedor` ASC) ,
  INDEX `fk_gafas_ventas1_idx` (`ventas_id_venta` ASC) ,
  CONSTRAINT `gafas_ibfk_1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `optica_mysql`.`proveedores` (`id_proveedor`),
  CONSTRAINT `fk_gafas_ventas1`
    FOREIGN KEY (`ventas_id_venta`)
    REFERENCES `optica_mysql`.`ventas` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `optica_mysql` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
