-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema b'pizzeria1'
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria_mysql
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria_mysql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria_mysql` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincias` (
  `id_provincia` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidades` (
  `id_localidad` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `id_provincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_localidad`),
  INDEX `id_provincia` (`id_provincia` ASC),
  CONSTRAINT `localidades_ibfk_1`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria`.`provincias` (`id_provincia`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `apellido` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `id_localidad` INT UNSIGNED NOT NULL,
  `id_provincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `id_provincia` (`id_provincia` ASC),
  INDEX `id_localidad` (`id_localidad` ASC),
  CONSTRAINT `clientes_ibfk_1`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria`.`provincias` (`id_provincia`),
  CONSTRAINT `clientes_ibfk_2`
    FOREIGN KEY (`id_localidad`)
    REFERENCES `pizzeria`.`localidades` (`id_localidad`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `id_tienda` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `id_localidad` INT UNSIGNED NOT NULL,
  `id_provincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_tienda`),
  INDEX `id_provincia` (`id_provincia` ASC),
  INDEX `id_localidad` (`id_localidad` ASC),
  CONSTRAINT `tiendas_ibfk_1`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria`.`provincias` (`id_provincia`),
  CONSTRAINT `tiendas_ibfk_2`
    FOREIGN KEY (`id_localidad`)
    REFERENCES `pizzeria`.`localidades` (`id_localidad`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `apellido` VARCHAR(20) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `id_tienda` INT UNSIGNED NULL DEFAULT NULL,
  `ocupacion` ENUM('repartidor', 'cocinero') NOT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `id_tienda` (`id_tienda` ASC),
  CONSTRAINT `empleados_ibfk_1`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tiendas` (`id_tienda`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `id_pedido` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cliente` INT UNSIGNED NOT NULL,
  `fecha_hora_pedido` DATETIME NOT NULL,
  `tipo` ENUM('reparto a domicilio', 'recogida en el local') NOT NULL,
  `cantidad_productos` INT NOT NULL,
  `id_tienda` INT UNSIGNED NOT NULL,
  `precio` INT NOT NULL,
  `id_repartidor` INT UNSIGNED NULL DEFAULT NULL,
  `fecha_hora_entrega` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `id_repartidor` (`id_repartidor` ASC),
  INDEX `id_cliente` (`id_cliente` ASC),
  INDEX `id_tienda` (`id_tienda` ASC),
  CONSTRAINT `pedidos_ibfk_1`
    FOREIGN KEY (`id_repartidor`)
    REFERENCES `pizzeria`.`empleados` (`id_empleado`),
  CONSTRAINT `pedidos_ibfk_2`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `pizzeria`.`clientes` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_3`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tiendas` (`id_tienda`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (
  `id_categoria` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`tipo_de_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tipo_de_productos` (
  `id_producto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  `id_categoria_pizza` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `id_categoria_pizza` (`id_categoria_pizza` ASC),
  CONSTRAINT `tipo_de_productos_ibfk_1`
    FOREIGN KEY (`id_categoria_pizza`)
    REFERENCES `pizzeria`.`pizzas` (`id_categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `pizzeria_mysql` ;

-- -----------------------------------------------------
-- Table `pizzeria_mysql`.`provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_mysql`.`provincias` (
  `id_provincia` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_mysql`.`localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_mysql`.`localidades` (
  `id_localidad` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `id_provincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_localidad`),
  INDEX `id_provincia` (`id_provincia` ASC),
  CONSTRAINT `localidades_ibfk_1`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria_mysql`.`provincias` (`id_provincia`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_mysql`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_mysql`.`clientes` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `apellido` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `id_localidad` INT UNSIGNED NOT NULL,
  `id_provincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `id_provincia` (`id_provincia` ASC),
  INDEX `id_localidad` (`id_localidad` ASC),
  CONSTRAINT `clientes_ibfk_1`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria_mysql`.`provincias` (`id_provincia`),
  CONSTRAINT `clientes_ibfk_2`
    FOREIGN KEY (`id_localidad`)
    REFERENCES `pizzeria_mysql`.`localidades` (`id_localidad`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_mysql`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_mysql`.`tiendas` (
  `id_tienda` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `id_localidad` INT UNSIGNED NOT NULL,
  `id_provincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_tienda`),
  INDEX `id_provincia` (`id_provincia` ASC),
  INDEX `id_localidad` (`id_localidad` ASC),
  CONSTRAINT `tiendas_ibfk_1`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria_mysql`.`provincias` (`id_provincia`),
  CONSTRAINT `tiendas_ibfk_2`
    FOREIGN KEY (`id_localidad`)
    REFERENCES `pizzeria_mysql`.`localidades` (`id_localidad`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_mysql`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_mysql`.`empleados` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `apellido` VARCHAR(20) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `id_tienda` INT UNSIGNED NULL DEFAULT NULL,
  `ocupacion` ENUM('repartidor', 'cocinero') NOT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `id_tienda` (`id_tienda` ASC),
  CONSTRAINT `empleados_ibfk_1`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria_mysql`.`tiendas` (`id_tienda`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_mysql`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_mysql`.`pizzas` (
  `id_categoria` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_mysql`.`tipo_de_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_mysql`.`tipo_de_productos` (
  `id_producto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  `id_categoria_pizza` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `id_categoria_pizza` (`id_categoria_pizza` ASC),
  CONSTRAINT `tipo_de_productos_ibfk_1`
    FOREIGN KEY (`id_categoria_pizza`)
    REFERENCES `pizzeria_mysql`.`pizzas` (`id_categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria_mysql`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria_mysql`.`pedidos` (
  `id_pedido` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cliente` INT UNSIGNED NOT NULL,
  `fecha_hora_pedido` DATETIME NOT NULL,
  `tipo` ENUM('reparto a domicilio', 'recogida en el local') NOT NULL,
  `cantidad_productos` INT NOT NULL,
  `id_producto` INT UNSIGNED NOT NULL,
  `id_tienda` INT UNSIGNED NOT NULL,
  `precio` INT NOT NULL,
  `id_repartidor` INT UNSIGNED NULL DEFAULT NULL,
  `fecha_hora_entrega` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `id_repartidor` (`id_repartidor` ASC),
  INDEX `id_cliente` (`id_cliente` ASC),
  INDEX `id_tienda` (`id_tienda` ASC) ,
  INDEX `id_producto` (`id_producto` ASC),
  CONSTRAINT `pedidos_ibfk_1`
    FOREIGN KEY (`id_repartidor`)
    REFERENCES `pizzeria_mysql`.`empleados` (`id_empleado`),
  CONSTRAINT `pedidos_ibfk_2`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `pizzeria_mysql`.`clientes` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_3`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria_mysql`.`tiendas` (`id_tienda`),
  CONSTRAINT `pedidos_ibfk_4`
    FOREIGN KEY (`id_producto`)
    REFERENCES `pizzeria_mysql`.`tipo_de_productos` (`id_producto`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
