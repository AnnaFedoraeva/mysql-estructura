DROP DATABASE IF EXISTS mysql_optica;
CREATE DATABASE mysql_optica CHARACTER SET utf8mb4;
USE mysql_optica;


CREATE TABLE Proveedores (
id_proveedor INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(60) UNIQUE NOT NULL, 
dirección VARCHAR(60) NOT NULL, 
telefono VARCHAR(9) NOT NULL, 
fax VARCHAR(20), 
NIF VARCHAR(12) UNIQUE NOT NULL
);
    
CREATE TABLE Gafas (
id_gafas INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_proveedor INTEGER UNSIGNED,
marca VARCHAR(45) NOT NULL,
graduacion_izq FLOAT NOT NULL,
graduacion_der FLOAT NOT NULL,
tipo_montura ENUM('flotante', 'pasta','metalica') NOT NULL,
color_montura VARCHAR(10) NOT NULL, 
color_cristal VARCHAR(20) NOT NULL,
precio FLOAT NOT NULL,
FOREIGN KEY (id_proveedor) REFERENCES Proveedores (id_proveedor)
);

CREATE TABLE Clientes (
	id_cliente INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) UNIQUE,
    direccion_postal VARCHAR(45),
    telefono VARCHAR(9),
    correo_electronico VARCHAR(20),
    fecha_de_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    recomendado_por_id_cliente INTEGER UNSIGNED,
    empleado VARCHAR(45) NOT NULL,
    id_gafas INTEGER UNSIGNED, 
    FOREIGN KEY (id_gafas) REFERENCES Gafas (id_gafas),
    KEY recomendado_por_id_cliente (id_cliente)
    );

/* Proveedores */
INSERT INTO Proveedores VALUES (1, 'Medical Beauty', 'CALLE ROSSELO 59, 08029, BARCELONA, ESPAÑA', '659445539', '932773433', 'B45692325');

/* Gafas */
INSERT INTO Gafas VALUES (1, '2', 'Rainbow', '-1.2', '-1', 'pasta', 'negro', 'transparente', 450.80);
INSERT INTO Gafas VALUES (2, '1', 'RainbowShow', '-3', '-1', 'flotante', 'gris', 'transparente', 434.80);
INSERT INTO Gafas VALUES (3, '2', 'RainbowSun', '2', '-1', 'metalica', 'azul', 'azul', 350);

/* Clientes */
INSERT INTO Clientes VALUES (1, 'Jordi Lopez', 'CALLE ROSSELO 168, 08029, BARCELONA, ESPAÑA', '659382432', 'jlopez@gmail.com', '2022-07-27', 2, 'Sara Veda', 3);
INSERT INTO Clientes VALUES (2, 'Olivia Gomez', 'CALLE MALLORCA 11, 08029, BARCELONA, ESPAÑA', '659382818', 'OLIV@gmail.com', '2022-07-28', 2, 'Sara Veda', 2);
INSERT INTO Clientes VALUES (3, 'Angela Cortez', 'CALLE ENTENZA 213, 08029, BARCELONA, ESPAÑA', '659382998', 'Aangela71@gmail.com', '2022-07-29', 3, 'Lisa Wu', 1);